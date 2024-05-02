
-- 사원의 사번, 이름, 부서번호, 부서명 조회
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp;

-- 테이블 조인 = WHERE 조건절로 같은 속성만 조건 주기
SELECT tb_emp.emp_no, tb_emp.emp_nm, tb_dept.dept_cd, tb_dept.dept_nm
FROM tb_emp, tb_dept
WHERE tb_emp.dept_cd = tb_dept.dept_cd;


-- 조인 기초 테스트 데이터
CREATE TABLE TEST_A (
      id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);

CREATE TABLE TEST_B (
      b_id NUMBER(10) PRIMARY KEY
    , reply VARCHAR2(100)
    , a_id NUMBER(10)
);
-- 게시글 형태
INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');
-- 댓글 형태
INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);

SELECT * FROM test_a;
SELECT * FROM test_b;

-- ## 조인 : 곱하기 연산
-- 카티시안 프로덕트 (Cartesian production)
-- 1. CROSS JOIN : 가능한 모든 경우의 수를 매칭하여 조회
SELECT *
FROM test_a, test_b;  -- 조건 없이 모든 경우 다 조인 : cross join

-- 2. INNER JOIN : 두 테이블 간 연관컬럼을 이용하여 관계가 있는 데이터를 매칭하여 조인
SELECT *
FROM test_a, test_b
WHERE test_a.id = test_b.a_id;
-- INNER JOIN : 조인하는 두 테이블에 where조건절에 부서코드가 같다고 하고
                        -- 원하는 속성 조회
SELECT e.emp_nm, e.addr, d.dept_cd, d.dept_nm
FROM tb_emp e, tb_dept d    -- 조인할 때 테이블 별칭 사용하여 간결히 !
WHERE e.dept_cd = d.dept_cd;  -- 조건을 주고 조인 : inner join

-- 사원의 사원번호와 취득한 자격증명, 부서명을 조회
SELECT e.emp_no, c.certi_nm, d.dept_nm
FROM tb_emp e, tb_emp_certi ec, tb_certi c, tb_dept d
WHERE e.emp_no = ec.emp_no 
               AND c.certi_cd = ec.certi_cd  -- 조건절에 조인한 여러 테이블에서 
               AND d.dept_cd = e.dept_cd;  -- 같은 속성명을 갖는 명시해줘 !
               
-- 부서별로 총 자격증 취득 개수를 조회
SELECT d.dept_cd, d.dept_nm, COUNT(certi_cd)
FROM tb_dept d, tb_emp_certi ec, tb_emp e  -- 공통된 속성을 갖는 테이블도 조인해줘야 함
WHERE e.dept_cd = d.dept_cd AND e.emp_no = ec.emp_no
GROUP BY d.dept_cd, d.dept_nm
ORDER BY d.dept_cd;
                 
-- # INNER JOIN
-- 1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법입니다.
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인됩니다.

-- 용인시에 사는 사원의 사원번호, 사원명, 주소, 부서코드, 부서명을 조회하고 싶다.
SELECT e.emp_no, e.emp_nm, e.addr, e.dept_cd, d.dept_nm
FROM tb_emp e, tb_dept d      -- 다른 두 테이블을 조인하고 부서명을 가져오기 위한
WHERE addr LIKE '%용인%' AND e.emp_nm LIKE '김%'
              AND e.dept_cd = d.dept_cd;  -- 조건절로 같은 속성 명시해주기
-- ## 지금까지 사투리인 오라클 조인 : WHERE 조건절이 지저분함.


-- ## JOIN ON (ANSI 표준 조인)
-- 1. FROM절 뒤, WHERE 절 앞
-- 2. ## JOIN 키워드 뒤에는 조인할 테이블명을 명시
-- 3. ## ON 키워드 뒤에는 조인 조건을 명시
-- 4. 조인 조건 서술부(ON절) 일반 조건 서술부 (WHERE절)를 분리해서 작성
-- 5. ON절을 이용하면 JOIN 이후의 논리연산이나 서브쿼리와 같은 추가 서술이 가능
SELECT e.emp_no, e.emp_nm, e.addr, e.dept_cd, d.dept_nm
FROM tb_emp e INNER JOIN tb_dept d   
ON e.dept_cd = d.dept_cd   -- FROM JOIN / ON 조인을 위한 조건들 
WHERE addr LIKE '%용인%' AND e.emp_nm LIKE '김%';

