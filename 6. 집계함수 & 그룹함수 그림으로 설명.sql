-- ## 집계함수 설명
--    이름       급여
    
--    홍길동     200
--    박영희     300
--    김철수     null
--    고길동     500

--     WHERE 급여 > 200

--     SUM(급여) -  300 + 500 = 800

--     WHERE 급여 > 1000

--     SUM(급여) -  null

--     SUM(급여)   -  200 + 300 + 500 = 1000
--     AVG(급여)   -  (200 + 300 + 500) / 3 = 333.33333 
--     COUNT(이름)  -  4
--     COUNT(급여)  -  3
--     COUNT(*)  -  4

-- ## 그룹 함수 설명
--  지역     지역별매출      매출기준년도
--??????????????????

--   서울      300                 2021
--   서울      500                 2021
--   서울      200                 2022
--   부산      200                 2021
--   부산      400                 2022
--   대구      300                 2021
--   대구      200                 2022
--   광주      400                 2022


--  GROUP BY 지역   ->    서울그룹, 부산그룹, 대구그룹, 광주그룹
--  GROUP BY 년도   ->    2021그룹, 2022그룹
--  GROUP BY 지역, 년도   ->    서울+2021그룹, 서울+2022그룹, 부산+2021그룹, …

--   SUM(매출)
--     서울    500
--     부산    600
--     대구    500
--     광주    400


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