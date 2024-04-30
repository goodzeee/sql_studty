
-- # ���ڿ� ��

-- CHARŸ�Գ����� ��
DROP TABLE CHAR_COMPARE;
CREATE TABLE CHAR_COMPARE (
    sn CHAR(10),
    char_4 CHAR(4),
    char_6 CHAR(6)
);

INSERT INTO char_compare VALUES ('101', 'SQLD', 'SQLD ');
INSERT INTO char_compare VALUES ('102', 'SQLD', 'SQLA');
INSERT INTO char_compare VALUES ('103', 'SQLD', ' SQLD');

SELECT *
FROM char_compare;

SELECT *
FROM char_compare
WHERE sn = '101' AND char_4 = char_6; -- �� ������ �޶� ���ٰ� ��

SELECT *
FROM char_compare
WHERE sn = '103' AND char_4 = char_6;  -- �� ������ �޶��� false

SELECT *
FROM char_compare
WHERE sn = '102' AND char_4 >= char_6;  -- D > A

-- VARCHAR_COMPARE ���̺� ��Ʈ��
DROP TABLE VARCHAR_COMPARE;
CREATE TABLE VARCHAR_COMPARE (
    sn CHAR(10),
    char_4 CHAR(4),  -- 4����Ʈ ���� ����ؾ� ��
    varchar_6 VARCHAR2(6)  -- ���� ���� �ִ� 6����Ʈ ��� ����
);

INSERT INTO varchar_compare VALUES ('101', 'SQLD', 'SQLD  ');
INSERT INTO varchar_compare VALUES ('102', 'SQLD', ' SQLA ');
INSERT INTO varchar_compare VALUES ('103', 'SQLD', ' SQLD');

SELECT * FROM varchar_compare
WHERE sn = '101' AND char_4 = varchar_6;  -- false

SELECT * FROM varchar_compare
WHERE sn = '101' AND char_4 = TRIM(varchar_6);  -- true

SELECT *
FROM varchar_compare
WHERE sn = '101' AND char_4 = 'SQLD   ';  -- true

SELECT *
FROM varchar_compare
WHERE sn = '101' AND varchar_6 = 'SQLD'; -- false

-- ������ �Լ�
SELECT emp_nm, SUBSTR(addr, 1, 3) -- ��� ���� ���� ���� '��⵵'
FROM tb_emp;

-- ## ������ ���� �Լ�
SELECT 
    LOWER('Hello WORLD'),  -- ���� �ҹ��ڷ� ��ȯ
    UPPER('hello World'),  -- ���� �빮�ڷ� ��ȯ
    INITCAP('abcDEF')      -- ù���ڸ� �빮�ڷ� �������� �ҹ��ڷ� ��ȯ
FROM dual;

SELECT
    ASCII('A'), -- ���ڸ� �ƽ�Ű�ڵ�� 65
    CHR(97)     -- �ƽ�Ű�ڵ带 ���ڷ� a
FROM dual;

SELECT
    --'SQL' || 'Developer',  -- ����Ŭ������ �����ϴ� ���ڿ� ����
    CONCAT('SQL', 'Developer'),   -- ���ڿ��� ���� concat
    SUBSTR('SQL Developer', 1, 3), -- ���ڿ� �ڸ� 1������ 3���ڸ� (ù���ڰ� 1��)
    LENGTH('HELLO WORLD'),         -- ���ڿ��� ����
    TRIM('    HI   ')              -- �¿� ���� ���� trim
    ,LTRIM('   HELLO      ')   -- ���� ���鸸 ����
    ,RTRIM('   GO      ')
    ,LTRIM('HELLOhello',  'HE')  -- ���ʿ��� �߰ߵ� HE�� ���� ! ��� ���Ŵ� �ȵ�
FROM dual;

SELECT 
    RPAD('Steve', 10, '-'), -- Steve�� ������ �����ʿ� �־��� ���ڸ� ����ŭ ä��
    LPAD('Steve', 10, '*'),  -- ���ʿ� �־��� ���ڸ� ä��
    REPLACE('Java Programmer Java', 'Java', 'BigData') AS "REPLACE" -- ���ڸ� ����
    , REPLACE('Java Programmer', 'Java') AS "REPLACE" -- ���ڸ� ����
