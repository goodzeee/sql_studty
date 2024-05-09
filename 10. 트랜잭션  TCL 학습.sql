DROP TABLE student;

-- ## Ʈ�����
CREATE TABLE student (
          id NUMBER PRIMARY KEY,
          name VARCHAR2(100),
          age NUMBER);
          
INSERT INTO student VALUES (1, '���浿', 15);
INSERT INTO student VALUES (2, '�ڼ���', 14);

SELECT *
FROM student;

COMMIT;  -- ���� �� �ѹ�� ���ƿ��� ����

INSERT INTO student VALUES (3, '�����', 12);

ROLLBACK;

-- ex) ���� ��ü 
UPDATE account
SET balance = balance + 5000
WHERE name = '���浿';

UPDATE account
SET balance = balance - 5000
WHERE name = '�ڿ���';

COMMIT;  -- ���� ��ü ��� & �Ա� �Ϸ� �� Ŀ�� !

-- DELETE <---> TRUNCATE
DELETE FROM student;  -- delete �л� ���̺� ����
-- Ŀ���� ���·� �ѹ� ���ư��� ! 
ROLLBACK;

TRUNCATE TABLE student;   -- truncate �л� ���̺� ���� �� �ǵ��ư� �� ����.

-- ����Ŭ�� DDL ����� �ڵ� Ŀ�� / SQL Server�� �ڵ� Ŀ���� �ȵ�.