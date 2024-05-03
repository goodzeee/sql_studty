
-- OUTER JOIN 실습환경 세팅
-- tb_dept 부서 2개 추가
INSERT INTO tb_dept VALUES ('100014', '4차산업혁명팀', '999999');
INSERT INTO tb_dept VALUES ('100015', '포스트코로나팀', '999999');
COMMIT;

SELECT * FROM tb_dept;

ALTER TABLE tb_emp DROP CONSTRAINT fk_tb_emp01;

-- tb_emp 사원 정보 5명 추가
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000041', '이순신', '19811201', '1', '경기도 용인시 수지구 죽전1동 435', '010-5656-7878',
        NULL, '006', '003', '114-554-223433', '000000', 'N');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000042', '정약용', '19820402', '1', '경기도 고양시 덕양구 화정동 231', '010-4054-6547',
        NULL, '004', '001', '110-223-553453', '000000', 'Y');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000043', '박지원', '19850611', '1', '경기도 수원시 팔달구 매탄동 553', '010-1254-1116',
        NULL, '004', '001', '100-233-664234', '000000', 'N');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000044', '장보고', '19870102', '1', '경기도 성남시 분당구 정자동 776', '010-1215-8784',
        NULL, '004', '002', '180-345-556634', '000000', 'Y');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000045', '김종서', '19880824', '1', '경기도 고양시 일산서구 백석동 474', '010-3687-1245',
        NULL, '004', '002', '325-344-45345', '000000', 'Y');
        
COMMIT;
    
 -- 사원 테이블엔 dept_cd 부서 코드 없음
SELECT * FROM tb_emp ORDER BY emp_no DESC;

SELECT emp_no, emp_nm, dept_cd 
FROM tb_emp ORDER BY emp_no DESC;

-- 부서 테이블엔 dept_cd 부서 코드 존재
SELECT * FROM tb_dept;

-- 사원명과 소속부서명을 조회 = inner join으로 부서 코드가 없는 사원은 조회 안됨.
SELECT e.emp_nm, d.dept_nm
FROM tb_emp e
INNER JOIN tb_dept d
ON e.dept_cd = d.dept_cd;

-- ex) 회원정보와 회원의 주문내역을 조회 = INNER JOIN 주문을 한 번이라도 했어야 조회 가능 !!

-- # OUTER JOIN
-- 1. 조인 조건을 만족하지 않는 행들도 조회할 때 사용하는 조인기법입니다.
-- 2. OUTER조인 연산자 기호는 (+)기호입니다.
-- 3. INNER조인은 조인 조건을 만족하지 않으면 해당 행을 조회하지 않습니다
--   그러나 OUTER JOIN은 방향(LEFT, RIGHT, FULL)에 맞게 조건에 매칭되지 
--   않는 행들도 모두 NULL로 처리해서 조회합니다.

-- ## 표준 LEFT OUTER JOIN ( = LEFT JOIN)
-- 조인되는 왼쪽 테이블은 모두 조회하고, 오른쪽 테이블은 조인조건에 매칭된 것만 조회합니다.
-- 나는 사원정보는 일단 다 보고 싶은데 혹시 부서테이블에서 부서코드가 매칭되면
-- 보너스로 부서이름도 찍어줘라

-- 사원명과 부서명 조회 : 사원정보는 일단 다 조회
SELECT e.emp_nm, d.dept_nm
FROM tb_emp e LEFT OUTER JOIN tb_dept d -- 왼쪽 테이블 사원은 모두 조회해줘 오른쪽은 조건에 매칭된 것만 조회
ON e.dept_cd = d.dept_cd;   -- 사원정보는 다 조회하는 대신 부서명이 없는 값은 null
-- 매칭이 안된 값은 NULL로 처리 !!
SELECT *
FROM tb_emp e LEFT OUTER JOIN tb_dept d 
ON e.dept_cd = d.dept_cd; 

-- ## 오라클 OUTER JOIN
-- LEFT : 조인 조건에서 오른쪽에 (+) 붙임 / RIGHT : 조인 조건에서 왼쪽에 (+) 붙임
-- FULL : 지원하지 않음.
-- + 가 붙으면 표준 조인에서 ON절에 위치하는 조건
SELECT e.emp_nm, d.dept_nm
FROM tb_emp e, tb_dept d
WHERE e.dept_cd = d.dept_cd(+);  -- 사원 모두 조회하기 위해 LEFT -> 조인 조건 오른쪽에 (+)

-- # RIGHT OUTER JOIN
-- 조인되는 오른쪽 테이블은 모두 조회하고, 왼쪽 테이블은 조건에 매칭된것만 조회
-- 나는 모든 부서정보를 조회하고 싶은데 혹시 부서코드가 일치하는 사원이 있으면 함께 조회해줘
SELECT e.emp_nm, d.dept_nm
FROM tb_emp e RIGHT OUTER JOIN tb_dept d -- 오른쪽 부서명 다 조회
ON e.dept_cd = d.dept_cd;

SELECT *
FROM tb_emp e RIGHT OUTER JOIN tb_dept d
ON e.dept_cd = d.dept_cd;

SELECT e.emp_nm, d.dept_nm
FROM tb_emp e, tb_dept d          -- RIGHT JOIN 부서 다 조회 -> 조인 조건 왼쪽에 (+)
WHERE e.dept_cd(+) = d.dept_cd;

-- ## FULL OUTER JOIN
-- 왼쪽 조인테이블, 오른쪽 조인테이블을 모두 보여주고 매칭되면 매칭데이터까지 합쳐서 보여줌
SELECT 
    A.emp_no, A.emp_nm, B.dept_cd, B.dept_nm
FROM tb_emp A FULL OUTER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
ORDER BY A.emp_no;
-- 사원이 46명, 부서가 16개
-- 부서에 소속된 사원이 41명
-- 사원이 존재하는 부서 14개
-- INNER JOIN 결과 : 41건 ( 조인 조건 결과만 )
-- LEFT JOIN 결과 : INNER 41 + 부서가 없는 사원 5 = 46건
-- RIGHT JOIN 결과 : INNER 41 + 사원이 없는 부서 2 = 43건
-- FULL JOIN 결과 : 41 + 5 + 2 = 48건 (왼.온 다 포함 !!)

-- ## SELF JOIN (자기 자신 테이블 하나 더 만들어)
-- 1. 하나의 테이블에서 자기 자신의 테이블끼리 조인하는 기법입니다.
-- 2. 자기 자신 테이블에서 pk와 fk로 동등조인합니다.
SELECT e.emp_no "사원번호", e.emp_nm "사원명", e.addr "사원 주소", e.direct_manager_emp_no "직속상사 사번", ee.emp_nm "상사명",  ee.direct_manager_emp_no "상사 사번"
FROM tb_emp e
LEFT JOIN tb_emp ee  -- 자기 자신 테이블과 조인 !
ON e.direct_manager_emp_no = ee.emp_no; 

