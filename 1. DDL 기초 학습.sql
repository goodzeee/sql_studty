select * from tb_emp;

-- CREATE 테이블 생성 (DDL: 데이터 정의어)
-- 학생들의 성적정보를 저장할 데이터 구조
CREATE TABLE tbl_score (
    name VARCHAR2(4) NOT NULL,
    kor NUMBER(3) NOT NULL CHECK(kor >= 0 AND kor <= 100),
    eng NUMBER(3) NOT NULL CHECK(eng >= 0 AND eng <= 100),
    math NUMBER(3) NOT NULL CHECK(math >= 0 AND math <= 100),
    total NUMBER(3) NULL,
    average NUMBER(5, 2),
    grade CHAR(1),
    stu_num NUMBER(6) PRIMARY KEY
);

-- ALTER문으로 제약조건 추가하기 : CONSTRAINT
-- stu_num에 PRIMARY KEY 추가하기
ALTER TABLE tbl_score
ADD CONSTRAINT pk_tbl_score
PRIMARY KEY (stu_num);
-- pk를 제거
ALTER TABLE tbl_score
DROP CONSTRAINT pk_tbl_score;

SELECT * FROM tbl_score;

-- ALTER 컬럼 추가하기
ALTER TABLE tbl_score
ADD (sci NUMBER(3) NOT NULL);

-- 컬럼 삭제하기
ALTER TABLE tbl_score
DROP COLUMN sci;

-- DROP 테이블 제거하기 (강력한 제거 복구 안됨)
-- 테이블 복사 AS SELECT
CREATE TABLE tb_emp_copy
AS SELECT * FROM tb_emp;

DROP TABLE tb_emp_copy;
DROP TABLE tbl_score2;

SELECT * FROM tb_emp_copy; -- 삭제했으니 존재하지 않음

-- TRUNCATE : 휴지통 비우기 (구조는 남기고 안에 데이터만 삭제하여 테이블 초기상태로 돌아감)
TRUNCATE TABLE tb_emp_copy;

