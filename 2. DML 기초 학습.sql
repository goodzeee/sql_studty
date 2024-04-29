-- CREATE 테이블 생성
CREATE TABLE goods (
          id NUMBER (6) PRIMARY KEY,
          goods_name VARCHAR2 (10) NOT NULL,
          price NUMBER (10) DEFAULT 1000,
          reg_date DATE -- 날짜 연산은 문자 타입으로 숫자 X
);

-- INSERT 삽입
INSERT INTO goods
         (id, goods_name, price, reg_date) 
VALUES
          (1, '선풍기', 120000, SYSDATE);
          
INSERT INTO goods
         (id, goods_name, price, reg_date) 
VALUES
          (2, '세탁기', 2000000, SYSDATE);
          
INSERT INTO goods
         (id, goods_name, reg_date) 
VALUES
          (3, '달고나', SYSDATE);
          
INSERT INTO goods
         (id, goods_name) 
VALUES
          (4, '계란'); -- 12바이트
          
INSERT INTO goods
         (goods_name, id, reg_date, price) 
VALUES
          ('슬리퍼', 5, SYSDATE, '49000'); -- NUMBER '300' 문자처럼 사용 가능
          
INSERT INTO goods
-- 컬럼명 생략시 테이블 구조 순서대로 자동 기입됨.
VALUES
          (6, '냉장고', 5000000, SYSDATE);
SELECT * FROM goods;


-- UPDATE 갱신
UPDATE goods
SET goods_name = '에어컨'
WHERE id = 1;  -- where 조건절 갱신할 부분

-- where 조건절 없으면 해당 속성값 다 전체 갱신
UPDATE goods
SET price = 9999; -- DML은 취소해서 복구할 수 있음.

UPDATE tbl_user
SET age = age + 1;

UPDATE goods
SET id = 11
WHERE id = 4;

UPDATE goods
SET price = null
WHERE id = 3;

UPDATE goods
SET goods_name = '청바지', price = 59000
WHERE id = 3;
SELECT * FROM goods;


-- DELETE 삭제
-- 갱신과 동일하게 조건이 없으면 전체 삭제 다만 DML은 복구 가능
DELETE FROM goods
WHERE id = 11;
-- <삭제 SQL 3>
DELETE FROM goods;
TRUNCATE TABLE goods; -- 복구 불가
DROP TABLE goods; -- 제일 위험

SELECT * FROM goods;


-- SELECT 조회 기본
SELECT 
       certi_cd, certi_nm, issue_insti_nm -- 순서 바꿔서 조회 가능
FROM tb_certi;

SELECT 
       *       -- 속성 전체 조회
FROM tb_certi;
 
SELECT DISTINCT  -- 중복 제거
       certi_nm, issue_insti_nm  -- 원하는 속성만 뽑아서 조회
FROM tb_certi;

-- 열 별칭 부여 AS "문자"
SELECT
       emp_nm AS "사원명",
       addr AS "주소"
FROM tb_emp;

-- 별칭 AS "" 둘 다 생략 가능
SELECT
       emp_nm 사원명,
       addr "거주지 주소"   -- 띄어쓰기 있을 땐 " " 묶기
FROM tb_emp;

-- 문자열 결합하기 || -> + 결합 의미    /  별칭써서 속성명 바꿔주기
SELECT
       '자격증 : ' || certi_nm AS "자격증 종류"
FROM tb_certi;

SELECT
       certi_nm || ' ( ' || issue_insti_nm || ' ) '  AS "자격증 정보"
FROM tb_certi;