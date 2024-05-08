

-- ## 계층형 쿼리 (레벨로 따짐 레벨 순서 -> Lv 1, Lv 2 ...)
-- START WITH : 계층의 첫 단계를 어디서 시작할 것인지의 대한 조건
-- CONNECT BY PRIOR 자식 = 부모  -> 부모 -> 자식 순방향 탐색 / 한 컬럼에 동일한 값을 같는 컬럼이 부모다 !
-- CONNECT BY 자식 = PRIOR 부모  -> 역방향 탐색
-- ORDER SIBLINGS BY : 같은 레벨끼리의 정렬을 정함.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF   
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL  -- 해당 컬럼에서 널 값이 첫번째로 나옴 !
--START WITH A.EMP_NO = '1000000037'
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no  -- PRIOR자식 = 부모 : 순방향
ORDER SIBLINGS BY A.emp_no DESC  -- 같은 레벨을 갖는 형제들끼리 정렬 규칙
;

SELECT emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp;

-- WHERE 필터 조건에 위치하는지 CONNECT에 AND로 연결된 조건일지에 따라 결과 달라짐
SELECT 사원번호. 사원명, 입사일자. 매니저사원번호
FROM 사원
WHERE 입사일자 BETWEEN  '2013-01-01'  AND '2013-12-31'
START WITH 매니저사원번호 IS NULL
CONNECT BY PRIOR 사원번호 = 매니저사원번호 
ORDER SIBLINGS BY사원번호.



-- ## 서브쿼리 : SQL 안에 SQL이 포함된 구문
-- #1. 단일행 서브쿼리 : 조회 결과가 1건 이하

-- 부서코드가 100004번인 부서의 사원들 정보 조회
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004';

-- 이나라가 속한 부서의 모든 사원정보 조회
-- 1. 이나라는 부서코드가 몇 번 ?
-- 2. 그 부서코드로 모든 사원을 조회해라
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd
                                  FROM tb_emp
                                  WHERE emp_nm = '이나라'); -- 100004번 부서코드 사원 조회

-- 사원이름이 이관심인 사람이 속해 있는 부서의 사원정보 조회
-- # 단일행 비교연산자(=, <>, >, >=, <, <=)는 단일행 서브쿼리로만 비교해야 함.                                  
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd
                                  FROM tb_emp
                                  WHERE emp_nm = '이관심');  -- 100005, 100008 두 값이 조회되어 단일행은 하나 값만 처리 !
                    
-- 20200525에 받은 급여가 회사전체의 20200525일 
-- 전체 평균 급여보다 높은 사원들의 정보(사번, 이름, 급여지급일, 받은급여액수) 조회 

-- 회사 전체 20200525 평균 급여 계산 -> 그 평균보다 높은 사원 조회
SELECT e.emp_no, e.emp_nm, s.pay_de, s.pay_amt 
FROM tb_emp e JOIN tb_sal_his s
ON e.emp_no = s.emp_no
WHERE s.pay_de = '20200525'
AND s.pay_amt >= (SELECT ROUND(AVG(pay_amt), 3)
                                  FROM tb_sal_his
                                  WHERE pay_de = '20200525');     -- 서브쿼리에서 평균 구한 하나의 결과 값만 나옴 !

-- 20200525 회사 전체 급여 평균
SELECT ROUND(AVG(pay_amt), 3)   -- 전체 급여 평균
FROM tb_sal_his
WHERE pay_de = '20200525';    -- 20200525


-- #2. 다중행 서브쿼리
-- 서브쿼리의 조회 건수가 0건 이상인 것
-- # 다중행 연산자
-- 1. IN : 메인쿼리의 비교조건이 서브쿼리 결과중에 하나라도 일치하면 참
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 중에 없으므로 false
-- 2. ANY, SOME : 메인쿼리의 비교조건이 서브쿼리의 검색결과 중 하나 이상 일치하면 참
--    ex )  salary > ANY (200, 300, 400)   사이에 값
--            250 ->  200보다 크므로 true
-- 3. ALL : 메인쿼리의 비교조건이 서브쿼리의 검색결과와 모두 일치하면 참
--    ex )  salary > ALL (200, 300, 400)
--            250 ->  200보다는 크지만 300, 400보다는 크지 않으므로 false
-- 4. EXISTS : 메인쿼리의 비교조건이 서브쿼리의 결과 중 
--				만족하는 값이 하나라도 존재하면 참

SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd  (SELECT dept_cd       -- 다중행 연산자 사용하여 2개 값 조회 가능 !!
                                  FROM tb_emp
                                  WHERE emp_nm = '이관심');  -- IN (100005, 100008)

