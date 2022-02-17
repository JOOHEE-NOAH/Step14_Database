★ SQL문(structured query language)문
1. 데이타 조작어(DML : Data Manipulation Language)
    : insert, update, delete, merge
2. 데이타 정의어(DDL : Data Definition Language)
    : create, alter, drop, rename, truncate    
3. 데이타검색
    : select 
4. 트랜잭션제어 --작업단위
    : commit, rollback, savepoint
5. 데이타 제어어(DCL : Data Control Language)
    : grant,  revoke --권한 부여, 회수


※ select
[형식]
 select [distinct] [컬럼1,컬럼2,.....][as 별명][ || 연산자][*]
 from 테이블명
 [where 조건절] 

distinct : 중복제거
* : 모든
조건절 : and,or,like,in,between and,is null,is not null
==================================================================================
select * from tab;       --*은 모든 컬럼이라는 뜻 -- 테이블 목록확인하기(조회) / 범위 지정 후 Alt+x
select * from employees;    --employees테이블의 내용확인하기
select * from departments; 

--ex1)employees테이블의 (모든) 사원의 사원번호,이름(last_name),급여 검색
select  employee_id, last_name, salary
from employees;  --대소문자 구분 x, 데이터 영역은 대소문자 구분o

--ex2)employees테이블에서 (모든) 사원의 이름(last_name), 입사일(hire_date), 업무ID(job_id) 만 검색
select last_name, hire_date, job_id
from employees;

--ex3)employees테이블에서 모든 사원의 이름(last_name), 연봉(salary*12)만 검색
select last_name, salary*12 --컬럼을 변수로 보고 연산수행
from employees;

--ex4)별명붙이기(as는 생략가능)
--    employees테이블의 모든 사원의 사원번호,이름(last_name),급여 검색
--    조건) title 사원번호, 이름 ,급여로 출력할것
select employee_id as "사원번호", last_name as 이름, salary "급여"  --as 생략가능, " "생략가능  띄어쓰기(공백) 있는 경우에는 " "처리해줘야함.
from employees;

--ex5) employee테이블에서 사원번호,이름,연봉을 구하시오
--     조건1) 연봉 = 급여 * 12
--     조건2) 제목을 사원번호, 이름, 연봉으로 출력
select employee_id 사원번호, last_name 이름, salary*12 "연봉"  
from employees;

--ex6) 연결연산자( || ) : 컬럼을 연결해서 출력  자바의 +같은 기능
--    first_name과  last_name을 연결해서 출력하시오
--     이   름
--     ------------
--     Ellen   Abel
select first_name || '   ' ||last_name "이	름"-- 작은따옴표- 데이터에 출력/ 큰따옴표: 타이틀에 출력
from EMPLOYEES;

--ex7) 다음처럼 출력하시오
--   사원번호    이  름        연 봉
--   ---------------------------------------------
--    100      Steven King   288000달러 
select employee_id 사원번호, first_name || ' ' ||last_name as "이   름", salary*12 || '달러' as "연   봉" 
from EMPLOYEES;

--ex8) 다음처럼 출력하시오 (last_name, job_id이용)
--     Employee  Detail
--     --------------------
--     King  is a  AD_PRES
select last_name||'  is a  ' ||job_id as "Employee  Detail"
from EMPLOYEES;

--중복제거(distinct)
--ex9)employees테이블에서 부서를 출력하시오
--    조건1)중복되는 부서는 1번만 출력하시오  ---distinct사용
--    조건2)부서별 오름차순으로 보여주시오  -----order by asc;(생략가능)   내림차순은 order by desc;
select distinct department_id
from EMPLOYEES
order by department_id asc;

--ex10) 10번부서 또는 90번부서 사원들의 이름,입사일,부서ID를 출력하시오
select last_name, hire_date, department_id
from EMPLOYEES
where department_id=10 or department_id=90;

--ex11)급여가 2500이상 3500미만인 사원의 이름(last), 입사일, 급여를 검색하시오
select last_name, hire_date, salary
from EMPLOYEES
where salary>=2500 and salary<3500;

--ex12) 급여가 2500이하 이거나 3000이상이면서, 90번 부서인 사원의 이름, 급여, 부서ID를 출력하시오. --3건
--      조건1) 제목은 사원명, 월  급, 부서코드로 하시오
--      조건2) 급여앞에 $를 붙이시오
--      조건3) 사원명은 first_name과 last_name을 연결해서 출력하시오
select first_name || ' ' ||last_name "사원명", '$'||salary "월  급", department_id "부서코드"
from EMPLOYEES
where (salary<=2500 or salary>=3500) and department_id=90;

--ex13) 'King'사원의 모든 컬럼을 표시하시오
select *
from EMPLOYEES
where last_name='King';

select *
from EMPLOYEES
where lower(last_name)='king'; --lower: 데이터를 소문자로 바꿔주는 함수

select *
from EMPLOYEES
where upper(last_name)='KING'; -- upper: 데이터를 대문자로 바꿔주는 함수

-- like  : 문자를 포함
-- '%d'      d로 끝나는 
-- 'a%'      a로 시작하는
-- '%test%'   test가 포함되어있는
-- 예)  select * from employees where first_name like '%net%';

--ex14)업무ID에 CL이 포함되어있는 사원들의 이름,업무ID,부서ID를 출력하시오
select last_name, job_id, department_id
from EMPLOYEES
where job_id like '%CL%';

--ex15) 업무ID가  IT로 시작하는 사원들의 이름,업무ID,부서ID를 출력하시오
select last_name, job_id, department_id
from EMPLOYEES
where job_id like 'IT%';

--ex16) is null / is not null 
--커미션을 받는 사원들의 이름과 급여,커미션을 출력하시오
select last_name, salary, commission_pct
from EMPLOYEES
where commission_pct is not null;

--ex17)커미션을 받지 않는 사원들의 이름과 급여,커미션을 출력하시오
select last_name, salary, commission_pct
from EMPLOYEES
where commission_pct is null;

--ex18) in연산자(or연산자의 다른표현)
--업무ID가  FI_MGR이거나  FI_ACCOUNT인 사원들의 사원번호,이름,업무ID를 출력하시오   --6건
select employee_id, last_name, job_id
from EMPLOYEES
where job_id='FI_MGR' or job_id='FI_ACCOUNT'

select employee_id, last_name, job_id
from EMPLOYEES
where job_id in ('FI_MGR', 'FI_ACCOUNT');

--ex19) between연산자(and연산자의 다른 표현) : 초과,미만에서는 사용할수 없다
--급여가  10000이상  20000이하인 사원의 사원번호,이름,급여를 출력하시오   --18건
select employee_id, last_name, salary
from EMPLOYEES
where salary>=10000 and salary<=20000;

select employee_id, last_name, salary
from EMPLOYEES
where salary between 10000 and 20000;

--[문제1] 업무ID가 'SA_REP' 이거나 'AD_PRES' 이면서, 급여가 15000를 초과하는 
--사원들의 이름,업무ID,급여를 출력하시오
--이름        업무ID            급  여
-- --------------------------------------
--King       AD_PRES            24000원




------------------------------------------------------------------------------
--[문제2] Employees테이블의 업무ID가 중복되지 않게 표시하는 질의를 작성하시오
-- JOB_ID
-- ---------
--AC_ACCOUNT
--AC_MGR
--     :




-----------------------------------------------------------------------------
--[문제3] 입사일이 03년인 사원들의 사원번호,이름,입사일을 표시하시오























