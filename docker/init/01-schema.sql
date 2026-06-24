-- Jsp_drawing dev schema
CREATE DATABASE IF NOT EXISTS BBS;
USE BBS;

CREATE TABLE IF NOT EXISTS USER (
    userID    VARCHAR(50) PRIMARY KEY,
    userPw    VARCHAR(255) NOT NULL,
    userEmail VARCHAR(100),
    userGender VARCHAR(20),
    userName  VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS BBS (
    bbsID        INT AUTO_INCREMENT PRIMARY KEY,
    bbsTitle     VARCHAR(200),
    userID       VARCHAR(50),
    bbsDate      VARCHAR(50),
    bbsContent   TEXT,
    bbsAvailable INT DEFAULT 1
);
