
-- ����� ���, �̸�, �μ���ȣ, �μ��� ��ȸ
SELECT emp_no, emp_nm, dept_cd
FROM tb_emp;

-- ���̺� ���� = WHERE �������� ���� �Ӽ��� ���� �ֱ�
SELECT tb_emp.emp_no, tb_emp.emp_nm, tb_dept.dept_cd, tb_dept.dept_nm
FROM tb_emp, tb_dept
WHERE tb_emp.dept_cd = tb_dept.dept_cd;


-- ���� ���� �׽�Ʈ ������
CREATE TABLE TEST_A (
      id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);

CREATE TABLE TEST_B (
      b_id NUMBER(10) PRIMARY KEY
    , reply VARCHAR2(100)
    , a_id NUMBER(10)
);
-- �Խñ� ����
INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');
-- ��� ����
INSERT INTO TEST_B  VALUES (1, '������', 1);
INSERT INTO TEST_B  VALUES (2, '������', 1);
INSERT INTO TEST_B  VALUES (3, '������', 2);
INSERT INTO TEST_B  VALUES (4, '������', 3);

SELECT * FROM test_a;
SELECT * FROM test_b;

-- ## ���� : ���ϱ� ����
-- īƼ�þ� ���δ�Ʈ (Cartesian production)
-- 1. CROSS JOIN : ������ ��� ����� ���� ��Ī�Ͽ� ��ȸ
SELECT *
FROM test_a, test_b;  -- ���� ���� ��� ��� �� ���� : cross join

-- 2. INNER JOIN : �� ���̺� �� �����÷��� �̿��Ͽ� ���谡 �ִ� �����͸� ��Ī�Ͽ� ����
SELECT *
FROM test_a, test_b
WHERE test_a.id = test_b.a_id;
-- INNER JOIN : �����ϴ� �� ���̺� where�������� �μ��ڵ尡 ���ٰ� �ϰ�
                        -- ���ϴ� �Ӽ� ��ȸ
SELECT e.emp_nm, e.addr, d.dept_cd, d.dept_nm
FROM tb_emp e, tb_dept d    -- ������ �� ���̺� ��Ī ����Ͽ� ������ !
WHERE e.dept_cd = d.dept_cd;  -- ������ �ְ� ���� : inner join

-- ����� �����ȣ�� ����� �ڰ�����, �μ����� ��ȸ
SELECT e.emp_no, c.certi_nm, d.dept_nm
FROM tb_emp e, tb_emp_certi ec, tb_certi c, tb_dept d
WHERE e.emp_no = ec.emp_no 
               AND c.certi_cd = ec.certi_cd  -- �������� ������ ���� ���̺��� 
               AND d.dept_cd = e.dept_cd;  -- ���� �Ӽ����� ���� ������� !
               
-- �μ����� �� �ڰ��� ��� ������ ��ȸ
SELECT d.dept_cd, d.dept_nm, COUNT(certi_cd)
FROM tb_dept d, tb_emp_certi ec, tb_emp e  -- ����� �Ӽ��� ���� ���̺� ��������� ��
WHERE e.dept_cd = d.dept_cd AND e.emp_no = ec.emp_no
GROUP BY d.dept_cd, d.dept_nm
ORDER BY d.dept_cd;
                 
-- # INNER JOIN
-- 1. 2�� �̻��� ���̺��� ����� �÷��� ���� �������� ���յǴ� ���α���Դϴ�.
-- 2. WHERE���� ���� �÷����� �������(=)�� ���� ���ε˴ϴ�.

-- ���νÿ� ��� ����� �����ȣ, �����, �ּ�, �μ��ڵ�, �μ����� ��ȸ�ϰ� �ʹ�.
SELECT e.emp_no, e.emp_nm, e.addr, e.dept_cd, d.dept_nm
FROM tb_emp e, tb_dept d      -- �ٸ� �� ���̺��� �����ϰ� �μ����� �������� ����
WHERE addr LIKE '%����%' AND e.emp_nm LIKE '��%'
              AND e.dept_cd = d.dept_cd;  -- �������� ���� �Ӽ� ������ֱ�
-- ## ���ݱ��� �������� ����Ŭ ���� : WHERE �������� ��������.


-- ## JOIN ON (ANSI ǥ�� ����)
-- 1. FROM�� ��, WHERE �� ��
-- 2. ## JOIN Ű���� �ڿ��� ������ ���̺���� ���
-- 3. ## ON Ű���� �ڿ��� ���� ������ ���
-- 4. ���� ���� ������(ON��) �Ϲ� ���� ������ (WHERE��)�� �и��ؼ� �ۼ�
-- 5. ON���� �̿��ϸ� JOIN ������ �������̳� ���������� ���� �߰� ������ ����
SELECT e.emp_no, e.emp_nm, e.addr, e.dept_cd, d.dept_nm
FROM tb_emp e INNER JOIN tb_dept d   
ON e.dept_cd = d.dept_cd   -- FROM JOIN / ON ������ ���� ���ǵ� 
WHERE addr LIKE '%����%' AND e.emp_nm LIKE '��%';

