-- ## �����Լ� ����
--    �̸�       �޿�
    
--    ȫ�浿     200
--    �ڿ���     300
--    ��ö��     null
--    ��浿     500

--     WHERE �޿� > 200

--     SUM(�޿�) -  300 + 500 = 800

--     WHERE �޿� > 1000

--     SUM(�޿�) -  null

--     SUM(�޿�)   -  200 + 300 + 500 = 1000
--     AVG(�޿�)   -  (200 + 300 + 500) / 3 = 333.33333 
--     COUNT(�̸�)  -  4
--     COUNT(�޿�)  -  3
--     COUNT(*)  -  4

-- ## �׷� �Լ� ����
--  ����     ����������      ������س⵵
--??????????????????

--   ����      300                 2021
--   ����      500                 2021
--   ����      200                 2022
--   �λ�      200                 2021
--   �λ�      400                 2022
--   �뱸      300                 2021
--   �뱸      200                 2022
--   ����      400                 2022


--  GROUP BY ����   ->    ����׷�, �λ�׷�, �뱸�׷�, ���ֱ׷�
--  GROUP BY �⵵   ->    2021�׷�, 2022�׷�
--  GROUP BY ����, �⵵   ->    ����+2021�׷�, ����+2022�׷�, �λ�+2021�׷�, ��

--   SUM(����)
--     ����    500
--     �λ�    600
--     �뱸    500
--     ����    400


CREATE TABLE quiz_50 (
          col1 NUMBER(10),
          col2 NUMBER(10),
          col3 NUMBER(10)
          );
          
INSERT INTO quiz_50 VALUES (10, 20, null);
INSERT INTO quiz_50 VALUES (15, null, null);
INSERT INTO quiz_50 VALUES (50, 70, 20);
          
SELECT *
FROM quiz_50;
          
SELECT SUM(col2)
FROM quiz_50;
          
SELECT SUM(col1 + col2 + col3)
FROM quiz_50;   -- null + null + 140 = 140
          
SELECT SUM(col1) + SUM(col3)
FROM quiz_50;   -- 75 + 20 = 95