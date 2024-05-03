
-- ����� first_name, employee_id, department_id, department_name

SELECT e.first_name, e.employee_id, e.department_id, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id;
-- NATURAL JOIN != INNER JOIN : �׻� ���� ����� �����°� �ƴ�
-- natural join�� ���� ���̺� ���� �÷��� �� ���ν��ѹ��� !!
SELECT e.first_name, e.employee_id, department_id, d.department_name
FROM employees e
NATURAL JOIN departments d
-- ON e.department_id = d.department_id  (+ manager_id �÷��� ������)
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
USING (department_id, manager_id)   -- ���� �÷� �ΰ� !
ORDER BY e.employee_id;


-- 1. employees���̺�� departments���̺��� inner join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id; -- 50 ��
--ON e.manager_id = d.manager_id;   -- 44��  ���� �÷� ���� �ٸ��� �ຸ��
--ON (e.department_id = d.department_id AND e.manager_id = d.manager_id);   -- 32��

-- 2. employees���̺�� departments���̺��� natural join�Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT e.employee_id, e.first_name, e.last_name, department_id, d.department_name
FROM employees e
NATURAL JOIN departments d;  -- 32��

-- 3. employees���̺�� departments���̺��� using���� ����Ͽ�
--    ���, first_name, last_name, department_id, department_name�� ��ȸ�ϼ���.
SELECT e.employee_id, e.first_name, e.last_name, department_id, d.department_name
FROM employees e
INNER JOIN departments d
USING (department_id);  -- 50�� ���� �÷� �Ѱ�
--USING (department_id, manager_id);   -- 32�� ���� �÷� �ΰ�

-- 4. employees���̺�� departments���̺�� locations ���̺��� 
--    join�Ͽ� employee_id, first_name, department_name, city�� ��ȸ�ϼ���
SELECT  e.employee_id, e.first_name, d.department_name, l.city
FROM employees e
INNER JOIN departments d
USING (department_id)
INNER JOIN locations l
USING (location_id);   -- 50��

SELECT  e.employee_id, e.first_name, d.department_name, l.city
FROM employees e
NATURAL JOIN departments d
NATURAL JOIN locations l;      -- 32�� ���� �÷� �� ��Ƴ��ϱ�

-- 5. employees ���̺�� jobs ���̺��� INNER JOIN�Ͽ� 
-- ����� first_name, last_name, job_title�� ��ȸ�ϼ���.
SELECT e.first_name, e.last_name, j.job_title
FROM employees e
INNER JOIN jobs j
USING (job_id);

-- 6. employees ���̺�� departments ���̺��� INNER JOIN�Ͽ� 
-- �μ���� �� �μ��� �ִ� �޿����� ��ȸ�ϼ���.
SELECT department_id, d.department_name, MAX(e.salary)
FROM employees e
INNER JOIN departments d 
USING (department_id)
GROUP BY department_id, d.department_name
ORDER BY department_id;

-- 7. employees ���̺�� jobs ���̺��� INNER JOIN�Ͽ� 
--  ������ ��� �޿��� ���� Ÿ��Ʋ�� ��ȸ�ϼ���.
SELECT job_id, j.job_title, AVG(e.salary)
FROM employees e
INNER JOIN jobs j
USING (job_id)
GROUP BY job_id, j.job_title;