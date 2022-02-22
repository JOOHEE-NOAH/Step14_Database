[하위질의(SubQuery)]
: 하나의 쿼리에 다른 쿼리가 포함되는 구조,()로처리
1) 단일행 서브쿼리(단일행반환) :  > , < , >=, <= , <>
     Main Query
               
         Sub  Query      ----->   1 개결과 

2) 다중행 서브쿼리(여러행반환) : in, any, all

     Main Query
     
          Sub Query      ----->   여러개의 결과  
      
       < any : 비교대상중 최대값보다 작음
       > any : 비교대상중 최소값보다 큼   
                  (ex. 과장직급의 급여를 받는 사원조회)
       =  any : in연산자와 동일
       <  all   : 비교대상중 최소값보다 작음
       >  all   : 비교대상중 최대값보다 큼 
                  (ex. 모든과장들의 직급보다 급여가 많은 사원조회)

3) 상관쿼리(correlated  subquery)   
  : 메인쿼리 한행을 읽고 해당값을 서브쿼리에서 참조하여 서브쿼리결과에 존재하면 true를 반환
      exists,  not exists : 존재 여부에 따라 true,false을 반환

==============================================================================================
--ex1) Neena사원의 부서명을 알아내시오
select last_name, department_id from employees where first_name='Neena'; ---90
select department_name from departments where department_id=90; -- Executive

select department_name
from departments
where department_id=(select department_id from employees where first_name='Neena');

--ex2) Valli Pataballa의  직업명(job_title)을 알아내시오
--[참고] job_id(IT_PROG)

select job_title
from jos
where job_id=(select job_id from employees where first_name='Valli' and last_name='Pataballa')

------------------------------------------------------------------------------------------------
--ex3) Alexander Hunold의 근무지(city)를 알아내시오
--[참고] department_id(60) -> location_id(1400) -> city(Southlake)
select city
from locations
where location_id=(select location_id
					from departments
					where department_id=(select department_id
										from employees
										where first_name='Alexander' and last_name='Hunold'))

select location_id
from departments
where department_id=(select department_id
from employees
where first_name='Alexander' and last_name='Hunold')

select department_id
from employees
where first_name='Alexander' and last_name='Hunold'
------------------------------------------------------------------------------------------------
--ex4) Steven King가 근무하는 나라(country_name)를 알아내시오
--[참고] 답 : United States of America
select country_name
from countries
where country_id=(select country_id
					from locations
					where location_id=(select location_id
										from departments
										where department_id=(select department_id
															from employees
															where first_name='Steven' and last_name='King')))

select country_id
from locations
where location_id=(select location_id
from departments
where department_id=(select department_id
from employees
where first_name='Steven' and last_name='King'))

select location_id
from departments
where department_id=(select department_id
from employees
where first_name='Steven' and last_name='King')

select department_id
from employees
where first_name='Steven' and last_name='King'


------------------------------------------------------------------------------------------------
--ex5) Diana Lorentz가 근무하는 지역(region_name)을 알아내시오 --Americas
select region_name
from regions
where region_id=(select region_id
				from countries
				where country_id=(select country_id
									from locations
									where location_id=(select location_id
														from departments
														where department_id=(select department_id
																			from employees
																			where first_name='Diana' and last_name='Lorentz'))))
------------------------------------------------------------------------------------------------
--ex6) Neena사원의 부서에서 Neena사원보다 급여를 많이 받는 사원들을 구하시오  ==> 1레코드
--                             (90)                         (17000)
--first_name    department_id    salary
-- ----------------------------------------
--Steven	     90	           24000
select first_name, department_id, salary
from employees
where department_id=(select department_id
		 			from employees
		 			where first_name='Neena')
and salary > (select salary 
			  from  employees
			  where first_name='Neena')

select first_name, department_id, salary
from employees
where department_id=90 and salary > 17000
-----------------------------------------------------------------------------------------------
--ex7) oliver와 같은 업무ID이면서 같은 부서가 아닌 사원의 
--       이름(first_name),업무ID,부서ID를 출력하시오  ==> 1레코드 
--                        (SA_REP)  (80)       
--      first_name        job_id        department_id
--      ------------------------------------------------
--      Kimberely	        SA_REP	
select first_name, job_id, department_id
from employees
where job_id= (select job_id
				from employees 
				where lower(first_name)='oliver')
and nvl(department_id,0)!=(select department_id
							from employees 
							where lower(first_name)='oliver')

select first_name, job_id, department_id
from employees
where job_id='SA_REP' and nvl(department_id, 0)!=80


------------------------------------------------------------------------------------------------
--ex8) Austin과 같은부서이면서 같은 급여를 받는사원들의 이름, 부서명, 급여를 구하시오 ==> 2 레코드
--                   (60)                  (4800)
             