FROM dual;

-- SQLD ���� ����
SELECT 
	(LENGTH(C1) - LENGTH(REPLACE(C1, CHR(10))) + 1) AS CC
FROM TAB1;

-- ## ������ ������ �Լ�
SELECT 
    MOD(27, 5) AS MOD, -- ������ �� ��ȯ 2
    CEIL(38.678) AS ceil, -- �ø��� ��ȯ 39
    FLOOR(38.678) AS floor, -- ������ ��ȯ 38
    ROUND(38.678, 2) AS round, -- �ڸ������� �ݿø� 38.68
    TRUNC(38.678, 2) AS trunc  -- �ڸ��� ���ϸ� ���� 38.67
    , ABS(-20) AS abs   -- ���밪
    , SIGN(99) AS sign  -- 0���� ������ -1, 0���� ũ�� 1, 0�̸� 0
FROM dual;

-- ## ������ ��¥�� �Լ�

-- ���� ��¥�� ��ȸ
SELECT SYSDATE
FROM dual;

SELECT SYSTIMESTAMP
FROM dual;

-- ��¥ ����
-- ��¥ + ���� = ��¥  => ��(DAY) ���� ��¥�� ����
-- ��¥ - ���� = ��¥  => ��¥���� �� ���� ��
-- ��¥ - ��¥ = �ϼ�  => � ��¥���� �ٸ� ��¥�� �� �ϼ�
-- ��¥ + ����/24 = ��¥  => ��¥�� �ð��� ����

SELECT 
    SYSDATE AS "���� �ð�",
    SYSDATE - 1 AS "SYSDATE - 1",
    (SYSDATE + 10) - SYSDATE AS "��¥ - ��¥",
    SYSDATE - (1/24) AS "1�ð� ����",
    SYSDATE - (1/24/60) * 100 AS "100�� ����",
    SYSDATE - (1/24/60/60) * 30 AS "30�� ����"
FROM dual;

-- ## ������ ��ȯ �Լ�

-- ��¥�� ���ڷ� ��ȯ (TO_CHAR�Լ�)
-- ��¥ ��������: Y - ����, MM - ���ڸ� ��, D - �ϼ�
-- �ð� ��������: HH12 - ��(1~12), HH24 (0-23), MI - ��, SS - ��
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'MM - DD') AS "�� - ��",
    TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS "��/��/��",
    TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') AS "��¥ - �ѱ�����",
    TO_CHAR(SYSDATE + (1/24) * 6, 'YY/MM/DD HH24:MI:SS') AS "��¥�� �ð�",
    TO_CHAR(SYSDATE - (1/24) * 6, 'YY/MM/DD AM HH12:MI:SS') AS "��¥�� �ð�2"
FROM dual;

-- ���ڸ� ���ڷ� ��ȯ
-- ���� ���� ���� -  $: �޷�ǥ��, L: ����ȭ���ȣ
SELECT
    TO_CHAR(9512 * 1.33, '$999,999.99') AS "�޷�",
    TO_CHAR(1350000, 'L999,999,999') AS "��ȭ"
FROM dual;

-- ���ڸ� ���ڷ� ��ȯ
SELECT 
    TO_NUMBER('$5,500', '$999,999') - 4000 AS "�����"
FROM dual;

-- ���ڸ� ��¥�� ��ȯ �Լ�
SELECT
          TO_DATE('20150101000000', 'YYYYMMDDHH24MISS'),
          TO_DATE('20240101', 'YYYYMMDD'), -- �־����� ���� ���� 00:00���� �ʱ�ȭ
          TO_DATE('202401', 'YYYYMM'), -- �־����� ���� ���� �� 00 �⺻������ ���õǾ� ���� TO_DATE
          TO_CHAR(SYSDATE, 'YYYYMM')   -- ��¥�� ���ڷ� ��ȯ TO_CHAR 
FROM dual;


