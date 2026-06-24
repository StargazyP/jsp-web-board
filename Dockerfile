# Build stage: Maven + Java 17
FROM maven:3.9-eclipse-temurin-17-alpine AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn package -DskipTests -B

# Run stage: Tomcat 9 + JDK 17
FROM tomcat:9.0-jdk17
# 게이트웨이 경로 /jsp-drawing/ 와 컨텍스트 일치 (WebSocket·상대경로 JSP)
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/JSPWEB.war /usr/local/tomcat/webapps/jsp-drawing.war

# Nginx 등 역프록시 뒤 HTTPS·외부 URL 인식 (첫 </Host> 직전에 RemoteIpValve 삽입)
COPY docker/remote-ip-valve.xml /tmp/remote-ip-valve.xml
RUN awk 'FNR==NR { v = v $0 ORS; next } index($0, "</Host>") > 0 && !done { printf "%s", v; done = 1 } { print }' /tmp/remote-ip-valve.xml /usr/local/tomcat/conf/server.xml > /tmp/server.xml.new \
    && mv /tmp/server.xml.new /usr/local/tomcat/conf/server.xml

EXPOSE 8080
CMD ["catalina.sh", "run"]
