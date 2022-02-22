[SET operator]
두개 이상의 쿼리결과를 하나로 결합시키는 연산자

1. UNION      : 양쪽쿼리를 모두 포함(중복 결과는 1번만 포함)     --> 합집합
2. UNION  ALL : 양쪽쿼리를 모두 포함(중복 결과도 모두 포함)  
3. INTERSECT  : 양쪽쿼리 결과에 모두 포함되는 행만 표현          --> 교집합
4. MINUS      : 쿼리1결과에 포함되고 쿼리2결과에는 포함되지 않는 행만 표현 -->차집합

[연습용테이블]
drop table employees_role purge;

create table employees_role
as  select * from employees  where 1=0;         -- 테이블 구조만 복사

select * from tab;
select * from employees_role;

insert into employees_role  values(101,'Neena','Kochhar','NKOCHHAR','515.123.4568',
'2005-09-21','AD_VP',17000.00,NULL,100,90);

insert into employees_role  values(101,'Neeno','Kochhar','NKOCHHAR','515.123.4568',
'2005-09-21','AD_VP',17000.00,NULL,100,90);

insert into employees_role values(300,'Harry','Potter','porter','010.123.4567',
'2007-03-01','IT_PROG',23000.00,NULL,100,90);
commit;

select * from employees_role;

delete from employees_role where first_name='Harry';
==================================================================================
--ex1) union 
--     employees테이블과 employees_role테이블을 union으로 연결하시오  ==> 108레코드
--     조건1) employee_id, last_name이 같을경우 중복제거 하시오
--     조건2) 출력
--               emoloyee_id   last_name
--               ----------------------------

--employee_id   first_name    last_name
--101              Neena         Kochhar   <-- employees , employees_role둘다 있음
--101              Neeno         Kochhar   <-- employees_role에만 있음
select employee_id, last_name
from employees
union
select employee_id, last_name
from employees_role
order by 1;

--ex2) union all
--     employees테이블과 employees_role테이블을 union all으로 연결하시오  ==> 110레코드
--     조건1) employee_id, last_name이 같을경우 중복 하시오
--     조건2) 출력
--               emoloyee_id   last_name
--               ----------------------------
select employee_id, last_name
from employees
union all
select employee_id, last_name
from employees_role
order by 1;

--ex3) minus
--    employees_role과 중복되는 레코드는 제거하고 employees에만 있는 사원명단을 
--    구하시오 (단, employee_id, last_name만 표시)   ==> 106 레코드
  
--     emoloyee_id   last_name
--     ----------------------------
select employee_id, last_name
from employees
minus
select employee_id, last_name
from employees_role
order by 1;

--ex4) intersect(교집합)
--     employees와 employees_role에서 중복되는 레코드의 사원명단을 구하시오
--     (단, employee_id, last_name만 표시)   ==> 1 레코드
select employee_id, last_name
from employees
intersect
select employee_id, last_name
from employees_role
order by 1;

--ex5) employees와 employees_role에서  중복되는 레코드의 사원명단을 구하시오  ==> 1 레코드
--        조건1) 사원이름, 업무ID,입사일을 표시하시오
--        조건2) 부서번호가 90인사원만 표시하시오
select last_name, job_id, hire_date
from employees
where department_id=90
intersect
select last_name, job_id, hire_date
from employees_role
where department_id=90
order by 1;

--ex6) union구문을 이용하여 50번 부서원의 대표이사와 직원을 구하시오
--employee_id     last_name    구분
---------------------------------------
--100             King         대표이사              
--120             Weiess         직원
--121             Fripp          직원 
--                 :

--(분석) select * from employees where department_id=50;

select employee_id, last_name, '대표이사' "구분"
from employees
where employee_id=100
union
select employee_id, last_name, '직원' "구분"
from employees
where department_id=50;

--ex7) 기타
select 'SQL을 공부하고 있습니다' 문장, 3 순서 from dual
union
select 'it programmer 과정에서', 1 from dual
union
select '아주 재미있게', 2 from dual
order by 2 asc;

--ex8) SET operator과  IN operator(join같은거-근데 join이 코드 양이 더 적음)관계
--job_title이   'Stock Manager' 또는  'Programmer'인 사원들의 사원명과 job_title을 표시하시오
--last_name       job_title
--------------------------------
--Kaufling        StockManager
--Hunlod          Programmer
--           :
--join, in 사용. select* from employees
select last_name, job_title
from employees
join jobs using(job_id)
where job_title in('Stock Manager','Programmer')
---join,union
select last_name, job_title
from employees
join jobs using(job_id)
where job_title ='Stock Manager'
union
select last_name, job_title
from employees
join jobs using(job_id)
where job_title='Programmer'

--ex9) 컬럼명이 다른경우의 SET operator
--     : 쿼리1과 쿼리2의 select 목록은 반드시동일(컬럼갯수,데이터타입)해야 하므로 
--       이를 위해 Dummy Column(null 사용)을 사용할수 있다
select last_name, employee_id, hire_date
from employees
where department_id=20
union
select department_name, department_id,null
from departments
where department_id=20






















