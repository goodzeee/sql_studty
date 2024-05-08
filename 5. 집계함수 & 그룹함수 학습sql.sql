

SELECT *
FROM tb_sal_his;

-- �����Լ� (������ �Լ�) = only �ϳ��� ������ ����
-- ���� ���� ��� �� ���� �Լ��� ����
SELECT COUNT(*) "���� Ƚ��", 
                 SUM(pay_amt) "���� �Ѿ�",
                 ROUND(AVG(pay_amt), 5) "��� ���޾�",
                 MAX(pay_amt) "�ְ� ���޾�",
                 MIN(pay_amt) "�ּ� ���޾�"
FROM tb_sal_his;

-- ������ �Լ� = 41 �� ��� �� ����
SELECT SUBSTR(emp_nm, 1, 1)
FROM tb_emp;

SELECT * 
FROM tb_emp;  -- 41��

SELECT COUNT(*)
FROM tb_emp;   -- 1��

SELECT COUNT(emp_nm)  -- count ��ȸ�� ����� ���� �ϳ��� ������ !
FROM tb_emp;  -- 1��

SELECT COUNT(emp_nm)
FROM tb_emp
WHERE emp_nm LIKE '��%';   -- 13 1��

-- NULL�� �����Լ� ���� ����� NULL�� ����. ex) sum(null) + sum(30) = null
-- �����Լ��� NULL�� ���� �����Ѵ� 
SELECT COUNT(direct_manager_emp_no)   -- �ش� �Ӽ����� NULL 1�� ����
FROM tb_emp;  -- 40 1��


SELECT COUNT(emp_no) "�� �����",  -- 41
                 MIN(birth_de) "�ֿ����� ����",
                 MAX(birth_de) "�ֿ����� ����"
FROM tb_emp;


-- �μ����� ������� �� ������
-- �μ����� �ֿ������� ������ ������ ?
-- GROUP BY : ������ �÷����� �ұ׷�ȭ �� �� �� �׷캰�� �����Լ��� ���� ����
SELECT emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
ORDER BY dept_cd ASC;

SELECT COUNT(*)
FROM tb_emp
GROUP BY emp_no;  --  �����ȣ�� �� �ٸ��ϱ� ���� �׷��ص� 41��

SELECT COUNT(*) "�μ��� �����", dept_cd,
                 MIN(birth_de) "�μ��� �ֿ�����"
FROM tb_emp
GROUP BY dept_cd;  -- �׷�ȭ ������ �Ǿ� �ִ� �÷� ! 14�� 14�� ���踦 �ϴ� �� !

 -- �����Լ��� ��� ���� 1���� ���� / �׷캰�� ���� ���� ���� ������ GROUP BY�ʼ� !!
SELECT emp_no, TO_CHAR(SUM(pay_amt), 'L999,999,999'),
                TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999')
FROM tb_sal_his
GROUP BY emp_no  -- ������� �׷�ȭ = �� ������� ���� ����� ������ �� ! 
ORDER BY emp_no;

SELECT emp_no,  -- ��ü 41���� ����
                COUNT(*) -- �����Լ� ��� 1�� 1���� ������ ��
FROM tb_emp;  -- 41�� , 1�� ����� ��� �� �׷�ȭ�� �ʿ� !

-- GROUP BY���� ����� �÷��� SELECT���� ���� ��ȸ ����
SELECT emp_no,
                COUNT(*) 
FROM tb_emp
GROUP BY emp_no;

SELECT dept_cd, sex_cd, COUNT(*), MAX(birth_de)
FROM tb_emp
GROUP BY dept_cd, sex_cd  -- �μ� ��ȣ�� ���� �׷�ȭ 100001 + �� , 100002 + ��,
ORDER BY dept_cd;  -- ���� �Ӽ� �׷�ȭ ������ �� �Ӽ��� select���� ��� ����


-- ������� 2019�⿡ �޿� ��վ�, �ּ����޾�, �ִ����޾� ��ȸ
-- WHERE : ���� �� ���͸� (��� ���� ���� ���͸�)
SELECT 
    emp_no, 
    TO_CHAR(SUM(pay_amt), 'L999,999,999') "����� �ѱ޿���",
    TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "����� ��ձ޿���",
    TO_CHAR(MAX(pay_amt), 'L999,999,999') "����� �ְ�޿���",
    COUNT(pay_de) "�޿� ����Ƚ��"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231' -- 2019�⵵ ����
GROUP BY emp_no
ORDER BY emp_no;

-- HAVING : ���� �� ���͸� (��� �� ���͸�)
SELECT 
    emp_no, 
    TO_CHAR(SUM(pay_amt), 'L999,999,999') "����� �ѱ޿���",
    TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "����� ��ձ޿���",
    TO_CHAR(MAX(pay_amt), 'L999,999,999') "����� �ְ�޿���",
    COUNT(pay_de) "�޿� ����Ƚ��"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231' -- 2019�⵵ ����
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4000000  -- ��� �޿����� 400�̻��� ����� ���͸�
ORDER BY emp_no;

-- �μ����� ���� ������ �������, �������� �������, �μ��� �� ��� ���� ��ȸ
--�׷��� �μ��� ����� 1���� �μ��� ������ ��ȸ�ϰ� ���� ����.
SELECT dept_cd, MAX(birth_de), MIN(birth_de), COUNT(*)
FROM tb_emp
GROUP BY dept_cd
HAVING COUNT(*) > 1  -- ��� 1�� �̻��� ����� ���� �ʹ� 
ORDER BY dept_cd;

-- �׷����� SELECT����  AS ��Ī ����� ��Ī ����� �� ���� !! ALLAS �Ұ� 
-- �����Լ��� WHERE���� ��� �Ұ� , GROUP BY�� ��� ����


-- ## ORDER BY : ����
-- DBMS���� NULL���� ���� ���� ������ �ٸ� �� �ִ� ! ����Ŭ���� ���� ū ������ ħ
-- ASC : ������ ���� (�⺻��), DESC : ������ ����
-- �׻� SELECT���� �� �������� ��ġ�ϰ� �� �������� ó��

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no; -- ������ ���� �� �⺻�� !

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm ASC;  -- �̸� ������ �� -> �� ��

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC; -- �μ� �ڵ�� �������ϰ� �μ� �ڵ尡 �����ϸ� ����� �������� ���� !

SELECT 
    emp_no AS ���
    , emp_nm AS �̸�
    , addr AS �ּ�
FROM tb_emp
ORDER BY �̸� DESC;  -- ORDER ���� : ��Ī ��� ����

SELECT 
    emp_no      --1
    , emp_nm   --2
    , dept_cd    --3
FROM tb_emp
ORDER BY 3 ASC, 1 DESC;  -- �μ� �ڵ�� ������ ������ �� ��� ��ȣ ������

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 , emp_no DESC  -- �⺻�� ASC ������ ���� ���� 3 �ڿ� �����Ǿ� �ִ°�
;

SELECT emp_no AS ���, emp_nm AS �̸�, addr AS �ּ�
FROM tb_emp
ORDER BY �̸�, 1 DESC;

SELECT 
    emp_no
    , SUM(pay_amt) ����
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

-- ������� 2019�� ����� ���ɾ��� 450���� �̻��� ����� �����ȣ�� 2019�� ���� ������ ��ȸ
SELECT 
    emp_no
    , SUM(pay_amt) ����
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY SUM(pay_amt) DESC;