-- CASEǥ���� DECODE�Լ�
SELECT * FROM tb_sal;

-- Searched expression
SELECT 
    sal_cd, 
    sal_nm,
CASE WHEN sal_cd = '100001' THEN '�⺻�޿�'
            WHEN sal_cd = '100002' THEN '���ʽ��޿�'
            ELSE '��Ÿ'
END sal_name  -- 3��° ���� �߰�
FROM tb_sal;

-- Simple expression
SELECT 
    sal_cd, 
    sal_nm,
    CASE sal_cd 
    	  WHEN '100001' THEN '�⺻�޿�'
          WHEN '100002' THEN '���ʽ��޿�'
         ELSE '��Ÿ'  -- ELSE �ʼ� �ƴ�
     END sal_name  -- �� ����� ���� �÷���
FROM tb_sal;

SELECT
    sal_cd,
    DECODE(sal_cd, '100001', '�⺻�޿�', '100002', '���ʽ��޿�', '��Ÿ') AS sal_name
FROM tb_sal;

SELECT emp_nm, direct_manager_emp_no
FROM tb_emp;

SELECT COALESCE(null, null, 'A', null, 'B')  -- null�� �ƴ� �� �ɸ��� �� �� ������
                 ,NULLIF('A',  'A') -- null
FROM dual;


-- # �� ���� �Լ�
-- ## NVL(expr1, expr2)
-- expr1: Null�� ���� �� �ִ� ���̳� ǥ����
-- expr2: expr1�� Null�� ��� ��ü�� ��
SELECT 
    emp_no
    , emp_nm
    , direct_manager_emp_no
FROM tb_emp
;

SELECT 
    emp_no
    , emp_nm
    , NVL(direct_manager_emp_no, '�ֻ���������') AS ������
FROM tb_emp
;

SELECT 
    -- emp_nm
     NVL(emp_nm, '�������') AS emp_nm,  -- null�� ��ȸ �Ǿ ������ ���� !
     ADDR 
FROM tb_emp
WHERE emp_nm = '������';

SELECT 
    -- emp_nm
     NVL(emp_nm, '�������') AS emp_nm,  
     ADDR 
FROM tb_emp
WHERE emp_nm = '������2';   -- �ƿ� ���������� �ʴ� �Ӽ����� ��ȸ �ȵ�.

SELECT 
    direct_manager_emp_no
FROM tb_emp
WHERE emp_nm = '��ȸ��'  -- ��ȸ ����� null�� ��
;

SELECT 
    --emp_nm
    --MAX(emp_nm)  -- �̸� �� �����ڵ尡 ���� ū �� ã��
    --NVL(emp_nm, '�������') AS emp_nm  -- �ƿ� ��ȸ�� �ȵ�.
    NVL(MAX(emp_nm), '�������') AS emp_nm
FROM tb_emp
WHERE emp_nm = '�̽¿�';  -- �������� �ʴ� �̸��� ��ȸ null ���

-- ## NVL2(expr1, expr2, expr3)
-- expr1�� ���� Null�� �ƴϸ� expr2�� ��ȯ, Null�̸� expr3�� ��ȯ
SELECT 
    emp_nm,
    NVL2(direct_manager_emp_no, '�Ϲݻ��', 'ȸ���') AS ����
FROM tb_emp;

-- ## NULLIF(expr1, expr2)
-- �� ���� ������ NULL����, �ٸ��� expr1 ����
SELECT
    NULLIF('����ȣ', '����ȣ') -- �� �� ������ null
FROM dual;

SELECT
    NULLIF('����ȣ', '������')  -- �� �� �ٸ��� ù��° �� ����
FROM dual;

-- COALESCE(expr1, ...)
-- ���� ǥ���� �� Null�� �ƴ� ���� ���ʷ� �߰ߵǸ� �ش� ���� ����
SELECT 
    COALESCE(NULL, NULL, 3000, 4000)
FROM dual;

SELECT 
    COALESCE(NULL, 5000, NULL, 2000)
FROM dual;

SELECT 
    COALESCE(7000, NULL, NULL, 8000)
FROM dual;