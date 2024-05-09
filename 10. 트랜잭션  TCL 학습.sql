DROP TABLE student;

-- ## 트랜잭션
CREATE TABLE student (
          id NUMBER PRIMARY KEY,
          name VARCHAR2(100),
          age NUMBER);
          
INSERT INTO student VALUES (1, '강길동', 15);
INSERT INTO student VALUES (2, '박수순', 14);

SELECT *
FROM student;

COMMIT;  -- 삭제 후 롤백시 돌아오는 상태

INSERT INTO student VALUES (3, '도우너', 12);

ROLLBACK;

-- ex) 계좌 이체 
UPDATE account
SET balance = balance + 5000
WHERE name = '강길동';

UPDATE account
SET balance = balance - 5000
WHERE name = '박영희';

COMMIT;  -- 계좌 이체 출금 & 입금 완료 후 커밋 !

-- DELETE <---> TRUNCATE
DELETE FROM student;  -- delete 학생 테이블 삭제
-- 커밋한 상태로 롤백 돌아가줌 ! 
ROLLBACK;

TRUNCATE TABLE student;   -- truncate 학생 테이블 삭제 시 되돌아갈 수 없음.

-- 오라클은 DDL 수행시 자동 커밋 / SQL Server는 자동 커밋이 안됨.