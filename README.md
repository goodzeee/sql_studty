# sql_studty
<br>
-DDL : CREATE ALTER DROP <br>
-DML : SELECT INSERT UPDATE DELETE <br>
<br>

- 집계함수 : COUNT , SUM , MAX , MIN <br>
- 그룹절 : GROUP BY 그룹화 HAVING 그룹화 조건절 <br>
- 정렬 : ORDER BY 정렬 기준 속성 [ASC / DESC] <br>
<br>

- 조인 <br>
  1. CROSS JOIN : 조건절 없어서 모든 테이블 조인되어 중복된 조회 결과가 나옴. <br>
  2. INNER JOIN : 조건절에 공통된 컬럼을 적어 중복 조회되지 않도록 함.
     INNER JOIN 조인할 테이블 <br>
     ON 공통된 컬럼명 명시하는 조건절 <br>
     ON 변칙 문법 = USING (공통된 컬럼명만 명시) : * 컬럼 조회줄에서 공통된 컬럼을 갖는 것 앞에 테이블 명시 금지 !!!<br>
  3. NATURAL JOIN : 자동으로 공통된 컬럼을 찾아줌. (n개의 공통된 컬럼 존재 -> n개 조인 조건을 갖는 것) <br>
  * 컬럼 조회줄에서 공통된 컬럼을 갖는 것 앞에 테이블 명시 금지 !!!