SELECT e.emp_no, c.certi_nm, d.dept_nm
FROM tb_emp e 
JOIN tb_emp_certi ec ON e.emp_no = ec.emp_no  -- �� ���̺� ������ ����
JOIN tb_certi c ON c.certi_cd = ec.certi_cd
JOIN tb_dept d ON d.dept_cd = e.dept_cd
WHERE d.dept_cd IN (100004, 100006)  
               AND ec.acqu_de >= '20180101';
               
-- 1989���� ������� ���, �����, �μ���, �ڰ�����, ������� ��ȸ
-- ## INNER JOIN : ���̺� ���� �Ӽ��� ��Ī�Ǵ� ���� ���� ���� ��� ���� (=���� �����Ͱ� �ִ� ���)
-- Ansi ǥ�� ����
SELECT e.emp_no, e.emp_nm, d.dept_nm, c.certi_nm, ec.acqu_de
FROM tb_emp e 
JOIN tb_dept d ON e.dept_cd = d.dept_cd
JOIN tb_emp_certi ec ON e.emp_no = ec.emp_no
JOIN tb_certi c ON c.certi_cd = ec. certi_cd
WHERE e.birth_de BETWEEN '19800101' AND '19891231'
;
-- Oracle ������ ����
SELECT e.emp_no, e.emp_nm, d.dept_nm, c.certi_nm, ec.acqu_de
FROM tb_emp e, tb_dept d, tb_emp_certi ec, tb_certi c
WHERE e.dept_cd = d.dept_cd
              AND e.emp_no = ec.emp_no
              AND c.certi_cd = ec. certi_cd
              AND e.birth_de BETWEEN '19800101' AND '19891231'
;

-- ## SELECT �� �帧 ## --
-- SELECT [DISTINCT] { ���̸� .... } 
-- FROM  ���̺� �Ǵ� �� �̸�
-- JOIN  ���̺� �Ǵ� �� �̸�
-- ON    ���� ����
-- WHERE ��ȸ ����
-- GROUP BY  ���� �׷�ȭ
-- HAVING    �׷�ȭ ����
-- ORDER BY  ������ �� [ASC | DESC];

-- CROSS JOIN : ���� ������ ���� �� ī�׽þ� �� 
SELECT *
FROM test_a, test_b;  -- ��� ����� �� �ߺ��Ǿ� ����.
-- ������ cross join ���ֱ� cross join ��� ����.
SELECT *
FROM test_a
CROSS JOIN test_b;

-- ## NATURAL JOIN ## --
-- 1. NATURAL JOIN�� ������ �̸��� ���� �÷��鿡 ���� �ڵ����� ���������� �����ϴ� ����Դϴ�.
-- 2. ��, �ڵ����� 2�� �̻��� ���̺��� ���� �̸��� ���� �÷��� ã�� INNER������ �����մϴ�.
-- 3. �� �� ���εǴ� ���� �̸��� �÷��� ������ Ÿ���� ���ƾ� �ϸ�, 
-- ALIAS�� ���̺���� �ڵ� ���� �÷� �տ� ǥ���ϸ� �ȵ˴ϴ�.
-- 4. SELECT * ������ ����ϸ�, ���� �Ӽ��� ���տ��� �ѹ��� ǥ��˴ϴ�.
-- 5. ���� �÷��� n�� �̻��̸� ���� ������ n���� ó���˴ϴ�.

-- ��� ���̺�� �μ� ���̺��� ���� (���, �����, �μ��ڵ�, �μ���)
SELECT A.emp_no, A.emp_nm, dept_cd, B.dept_nm  -- ���� ����
FROM tb_emp A
NATURAL JOIN tb_dept B  -- ���� �Ӽ��� �˾Ƽ� �� ���� ǥ�� �ϴ� ���� �Ӽ��� Ư�� ���̺��� ����ϸ� �ȵȴ�.
-- ON A.dept_cd = B.dept_cd
;
-- �� �� ���̺� ���� �Ӽ��� ���� NATURAL JOIN ���� �Ұ� ! īƼ�þ� ������ ó����
SELECT *
FROM test_a a
NATURAL JOIN test_b b;
--ON a.id = b.a_id;


-- ## USING�� ���� ## --
-- 1. NATURAL���ο����� �ڵ����� �̸��� Ÿ���� ��ġ�ϴ� ��� �÷��� ����
--  ������ �Ͼ���� USING�� ����ϸ� ���ϴ� �÷��� ���ؼ��� ������ ���������� 
--  �ο��� �� �ֽ��ϴ�.
-- 2. USING�������� ���� �÷��� ���� ALIAS�� ���̺���� ǥ���Ͻø� �ȵ˴ϴ�.
SELECT A.emp_no, A.emp_nm, dept_cd, B.dept_nm  -- ���� ����
FROM tb_emp A
NATURAL JOIN tb_dept B ;

SELECT A.emp_no, A.emp_nm, dept_cd, B.dept_nm  -- ���� ����
FROM tb_emp A
INNER JOIN tb_dept B 
USING (dept_cd);   -- ��Ģ ���� : ON ��� ��� ! + natural join ó�� ���� �Ӽ��� ��Ī ���ֱ�

