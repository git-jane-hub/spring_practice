/* basic */
CREATE TABLE users(
    username VARCHAR2(50) NOT NULL PRIMARY KEY,
    password VARCHAR2(100) NOT NULL,
    enabled CHAR(1) DEFAULT '1'
);
SELECT * FROM users;
SELECT password FROM users WHERE username = 'admin00';

CREATE TABLE authorities(
    username VARCHAR2(50) NOT NULL,
    authority VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_authorities_users FOREIGN KEY(username) REFERENCES USERS(username)
);
CREATE UNIQUE INDEX ix_auth_username ON authorities (username, authority);

SELECT * FROM authorities;

INSERT INTO users (username, password) VALUES ('user00', 'pw00');
INSERT INTO users (username, password) VALUES ('member00', 'pw00');
INSERT INTO users (username, password) VALUES ('admin00', 'pw00');

INSERT INTO authorities (username, authority) VALUES ('user00', 'ROLE_USER');
INSERT INTO authorities (username, authority) VALUES ('member00', 'ROLE_MANAGER');
INSERT INTO authorities (username, authority) VALUES ('admin00', 'ROLE_MANAGER');
INSERT INTO authorities (username, authority) VALUES ('admin00', 'ROLE_ADMIN');

/* custom */
CREATE TABLE member_tbl(
    userid VARCHAR2(50) NOT NULL PRIMARY KEY,
    userpw VARCHAR2(100) NOT NULL,
    username VARCHAR2(100) NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    updatedate DATE DEFAULT SYSDATE,
    enabled CHAR(1) DEFAULT '1'
);

SELECT * FROM member_tbl;

CREATE TABLE member_auth(
    userid VARCHAR2(50) NOT NULL,
    auth VARCHAR2(50) NOT NULL,
    CONSTRAINT fk_member_auth FOREIGN KEY(userid) REFERENCES member_tbl(userid)
);

COMMIT;
