
-- 사원의 first_name, employee_id, department_id, department_name

SELECT e.first_name, e.employee_id, e.department_id, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id;
-- NATURAL JOIN != INNER JOIN : 항상 같은 결과가 나오는거 아님
-- natural join은 조인 테이블간 같은 컬럼을 다 조인시켜버려 !!
SELECT e.first_name, e.employee_id, department_id, d.department_name
FROM employees e
NATURAL JOIN departments d
-- ON e.department_id = d.department_id  (+ manager_id 컬럼도 동일함)
ORDER BY e.employee_id;

-- USING
SELECT e.first_name, e.employee_id, department_id, d.department_name
FROM employees e
INNER JOIN departments d
USING (department_id)
ORDER BY e.employee_id;

SELECT e.first_name, e.employee_id, department_id, d.department_name
FROM employees e
INNER JOIN departments d
USING (department_id, manager_id)   -- 공통 컬럼 두개 !
ORDER BY e.employee_id;


-- 1. employees테이블과 departments테이블을 inner join하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id; -- 50 행
--ON e.manager_id = d.manager_id;   -- 44행  공통 컬럼 조건 다르게 줘보기
--ON (e.department_id = d.department_id AND e.manager_id = d.manager_id);   -- 32행

-- 2. employees테이블과 departments테이블을 natural join하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.
SELECT e.employee_id, e.first_name, e.last_name, department_id, d.department_name
FROM employees e
NATURAL JOIN departments d;  -- 32행

-- 3. employees테이블과 departments테이블을 using절을 사용하여
--    사번, first_name, last_name, department_id, department_name을 조회하세요.
SELECT e.employee_id, e.first_name, e.last_name, department_id, d.department_name
FROM employees e
INNER JOIN departments d
USING (department_id);  -- 50행 공통 컬럼 한개
--USING (department_id, manager_id);   -- 32행 공통 컬럼 두개

-- 4. employees테이블과 departments테이블과 locations 테이블을 
--    join하여 employee_id, first_name, department_name, city를 조회하세요
SELECT  e.employee_id, e.first_name, d.department_name, l.city
FROM employees e
INNER JOIN departments d
USING (department_id)
INNER JOIN locations l
USING (location_id);   -- 50행

SELECT  e.employee_id, e.first_name, d.department_name, l.city
FROM employees e
NATURAL JOIN departments d
NATURAL JOIN locations l;      -- 32행 공통 컬럼 다 잡아내니까

-- 5. employees 테이블과 jobs 테이블을 INNER JOIN하여 
-- 사원의 first_name, last_name, job_title을 조회하세요.
SELECT e.first_name, e.last_name, j.job_title
FROM employees e
INNER JOIN jobs j
USING (job_id);

-- 6. employees 테이블과 departments 테이블을 INNER JOIN하여 
-- 부서명과 각 부서의 최대 급여값을 조회하세요.
SELECT department_id, d.department_name, MAX(e.salary)
FROM employees e
INNER JOIN departments d 
USING (department_id)
GROUP BY department_id, d.department_name
ORDER BY department_id;

-- 7. employees 테이블과 jobs 테이블을 INNER JOIN하여 
--  직무별 평균 급여와 직무 타이틀을 조회하세요.
SELECT job_id, j.job_title, AVG(e.salary)
FROM employees e
INNER JOIN jobs j
USING (job_id)
GROUP BY job_id, j.job_title;