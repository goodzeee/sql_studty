-- CREATE ���̺� ����
CREATE TABLE goods (
          id NUMBER (6) PRIMARY KEY,
          goods_name VARCHAR2 (10) NOT NULL,
          price NUMBER (10) DEFAULT 1000,
          reg_date DATE -- ��¥ ������ ���� Ÿ������ ���� X
);

-- INSERT ����
INSERT INTO goods
         (id, goods_name, price, reg_date) 
VALUES
          (1, '��ǳ��', 120000, SYSDATE);
          
INSERT INTO goods
         (id, goods_name, price, reg_date) 
VALUES
          (2, '��Ź��', 2000000, SYSDATE);
          
INSERT INTO goods
         (id, goods_name, reg_date) 
VALUES
          (3, '�ް�', SYSDATE);
          
INSERT INTO goods
         (id, goods_name) 
VALUES
          (4, '���'); -- 12����Ʈ
          
INSERT INTO goods
         (goods_name, id, reg_date, price) 
VALUES
          ('������', 5, SYSDATE, '49000'); -- NUMBER '300' ����ó�� ��� ����
          
INSERT INTO goods
-- �÷��� ������ ���̺� ���� ������� �ڵ� ���Ե�.
VALUES
          (6, '�����', 5000000, SYSDATE);
SELECT * FROM goods;


-- UPDATE ����
UPDATE goods
SET goods_name = '������'
WHERE id = 1;  -- where ������ ������ �κ�

-- where ������ ������ �ش� �Ӽ��� �� ��ü ����
UPDATE goods
SET price = 9999; -- DML�� ����ؼ� ������ �� ����.

UPDATE tbl_user
SET age = age + 1;

UPDATE goods
SET id = 11
WHERE id = 4;

UPDATE goods
SET price = null
WHERE id = 3;

UPDATE goods
SET goods_name = 'û����', price = 59000
WHERE id = 3;
SELECT * FROM goods;


-- DELETE ����
-- ���Ű� �����ϰ� ������ ������ ��ü ���� �ٸ� DML�� ���� ����
DELETE FROM goods
WHERE id = 11;
-- <���� SQL 3>
DELETE FROM goods;
TRUNCATE TABLE goods; -- ���� �Ұ�
DROP TABLE goods; -- ���� ����

SELECT * FROM goods;


-- SELECT ��ȸ �⺻
SELECT 
       certi_cd, certi_nm, issue_insti_nm -- ���� �ٲ㼭 ��ȸ ����
FROM tb_certi;

SELECT 
       *       -- �Ӽ� ��ü ��ȸ
FROM tb_certi;
 
SELECT DISTINCT  -- �ߺ� ����
       certi_nm, issue_insti_nm  -- ���ϴ� �Ӽ��� �̾Ƽ� ��ȸ
FROM tb_certi;

-- �� ��Ī �ο� AS "����"
SELECT
       emp_nm AS "�����",
       addr AS "�ּ�"
FROM tb_emp;

-- ��Ī AS "" �� �� ���� ����
SELECT
       emp_nm �����,
       addr "������ �ּ�"   -- ���� ���� �� " " ����
FROM tb_emp;

-- ���ڿ� �����ϱ� || -> + ���� �ǹ�    /  ��Ī�Ἥ �Ӽ��� �ٲ��ֱ�
SELECT
       '�ڰ��� : ' || certi_nm AS "�ڰ��� ����"
FROM tb_certi;

SELECT
       certi_nm || ' ( ' || issue_insti_nm || ' ) '  AS "�ڰ��� ����"
FROM tb_certi;