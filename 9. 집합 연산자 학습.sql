
-- 집합 연산자
-- ## UNION (세로로 합침)
-- 1. 합집합 연산의 의미입니다.
-- 2. 첫번째 쿼리와 두번째 쿼리의 중복정보는 한번만 보여줍니다.
-- 3. 첫번째 쿼리의 열의 개수와 타입이 = 두번째 쿼리의 열수와 타입과 동일해야 함.
-- 4. 자동으로 정렬이 일어남 (첫번째 컬럼 오름차가 기본값)
-- 5. 성능상 부하가 일어나는 이슈 (중복 제거, 자동 정렬 ...)
SELECT emp_no, emp_nm, birth_de, addr
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT emp_no, emp_nm, birth_de, addr
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

-- 동명이인이 다른 사번을 갖게 되어 사번 미조회시 중복 제거되어 나옴
SELECT emp_nm, birth_de   
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

-- ## UNION ALL
-- 1. UNION과 같이 두 테이블로 수직으로 합쳐서 보여줍니다.
-- 2. UNION과는 달리 중복된 데이터도 한번 더 보여줍니다.
-- 3. 자동 정렬 기능을 지원하지 않아 성능상 유리합니다.
SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL                           -- 조회 컬럼 중 중복된 값 모두 조회
SELECT emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

SELECT emp_nm en1, birth_de bd1
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL                                               -- 위에 있는 별칭 사용 !!
SELECT emp_nm en2, birth_de bd2
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

SELECT emp_nm en1, birth_de bd1
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL                                               
SELECT emp_nm en2, birth_de bd2
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';
--ORDER BY en2;
-- UNION 정렬하고 싶을 시 마지막에 한 번만 정렬식 사용 가능 !

-- ## INTERSECT
-- 1. 첫번째 쿼리와 두번째 쿼리에서 중복된 행만을 출력합니다.
-- 2. 교집합의 의미입니다.
SELECT 
    A.emp_no, A.emp_nm, A.addr,
    B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE C.certi_nm = 'SQLD'
INTERSECT
SELECT 
    A.emp_no, A.emp_nm, A.addr, B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%';
-----> JOIN으로도 가능한 방법
SELECT 
    A.emp_no, A.emp_nm, A.addr
    , B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C 
ON B.certi_cd = C.certi_cd 
WHERE A.addr LIKE '%용인%'
    AND C.certi_nm = 'SQLD';


-- ## MINUS(EXCEPT) 
-- 1. 두번째 쿼리에는 없고 첫번째 쿼리에만 있는 데이터를 보여줍니다.
-- 2. 차집합의 개념입니다.

SELECT emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE dept_cd = '100001'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
MINUS
SELECT emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE sex_cd = '1';