-- 한국데이터베이스진흥원에서 발급한 자격증을 가지고 있는
-- 사원의 사원번호와 사원이름과 해당 사원의 한국데이터베이스진흥원에서 
-- 발급한 자격증 개수를 조회
SELECT e.emp_no, e.emp_nm, COUNT(ec.certi_cd) "자격증 개수"
FROM tb_emp e 
INNER JOIN tb_emp_certi ec
ON e.emp_no = ec.emp_no
WHERE ec.certi_cd IN (SELECT certi_cd FROM tb_certi WHERE issue_insti_nm = '한국데이터베이스진흥원')
GROUP BY e.emp_no, e.emp_nm
ORDER BY e.emp_no;
-- IN 같은 의미 = ANY
SELECT e.emp_no, e.emp_nm, COUNT(ec.certi_cd) "자격증 개수"
FROM tb_emp e 
INNER JOIN tb_emp_certi ec
ON e.emp_no = ec.emp_no
WHERE ec.certi_cd = ANY (SELECT certi_cd FROM tb_certi WHERE issue_insti_nm = '한국데이터베이스진흥원')
GROUP BY e.emp_no, e.emp_nm
ORDER BY e.emp_no;

-- <중복 제거 총 수>
SELECT COUNT(emp_nm)
FROM tb_emp;

SELECT COUNT (DISTINCT emp_nm)
FROM tb_emp;

-- 같은 이름이 존재하지만 사원번호가 다르기 때문에 중복 처리 안됨
SELECT DISTINCT emp_no || emp_nm 
FROM tb_emp;


-- #3. 다중 컬럼 서브쿼리
--  : 서브쿼리의 조회 컬럼이 2개 이상인 서브쿼리

-- 부서원이 2명 이상인 부서 중에서 각 부서의 
-- 가장 연장자의 사번과 이름 생년월일과 부서코드를 조회
SELECT 
    A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE (A.dept_cd, A.birth_de) IN (   -- 조건절에 조회할 2개 컬럼 = 서브커리에서 조회할 2개 컬럼
                        SELECT                        
                            dept_cd, MIN(birth_de)  -- 연장자의 사번과 생년월일 조회 원함.
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2  -- 사원이 2명이 이상인 !
                    )
ORDER BY A.emp_no;

-- #4. 인라인 뷰 서브쿼리 : 조인할 때 테이블양을 줄여서 성능 개선.
-- : FROM절에 쓰는 서브쿼리, JOIN절에 쓰는 서브쿼리

-- 각 사원의 사번과 이름과 평균 급여정보를 알고 싶음
SELECT e.emp_no, e.emp_nm, ROUND(AVG(s.pay_amt), 3)
FROM tb_emp e INNER JOIN (SELECT emp_no, ROUND(AVG(pay_amt), 3)
                                                     FROM tb_sal_his
                                                     GROUP BY emp_no) s -- tb_sal_his s  급여 정보 테이블 데이터가 900개 넘음. bad
ON e.emp_no = s.emp_no
GROUP BY e.emp_no, e.emp_nm
ORDER BY e.emp_no;


-- #5. 스칼라 서브쿼리 (SELECT, INSERT, UPDATE절에 쓰는 서브쿼리)

-- 사원의 사번, 사원명, 부서명, 생년월일, 성별코드를 조회 (- 부서명 뽑는 컬럼 서브쿼리 처리)
-- d 테이블 중 조회할 컬럼이 하나인데 조인하는 것보다 조회 서브쿼리로 처리
SELECT e.emp_no, e.emp_nm, (SELECT dept_nm
                                                          FROM tb_dept d
                                                          WHERE e.dept_cd = d.dept_cd) , e.birth_de, e.sex_cd
FROM tb_emp e, tb_dept d;


-- ## EXISTS문 : 메인쿼리의 비교조건이 서브쿼리의 결과 중 
--                           만족하는 값이 하나라도 존재하면 참
-- 주소가 강남인 직원들이 근무하고 있는 부서정보를 조회 (부서코드, 부서명)
SELECT dept_cd, dept_nm
FROM tb_dept
WHERE dept_cd IN (100009, 100010);
-- ++
SELECT  dept_cd, emp_nm, addr
FROM tb_emp
WHERE addr LIKE '%강남%';    -- 부서코드 조회 결과 100009, 100010
-- ==
SELECT dept_cd, dept_nm
FROM tb_dept d
WHERE EXISTS (SELECT  d.dept_cd     -- exists select절은 중요하지 않고 밑에 조건과 매치되는 것 뽑아오면 되는거 !
                                    FROM tb_emp e
                                    WHERE addr LIKE '%강남%'
                                    AND d.dept_cd = e.dept_cd
                                    );
                                    
--< 집계 함수 count>                                    
SELECT COUNT(0)   -- 46개
FROM tb_emp;

-- 서브쿼리 단독 실행 가능 -> 비연관 서브쿼리