--        last_name     department_name   salary
--       -------------------------------------------------  
--       Austin	             IT            4800
--       Pataballa           IT            4800     


select last_name, department_name , salary
from employees
join departments using(department_id)
where department_id=(select department_id
					from employees
					where last_name='Austin')
and salary=(select salary
			from employees
			where last_name='Austin')
------------------------------------------------------------------------------------------------
--ex9) 최저급여를 받는 사원들의 이름과 급여를 구하시오
--       last_name   salary
--       ---------------------
--       Olson         2100  
select last_name, salary
from employees
where salary= (select min(salary) from employees)

------------------------------------------------------------------------------------------------
--ex10) 평균급여를 받는 사원들의 이름과 급여를 구하시오  ==> 2레코드
--       조건1) 평균급여를 천단위 절삭하시오       
--       사원명        급여
--       ----------------------
--       Ernst          6000
--       Fay            6000
select last_name "사원명", salary as "급여"
from employees
where salary=(select trunc(avg(salary),-3)
				from employees);

------------------------------------------------------------------------------------------------
--ex11)부서별 급여합계중  최대급여를 받는 부서의 
--     부서명과  급여합계를 구하시오(단일행 서브쿼리)   ==> 1레코드
--     조건1) 부서별 급여합계를 구하고 최대값을 구한다
--     조건2) 타이틀은 부서명,급여합계로 한다
--              부서명    급여합계
--              -----------------------
--               Sales	    304500
select department_name "부서명", sum(salary) "급여합계"
from employees
join departments using(department_id)
group by department_name
having sum(salary)=(select max(sum(salary))
					from employees
					group by department_id)
------------------------------------------------------------------------------------------------
--ex12) 업무ID별 급여평균중 전체평균급여보다 적게 받는 업무ID의  
--      업무명과  급여평균를 구하시오(단일행 서브쿼리)  ==> 6 레코드
--     조건1) 업무별 급여평균을 구한다
--     조건2) 급여평균은 천단위 절삭한다
--     조건3) 타이틀은 업무명,급여평균로 한다
--     조건4) 모든 사원을 포함한다 (left join)

--               업무명                    급여평균
--              ----------------------------------------
--               Programmer	             5000
--               Purchasing Clerk	     2000
--               Marketing Representative    6000
--               Administration Assistant    4000
--               Stock Clerk	             2000
--               Shipping Clerk	             3000
select job_title "업무명", trunc(avg(salary),-3) "급여평균"
from employees
left join jobs using(job_id)
group by job_title
having avg(salary)<(select avg(salary)
					from employees)
--==================================================================================================
-- 다중행 서브쿼리
--ex13) 'SA_REP' 직급보다 급여가 많은 'ST_MAN'직급 직원들을 조회하시오    -- 4 레코드
                                           
--[분석]
--ST_MAN 사원의 급여 8000, 8200,7900,6500,5800 중 5800만 제외됨
--SA_REP의 최소급여는 6100이기 때문
select distinct salary from employees where job_id='SA_REP' order by 1;
select salary from employees where job_id='ST_MAN' order by 1;
--last_name   job_id   salary
-------------------------------
--Weiss       ST_MAN    8000
--Fripp       ST_MAN    8200
--Kaufling    ST_MAN    7900
--Vollman     ST_MAN    6500
		< any : 비교대상중 최대값보다 작음
       > any : 비교대상중 최소값보다 큼   
                  (ex. 과장직급의 급여를 받는 사원조회)
       =  any : in연산자와 동일
       <  all   : 비교대상중 최소값보다 작음
       >  all   : 비교대상중 최대값보다 큼 
                  (ex. 모든과장들의 직급보다 급여가 많은 사원조회)


select last_name, job_id, salary
from employees
where job_id='ST_MAN'
and salary > any (select distinct salary 
					from employees 
					where job_id='SA_REP')
--sa_rep의 최소 값(비교대상)보다 큰 급여를 받는 st_man 직급 사원
------------------------------------------------------------------------------------------------
--ex14) 'SA_REP' 직급의 최소급여보다 급여가 적은 'ST_MAN'직급 직원들을 조회하시오   -- 1 레코드
--last_name   job_id   salary
-------------------------------
--Mourgos	ST_MAN	5800
select last_name, job_id, salary
from employees
where job_id='ST_MAN'
and salary < all (select distinct salary 
					from employees 
					where job_id='SA_REP')
-------------------------------------------------------------------------------------------------
--       (9000,4800,4200,6000)
--ex15) 'IT_PROG' 직급중 가장 많이 받는 사원의 급여보다,더 많은급여를 받는   -- 10 레코드
--      'FI_ACCOUNT' 또는 'SA_REP' 직급 직원들을 조회하시오
--      조건1) 급여순으로 내림차순정렬하시오
--      조건2) 급여는 세자리마다 콤마(,) 찍고 화폐단위 '달러'을 붙이시오
--      조건3) 타이틀은  사원명, 업무ID, 급여로 표시하시오

