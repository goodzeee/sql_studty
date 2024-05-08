

-- ## ������ ���� (������ ���� ���� ���� -> Lv 1, Lv 2 ...)
-- START WITH : ������ ù �ܰ踦 ��� ������ �������� ���� ����
-- CONNECT BY PRIOR �ڽ� = �θ�  -> �θ� -> �ڽ� ������ Ž�� / �� �÷��� ������ ���� ���� �÷��� �θ�� !
-- CONNECT BY �ڽ� = PRIOR �θ�  -> ������ Ž��
-- ORDER SIBLINGS BY : ���� ���������� ������ ����.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF   
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL  -- �ش� �÷����� �� ���� ù��°�� ���� !
--START WITH A.EMP_NO = '1000000037'
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no  -- PRIOR�ڽ� = �θ� : ������
ORDER SIBLINGS BY A.emp_no DESC  -- ���� ������ ���� �����鳢�� ���� ��Ģ
;

SELECT emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp;

-- WHERE ���� ���ǿ� ��ġ�ϴ��� CONNECT�� AND�� ����� ���������� ���� ��� �޶���
SELECT �����ȣ. �����, �Ի�����. �Ŵ��������ȣ
FROM ���
WHERE �Ի����� BETWEEN  '2013-01-01'  AND '2013-12-31'
START WITH �Ŵ��������ȣ IS NULL
CONNECT BY PRIOR �����ȣ = �Ŵ��������ȣ 
ORDER SIBLINGS BY�����ȣ.



-- ## �������� : SQL �ȿ� SQL�� ���Ե� ����
-- #1. ������ �������� : ��ȸ ����� 1�� ����

-- �μ��ڵ尡 100004���� �μ��� ����� ���� ��ȸ
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100004';

-- �̳��� ���� �μ��� ��� ������� ��ȸ
-- 1. �̳���� �μ��ڵ尡 �� �� ?
-- 2. �� �μ��ڵ�� ��� ����� ��ȸ�ض�
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd
                                  FROM tb_emp
                                  WHERE emp_nm = '�̳���'); -- 100004�� �μ��ڵ� ��� ��ȸ

-- ����̸��� �̰����� ����� ���� �ִ� �μ��� ������� ��ȸ
-- # ������ �񱳿�����(=, <>, >, >=, <, <=)�� ������ ���������θ� ���ؾ� ��.                                  
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (SELECT dept_cd
                                  FROM tb_emp
                                  WHERE emp_nm = '�̰���');  -- 100005, 100008 �� ���� ��ȸ�Ǿ� �������� �ϳ� ���� ó�� !
                    
-- 20200525�� ���� �޿��� ȸ����ü�� 20200525�� 
-- ��ü ��� �޿����� ���� ������� ����(���, �̸�, �޿�������, �����޿��׼�) ��ȸ 

-- ȸ�� ��ü 20200525 ��� �޿� ��� -> �� ��պ��� ���� ��� ��ȸ
SELECT e.emp_no, e.emp_nm, s.pay_de, s.pay_amt 
FROM tb_emp e JOIN tb_sal_his s
ON e.emp_no = s.emp_no
WHERE s.pay_de = '20200525'
AND s.pay_amt >= (SELECT ROUND(AVG(pay_amt), 3)
                                  FROM tb_sal_his
                                  WHERE pay_de = '20200525');     -- ������������ ��� ���� �ϳ��� ��� ���� ���� !

-- 20200525 ȸ�� ��ü �޿� ���
SELECT ROUND(AVG(pay_amt), 3)   -- ��ü �޿� ���
FROM tb_sal_his
WHERE pay_de = '20200525';    -- 20200525


-- #2. ������ ��������
-- ���������� ��ȸ �Ǽ��� 0�� �̻��� ��
-- # ������ ������
-- 1. IN : ���������� �������� �������� ����߿� �ϳ��� ��ġ�ϸ� ��
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 �߿� �����Ƿ� false
-- 2. ANY, SOME : ���������� �������� ���������� �˻���� �� �ϳ� �̻� ��ġ�ϸ� ��
--    ex )  salary > ANY (200, 300, 400)   ���̿� ��
--            250 ->  200���� ũ�Ƿ� true
-- 3. ALL : ���������� �������� ���������� �˻������ ��� ��ġ�ϸ� ��
--    ex )  salary > ALL (200, 300, 400)
--            250 ->  200���ٴ� ũ���� 300, 400���ٴ� ũ�� �����Ƿ� false
-- 4. EXISTS : ���������� �������� ���������� ��� �� 
--				�����ϴ� ���� �ϳ��� �����ϸ� ��

SELECT emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd  (SELECT dept_cd       -- ������ ������ ����Ͽ� 2�� �� ��ȸ ���� !!
                                  FROM tb_emp
                                  WHERE emp_nm = '�̰���');  -- IN (100005, 100008)

