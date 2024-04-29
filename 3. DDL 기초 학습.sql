
-- WHERE 조건절
-- 조회 행을 제한
SELECT
       emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd = 2;

-- PK로 필터링하면 무조건 1건 이하가 조회됨
SELECT
       emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE emp_no = 1000000005;

-- 비교 연산자
SELECT
       emp_no, emp_nm, addr, sex_cd
FROM tb_emp
WHERE sex_cd <> 2;    -- <> 2 : 2가 아닌 것

SELECT
       emp_no, emp_nm, addr, birth_de
FROM tb_emp
WHERE birth_de >= '19800101'    -- AND 그리고 
               AND birth_de <= '19891231';
               
SELECT
       emp_no, emp_nm, addr, birth_de
FROM tb_emp
WHERE NOT birth_de >= '19800101';   -- NOT 반대 조건  =  !

-- BETWEEN a AND b : a ~ b 사이 연산자
SELECT
       emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19800101'
               AND '19891231';
SELECT
       emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de NOT BETWEEN '19800101'
               AND '19891231';
              
-- IN 연산 : OR 연산
SELECT
       emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = 100002 OR dept_cd = 100007;  -- OR 또는

SELECT
       emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN (100002, 100007, 100008);   -- IN (출력할 모든 값 열거)

-- LIKE 검색에서 사용
-- 와일드카드 매핑 ( % : 0글자 이상, _ : 딱 1문자)
SELECT
       emp_no, emp_nm, addr
FROM tb_emp
WHERE addr  LIKE '%용인%';  -- 용인이 포함된 주소 출력

SELECT
       emp_no, emp_nm, addr
FROM tb_emp
WHERE emp_nm  LIKE '이%';  -- '이'로 시작하는 이름

SELECT
       emp_no, emp_nm, addr
FROM tb_emp
WHERE emp_nm  LIKE '이__'; --  _ only 한글자를 의미 !

SELECT
       emp_no, emp_nm, addr
FROM tb_emp
WHERE emp_nm  LIKE '%심';  -- 이름이 '-심'으로 끝나는 사람

SELECT
       emp_no, emp_nm, addr
FROM tb_emp
WHERE emp_nm  LIKE '이%';

-- 성씨가 김씨이면서 부서가 100003, 100004 중에 하나면서
-- 90년대생인 사원의 사번, 이름, 생일, 부서코드 조회
SELECT
       emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE 1 = 1   -- 언제나 true이니 조건절 실행
            AND emp_nm LIKE '김%'
            AND dept_cd IN (100003, 100004)
            AND birth_de BETWEEN '19900101' AND '19991231';
            
-- NULL 값 조회 ☆★☆★
-- 반드시 IS NULL로 조회할 것 !
SELECT
      emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NULL;  -- is null : 널값 조회

SELECT
      emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL;  -- is not null

-- 연산자 우선 순위
-- NOT > AND > OR
SELECT 
	EMP_NO ,
	EMP_NM ,
	ADDR 
FROM TB_EMP
WHERE 1=1
	AND EMP_NM LIKE '김%'
	AND (ADDR LIKE '%수원%' OR ADDR LIKE '%일산%')
;  -- 1 AND 2 OR 3

