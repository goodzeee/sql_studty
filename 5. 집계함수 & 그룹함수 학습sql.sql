

SELECT *
FROM tb_sal_his;

-- 집계함수 (다중행 함수) = only 하나의 행으로 나옴
-- 여러 행을 묶어서 한 번에 함수를 적용
SELECT COUNT(*) "지급 횟수", 
                 SUM(pay_amt) "지급 총액",
                 ROUND(AVG(pay_amt), 5) "평균 지급액",
                 MAX(pay_amt) "최고 지급액",
                 MIN(pay_amt) "최소 지급액"
FROM tb_sal_his;

-- 단일행 함수 = 41 총 행수 다 나옴
SELECT SUBSTR(emp_nm, 1, 1)
FROM tb_emp;

SELECT * 
FROM tb_emp;  -- 41행

SELECT COUNT(*)
FROM tb_emp;   -- 1행

SELECT COUNT(emp_nm)  -- count 조회한 행수를 세어 하나로 보여줌 !
FROM tb_emp;  -- 1행

SELECT COUNT(emp_nm)
FROM tb_emp
WHERE emp_nm LIKE '김%';   -- 13 1행

-- NULL로 집계함수 연산 실행시 NULL이 답임. ex) sum(null) + sum(30) = null
-- 집계함수는 NULL을 빼고 집계한다 
SELECT COUNT(direct_manager_emp_no)   -- 해당 속성값에 NULL 1개 존재
FROM tb_emp;  -- 40 1행


SELECT COUNT(emp_no) "총 사원수",  -- 41
                 MIN(birth_de) "최연장자 생일",
                 MAX(birth_de) "최연소자 생일"
FROM tb_emp;


-- 부서별로 사원수가 몇 명인지
-- 부서별로 최연장자의 생일은 언젠지 ?
-- GROUP BY : 지정된 컬럼으로 소그룹화 한 후 각 그룹별로 집계함수를 각각 적용
SELECT emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
ORDER BY dept_cd ASC;

SELECT COUNT(*)
FROM tb_emp
GROUP BY emp_no;  --  사원번호가 다 다르니까 집계 그룹해도 41행

SELECT COUNT(*) "부서별 사원수", dept_cd,
                 MIN(birth_de) "부서별 최연장자"
FROM tb_emp
GROUP BY dept_cd;  -- 그룹화 기준이 되어 주는 컬럼 ! 14행 14번 집계를 하는 것 !

 -- 집계함수는 결과 행이 1개만 나옴 / 그룹별로 집계 각가 내고 싶으면 GROUP BY필수 !!
SELECT emp_no, TO_CHAR(SUM(pay_amt), 'L999,999,999'),
                TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999')
FROM tb_sal_his
GROUP BY emp_no  -- 사원별로 그룹화 = 각 사원별로 집계 결과가 나오는 것 ! 
ORDER BY emp_no;

SELECT emp_no,  -- 전체 41행이 나옴
                COUNT(*) -- 집계함수 결과 1개 1행이 나오는 식
FROM tb_emp;  -- 41행 , 1행 결과를 어떻게 내 그룹화가 필요 !

-- GROUP BY절에 사용한 컬럼만 SELECT에서 직접 조회 가능
SELECT emp_no,
                COUNT(*) 
FROM tb_emp
GROUP BY emp_no;

SELECT dept_cd, sex_cd, COUNT(*), MAX(birth_de)
FROM tb_emp
GROUP BY dept_cd, sex_cd  -- 부서 번호와 성별 그룹화 100001 + 남 , 100002 + 남,
ORDER BY dept_cd;  -- 성별 속성 그룹화 했으니 이 속성만 select에서 사용 가능


-- 사원별로 2019년에 급여 평균액, 최소지급액, 최대지급액 조회
-- WHERE : 집계 전 필터링 (통계 내기 전에 필터링)
SELECT 
    emp_no, 
    TO_CHAR(SUM(pay_amt), 'L999,999,999') "사원별 총급여액",
    TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "사원별 평균급여액",
    TO_CHAR(MAX(pay_amt), 'L999,999,999') "사원별 최고급여액",
    COUNT(pay_de) "급여 수령횟수"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231' -- 2019년도 조건
GROUP BY emp_no
ORDER BY emp_no;

-- HAVING : 집계 후 필터링 (통계 후 필터링)
SELECT 
    emp_no, 
    TO_CHAR(SUM(pay_amt), 'L999,999,999') "사원별 총급여액",
    TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "사원별 평균급여액",
    TO_CHAR(MAX(pay_amt), 'L999,999,999') "사원별 최고급여액",
    COUNT(pay_de) "급여 수령횟수"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231' -- 2019년도 조건
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4000000  -- 평균 급여액이 400이상인 사람만 필터링
ORDER BY emp_no;

-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일, 부서별 총 사원 수를 조회
--그런데 부서별 사원이 1명인 부서의 정보는 조회하고 싶지 않음.
SELECT dept_cd, MAX(birth_de), MIN(birth_de), COUNT(*)
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(*) > 1  -- 사원 1명 이상인 사람만 보고 싶다 
ORDER BY dept_cd;

-- 그룹절에 SELECT에서  AS 별칭 사용한 별칭 사용할 수 없다 !! ALLAS 불가 
-- 집계함수는 WHERE절에 사용 불가 , GROUP BY에 사용 가능


-- ## ORDER BY : 정렬
-- DBMS마다 NULL값에 대한 정렬 순서가 다를 수 있다 ! 오라클에선 제일 큰 값으로 침
-- ASC : 오름차 정렬 (기본값), DESC : 내림차 정렬
-- 항상 SELECT절의 맨 마지막에 위치하고 맨 마지막에 처리

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no; -- 오름차 정렬 중 기본값 !

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm ASC;  -- 이름 오름차 ㄱ -> ㅎ 순

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC; -- 부서 코드로 오름차하고 부서 코드가 동일하면 사원명 내림차로 정렬 !

SELECT 
    emp_no AS 사번
    , emp_nm AS 이름
    , addr AS 주소
FROM tb_emp
ORDER BY 이름 DESC;  -- ORDER 정렬 : 별칭 사용 가능

SELECT 
    emp_no      --1
    , emp_nm   --2
    , dept_cd    --3
FROM tb_emp
ORDER BY 3 ASC, 1 DESC;  -- 부서 코드로 오름차 동일할 시 사원 번호 내림차

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 , emp_no DESC  -- 기본값 ASC 오름차 생략 가능 3 뒤에 생략되어 있는겨
;

SELECT emp_no AS 사번, emp_nm AS 이름, addr AS 주소
FROM tb_emp
ORDER BY 이름, 1 DESC;

SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no;

SELECT 
	EMP_NM ,
	DIRECT_MANAGER_EMP_NO 
FROM TB_EMP
ORDER BY DIRECT_MANAGER_EMP_NO DESC;

-- 사원별로 2019년 월평균 수령액이 450만원 이상인 사원의 사원번호와 2019년 연봉 내림차 조회
SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY SUM(pay_amt) DESC;