-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ�
-- ����� �����ȣ�� ����̸��� �ش� ����� �ѱ������ͺ��̽���������� 
-- �߱��� �ڰ��� ������ ��ȸ
SELECT e.emp_no, e.emp_nm, COUNT(ec.certi_cd) "�ڰ��� ����"
FROM tb_emp e 
INNER JOIN tb_emp_certi ec
ON e.emp_no = ec.emp_no
WHERE ec.certi_cd IN (SELECT certi_cd FROM tb_certi WHERE issue_insti_nm = '�ѱ������ͺ��̽������')
GROUP BY e.emp_no, e.emp_nm
ORDER BY e.emp_no;
-- IN ���� �ǹ� = ANY
SELECT e.emp_no, e.emp_nm, COUNT(ec.certi_cd) "�ڰ��� ����"
FROM tb_emp e 
INNER JOIN tb_emp_certi ec
ON e.emp_no = ec.emp_no
WHERE ec.certi_cd = ANY (SELECT certi_cd FROM tb_certi WHERE issue_insti_nm = '�ѱ������ͺ��̽������')
GROUP BY e.emp_no, e.emp_nm
ORDER BY e.emp_no;

-- <�ߺ� ���� �� ��>
SELECT COUNT(emp_nm)
FROM tb_emp;

SELECT COUNT (DISTINCT emp_nm)
FROM tb_emp;

-- ���� �̸��� ���������� �����ȣ�� �ٸ��� ������ �ߺ� ó�� �ȵ�
SELECT DISTINCT emp_no || emp_nm 
FROM tb_emp;


-- #3. ���� �÷� ��������
--  : ���������� ��ȸ �÷��� 2�� �̻��� ��������

-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� 
-- ���� �������� ����� �̸� ������ϰ� �μ��ڵ带 ��ȸ
SELECT 
    A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE (A.dept_cd, A.birth_de) IN (   -- �������� ��ȸ�� 2�� �÷� = ����Ŀ������ ��ȸ�� 2�� �÷�
                        SELECT                        
                            dept_cd, MIN(birth_de)  -- �������� ����� ������� ��ȸ ����.
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2  -- ����� 2���� �̻��� !
                    )
ORDER BY A.emp_no;

-- #4. �ζ��� �� �������� : ������ �� ���̺���� �ٿ��� ���� ����.
-- : FROM���� ���� ��������, JOIN���� ���� ��������

-- �� ����� ����� �̸��� ��� �޿������� �˰� ����
SELECT e.emp_no, e.emp_nm, ROUND(AVG(s.pay_amt), 3)
FROM tb_emp e INNER JOIN (SELECT emp_no, ROUND(AVG(pay_amt), 3)
                                                     FROM tb_sal_his
                                                     GROUP BY emp_no) s -- tb_sal_his s  �޿� ���� ���̺� �����Ͱ� 900�� ����. bad
ON e.emp_no = s.emp_no
GROUP BY e.emp_no, e.emp_nm
ORDER BY e.emp_no;


-- #5. ��Į�� �������� (SELECT, INSERT, UPDATE���� ���� ��������)

-- ����� ���, �����, �μ���, �������, �����ڵ带 ��ȸ (- �μ��� �̴� �÷� �������� ó��)
-- d ���̺� �� ��ȸ�� �÷��� �ϳ��ε� �����ϴ� �ͺ��� ��ȸ ���������� ó��
SELECT e.emp_no, e.emp_nm, (SELECT dept_nm
                                                          FROM tb_dept d
                                                          WHERE e.dept_cd = d.dept_cd) , e.birth_de, e.sex_cd
FROM tb_emp e, tb_dept d;


-- ## EXISTS�� : ���������� �������� ���������� ��� �� 
--                           �����ϴ� ���� �ϳ��� �����ϸ� ��
-- �ּҰ� ������ �������� �ٹ��ϰ� �ִ� �μ������� ��ȸ (�μ��ڵ�, �μ���)
SELECT dept_cd, dept_nm
FROM tb_dept
WHERE dept_cd IN (100009, 100010);
-- ++
SELECT  dept_cd, emp_nm, addr
FROM tb_emp
WHERE addr LIKE '%����%';    -- �μ��ڵ� ��ȸ ��� 100009, 100010
-- ==
SELECT dept_cd, dept_nm
FROM tb_dept d
WHERE EXISTS (SELECT  d.dept_cd     -- exists select���� �߿����� �ʰ� �ؿ� ���ǰ� ��ġ�Ǵ� �� �̾ƿ��� �Ǵ°� !
                                    FROM tb_emp e
                                    WHERE addr LIKE '%����%'
                                    AND d.dept_cd = e.dept_cd
                                    );
                                    
--< ���� �Լ� count>                                    
SELECT COUNT(0)   -- 46��
FROM tb_emp;

-- �������� �ܵ� ���� ���� -> �񿬰� ��������