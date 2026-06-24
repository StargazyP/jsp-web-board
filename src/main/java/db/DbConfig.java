package db;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * DB connection for Docker/dev: reads from env MYSQL_HOST, MYSQL_PORT, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD.
 * Fallback: localhost:3306, BBS, root, (empty password) for local.
 */
public class DbConfig {
    private static final String HOST = System.getenv("MYSQL_HOST") != null ? System.getenv("MYSQL_HOST") : "localhost";
    private static final String PORT = System.getenv("MYSQL_PORT") != null ? System.getenv("MYSQL_PORT") : "3306";
    private static final String DATABASE = System.getenv("MYSQL_DATABASE") != null ? System.getenv("MYSQL_DATABASE") : "BBS";
    private static final String USER = System.getenv("MYSQL_USER") != null ? System.getenv("MYSQL_USER") : "root";
    private static final String PASSWORD = System.getenv("MYSQL_PASSWORD") != null ? System.getenv("MYSQL_PASSWORD") : "";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            return DriverManager.getConnection(url, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