SELECT e.emp_no, c.certi_nm, d.dept_nm
FROM tb_emp e 
JOIN tb_emp_certi ec ON e.emp_no = ec.emp_no  -- 두 테이블 조인할 조건
JOIN tb_certi c ON c.certi_cd = ec.certi_cd
JOIN tb_dept d ON d.dept_cd = e.dept_cd
WHERE d.dept_cd IN (100004, 100006)  
               AND ec.acqu_de >= '20180101';
               
-- 1989년대생 사원들의 사번, 사원명, 부서명, 자격증명, 취득일자 조회
-- ## INNER JOIN : 테이블 간의 속성이 매칭되는 것이 있을 때만 사용 가능 (=연관 데이터가 있는 경우)
-- Ansi 표준 조인
SELECT e.emp_no, e.emp_nm, d.dept_nm, c.certi_nm, ec.acqu_de
FROM tb_emp e 
JOIN tb_dept d ON e.dept_cd = d.dept_cd
JOIN tb_emp_certi ec ON e.emp_no = ec.emp_no
JOIN tb_certi c ON c.certi_cd = ec. certi_cd
WHERE e.birth_de BETWEEN '19800101' AND '19891231'
;
-- Oracle 사투리 조인
SELECT e.emp_no, e.emp_nm, d.dept_nm, c.certi_nm, ec.acqu_de
FROM tb_emp e, tb_dept d, tb_emp_certi ec, tb_certi c
WHERE e.dept_cd = d.dept_cd
              AND e.emp_no = ec.emp_no
              AND c.certi_cd = ec. certi_cd
              AND e.birth_de BETWEEN '19800101' AND '19891231'
;

-- ## SELECT 절 흐름 ## --
-- SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화
-- HAVING    그룹화 조건
-- ORDER BY  정렬할 열 [ASC | DESC];

-- CROSS JOIN : 조인 조건이 없을 시 카테시안 곱 
SELECT *
FROM test_a, test_b;  -- 모든 경우의 수 중복되어 나옴.
-- 강제로 cross join 해주기 cross join 결과 나옴.
SELECT *
FROM test_a
CROSS JOIN test_b;

-- ## NATURAL JOIN ## --
-- 1. NATURAL JOIN은 동일한 이름을 갖는 컬럼들에 대해 자동으로 조인조건을 생성하는 기법입니다.
-- 2. 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER조인을 수행합니다.
-- 3. 이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며, 
-- ALIAS나 테이블명을 자동 조인 컬럼 앞에 표기하면 안됩니다.
-- 4. SELECT * 문법을 사용하면, 공통 속성은 집합에서 한번만 표기됩니다.
-- 5. 공통 컬럼이 n개 이상이면 조인 조건이 n개로 처리됩니다.

-- 사원 테이블과 부서 테이블을 조인 (사번, 사원명, 부서코드, 부서명)
SELECT A.emp_no, A.emp_nm, dept_cd, B.dept_nm  -- 여기 주의
FROM tb_emp A
NATURAL JOIN tb_dept B  -- 공통 속성을 알아서 한 번만 표기 하니 공통 속성에 특정 테이블을 명시하면 안된다.
-- ON A.dept_cd = B.dept_cd
;
-- 이 두 테이블엔 공통 속성이 없어 NATURAL JOIN 실행 불가 ! 카티시안 곱으로 처리됨
SELECT *
FROM test_a a
NATURAL JOIN test_b b;
--ON a.id = b.a_id;


-- ## USING절 조인 ## --
-- 1. NATURAL조인에서는 자동으로 이름과 타입이 일치하는 모든 컬럼에 대해
--  조인이 일어나지만 USING을 사용하면 원하는 컬럼에 대해서면 선택적 조인조건을 
--  부여할 수 있습니다.
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 표기하시면 안됩니다.
SELECT A.emp_no, A.emp_nm, dept_cd, B.dept_nm  -- 여기 주의
FROM tb_emp A
NATURAL JOIN tb_dept B ;

SELECT A.emp_no, A.emp_nm, dept_cd, B.dept_nm  -- 여기 주의
FROM tb_emp A
INNER JOIN tb_dept B 
USING (dept_cd);   -- 변칙 문법 : ON 대신 사용 ! + natural join 처럼 공통 속성에 별칭 없애기

