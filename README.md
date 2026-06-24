# Jsp_drawing

JSP 기반 **게시판 + 실시간 채팅** 웹 애플리케이션입니다. 회원 가입·로그인, 글 CRUD, WebSocket 채팅을 제공합니다.

**Live:** [https://stargazyp.com/jsp-drawing/](https://stargazyp.com/jsp-drawing/main.jsp)

Repository: [github.com/StargazyP/Jsp_drawing](https://github.com/StargazyP/Jsp_drawing)

---

## 주요 기능

- **회원** — 회원가입, 로그인, 마이페이지(정보 수정·탈퇴)
- **게시판** — 글 목록·작성·상세·수정·삭제
- **실시간 채팅** — WebSocket 다중 사용자 채팅 (`chat.jsp`, `WsServer`)
- **반응형 UI** — Bootstrap 기반 레이아웃, 공통 `app.css`

## 사용 시나리오

1. 회원가입 후 로그인 → **게시판**에서 글 작성·조회
2. **채팅** 페이지에서 다른 사용자와 실시간 메시지 교환
3. 마이페이지에서 **프로필 수정**

## 서버 구성 (요약)

| 구성 | 기술 |
|------|------|
| App | Java 17, JSP/Servlet, Tomcat (WAR) |
| DB | MySQL (`BBS` 스키마) |
| 빌드 | Maven |
| 배포 | portfolio compose `jsp-drawing`, nginx `/jsp-drawing/` |

로컬 개발: `cp .env.example .env` → `docker compose up -d --build` (앱 http://localhost:8081/). DB 비밀번호는 `.env`에만 두세요.

## Changelog

- **2026-06-24** — README 기능 중심 정리, webhook CI/CD secrets 연동.
- **2026-06-02** — Live demo URL (stargazyp.com/jsp-drawing).
- **2026-05-27** — Docker/Tomcat·MySQL compose, UI·DAO 정리.