--      사원명      업무ID          급여
--      ----------------------------------------
--      Ozer         SA_REP        11,500달러
--      Abel         SA_REP        11,000달러
--      Vishney      SA_REP        10,500달러
select last_name "사원명", job_id "업무ID", to_char(salary,'999,999') || '달러' "급여"
from employees
where job_id in ('FI_ACCOUNT','SA_REP')
and salary > all (select salary
					from employees
					where job_id='IT_PROG')
order by 3 desc;
--distinct salary 에서 어차피 가장 큰값은 하나만 나오니 중복이든 아니든 하나만 나오니까 distinct 써도 그만 안써도 그만.

------------------------------------------------------------------------------------------------
--ex16) 'IT_PROG'와 같은 급여를 받는 사원들의 이름,업무ID,급여를 전부 구하시오  ==> 10레코드
--이름    업무ID   급여
---------------------------
--McEwen   SA_REP   9000
--Hall     SA_REP   9000
--any 사용
select last_name "사원명", job_id "업무ID", salary "급여"
from employees
where salary = any (select salary
					from employees
					where job_id='IT_PROG')
order by 3 desc;

-- in 사용
select last_name "사원명", job_id "업무ID", salary "급여"
from employees
where salary in (select salary
					from employees
					where job_id='IT_PROG')
order by 3 desc;


-------------------------------------------------------------------------------------------------
--ex17) 전체직원에 대한 관리자와 직원을 구분하는 표시를 하시오(in, not in이용)
--        조건1) 구분별 오름차순하고 사원번호별 오름차순정렬하시오
-- 사원번호      이름       구분
-------------------------------------
-- 100                King      관리자
--in 연산자
select employee_id, last_name, manager_id from employees

select employee_id 사원번호, last_name 이름, 
		case when employee_id in (select manager_id from employees) then '관리자' 
		else '직원' 
		end as "구분"
from employees
order by 3, 1;

--union, in, not in
select employee_id 사원번호, last_name 이름, '관리자' as "구분"
from employees
where employee_id in (select manager_id from employees)
union
select employee_id 사원번호, last_name 이름, '직원' as "구분"
from employees
where employee_id not in (select distinct manager_id 
							from employees
							where manager_id is not null)

--상관쿼리(correlated  subquery)   
--  : 메인쿼리 한행을 읽고 해당값을 서브쿼리에서 참조하여 서브쿼리결과에 존재하면 true를 반환
 --     exists,  not exists : 존재 여부에 따라 true,false을 반환
--select null : 조회할 테이블에서 값이 입력되지 않은 데이터를 검색할 때 사용

select employee_id 사원번호, last_name 이름, '관리자' as "구분"
from employees e
where exists (select null
				from employees
				where e.employee_id=manager_id)
union
select employee_id 사원번호, last_name 이름, '직원' as "구분"
from employees e
where not exists (select null
				from employees
				where e.employee_id=manager_id)
-------------------------------------------------------------------------------------------------
--ex18) 다음과 같은 조건에 맞는 행을 검색하시오   ==> 28레코드
--      조건1) 직급별 평균급여를 구한후 모든 사원중 그 급여를 받는 사원을 조회하시오
--               (단, 100단위 이하 절삭)
--      조건2) 출력할 급여는 세자리마다 콤마와 $표시
--      조건3) 사원이름(last_name),직무(job_title) ,급여(salary) 로 표시하시오
--      조건4) 급여순으로 오름차순 정렬하시오

--         사원이름       직무               급여
--         ---------------------------------------
--         Higgins      Accounting Manager   $12,008
--         Errazuriz    Sales Manager	     $12,000
--         Greenberg    Finance Manager	     $12,008
select last_name, job_title, salary
from employees
join jobs using(job_id)
where trunc(salary,-2) in (select trunc(avg(salary),-2)
								from employees
								group by job_id)




------------------------------------------------------------------------------------------------
--ex19) group by rollup : a,b별 집계
--부서별, 직무ID별 급여평균구하기(동일부서에 대한 직무별 평균급여)
--조건1) 반올림해서 소수 2째자리까지 구하시오
--조건2) 제목은 Job_title, Department_name, Avg_sal로 표시하시오


------------------------------------------------------------------------------------------------
--ex20) group by cube :  a별 집계 또는 b별 집계
--부서별, 직무ID별 급여평균구하기(부서를 기준으로 나타내는 평균급여)      

------------------------------------------------------------------------------------------------
--ex21) group by grouping sets
--직무별 평균급여와 전체사원의 평균급여를 함께 구하시오                 




















          