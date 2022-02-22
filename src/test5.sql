[��������(SubQuery)]
: �ϳ��� ������ �ٸ� ������ ���ԵǴ� ����,()��ó��
1) ������ ��������(�������ȯ) :  > , < , >=, <= , <>
     Main Query
               
         Sub  Query      ----->   1 ����� 

2) ������ ��������(�������ȯ) : in, any, all

     Main Query
     
          Sub Query      ----->   �������� ���  
      
       < any : �񱳴���� �ִ밪���� ����
       > any : �񱳴���� �ּҰ����� ŭ   
                  (ex. ���������� �޿��� �޴� �����ȸ)
       =  any : in�����ڿ� ����
       <  all   : �񱳴���� �ּҰ����� ����
       >  all   : �񱳴���� �ִ밪���� ŭ 
                  (ex. ��������� ���޺��� �޿��� ���� �����ȸ)

3) �������(correlated  subquery)   
  : �������� ������ �а� �ش簪�� ������������ �����Ͽ� ������������� �����ϸ� true�� ��ȯ
      exists,  not exists : ���� ���ο� ���� true,false�� ��ȯ

==============================================================================================
--ex1) Neena����� �μ����� �˾Ƴ��ÿ�
select last_name, department_id from employees where first_name='Neena'; ---90
select department_name from departments where department_id=90; -- Executive

select department_name
from departments
where department_id=(select department_id from employees where first_name='Neena');

--ex2) Valli Pataballa��  ������(job_title)�� �˾Ƴ��ÿ�
--[����] job_id(IT_PROG)

select job_title
from jos
where job_id=(select job_id from employees where first_name='Valli' and last_name='Pataballa')

------------------------------------------------------------------------------------------------
--ex3) Alexander Hunold�� �ٹ���(city)�� �˾Ƴ��ÿ�
--[����] department_id(60) -> location_id(1400) -> city(Southlake)
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
--ex4) Steven King�� �ٹ��ϴ� ����(country_name)�� �˾Ƴ��ÿ�
--[����] �� : United States of America
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
--ex5) Diana Lorentz�� �ٹ��ϴ� ����(region_name)�� �˾Ƴ��ÿ� --Americas
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
--ex6) Neena����� �μ����� Neena������� �޿��� ���� �޴� ������� ���Ͻÿ�  ==> 1���ڵ�
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
--ex7) oliver�� ���� ����ID�̸鼭 ���� �μ��� �ƴ� ����� 
--       �̸�(first_name),����ID,�μ�ID�� ����Ͻÿ�  ==> 1���ڵ� 
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
--ex8) Austin�� �����μ��̸鼭 ���� �޿��� �޴»������ �̸�, �μ���, �޿��� ���Ͻÿ� ==> 2 ���ڵ�
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
--ex9) �����޿��� �޴� ������� �̸��� �޿��� ���Ͻÿ�
--       last_name   salary
--       ---------------------
--       Olson         2100  
select last_name, salary
from employees
where salary= (select min(salary) from employees)

------------------------------------------------------------------------------------------------
--ex10) ��ձ޿��� �޴� ������� �̸��� �޿��� ���Ͻÿ�  ==> 2���ڵ�
--       ����1) ��ձ޿��� õ���� �����Ͻÿ�       
--       �����        �޿�
--       ----------------------
--       Ernst          6000
--       Fay            6000
select last_name "�����", salary as "�޿�"
from employees
where salary=(select trunc(avg(salary),-3)
				from employees);

------------------------------------------------------------------------------------------------
--ex11)�μ��� �޿��հ���  �ִ�޿��� �޴� �μ��� 
--     �μ����  �޿��հ踦 ���Ͻÿ�(������ ��������)   ==> 1���ڵ�
--     ����1) �μ��� �޿��հ踦 ���ϰ� �ִ밪�� ���Ѵ�
--     ����2) Ÿ��Ʋ�� �μ���,�޿��հ�� �Ѵ�
--              �μ���    �޿��հ�
--              -----------------------
--               Sales	    304500
select department_name "�μ���", sum(salary) "�޿��հ�"
from employees
join departments using(department_id)
group by department_name
having sum(salary)=(select max(sum(salary))
					from employees
					group by department_id)
------------------------------------------------------------------------------------------------
--ex12) ����ID�� �޿������ ��ü��ձ޿����� ���� �޴� ����ID��  
--      �������  �޿���ո� ���Ͻÿ�(������ ��������)  ==> 6 ���ڵ�
--     ����1) ������ �޿������ ���Ѵ�
--     ����2) �޿������ õ���� �����Ѵ�
--     ����3) Ÿ��Ʋ�� ������,�޿���շ� �Ѵ�
--     ����4) ��� ����� �����Ѵ� (left join)

--               ������                    �޿����
--              ----------------------------------------
--               Programmer	             5000
--               Purchasing Clerk	     2000
--               Marketing Representative    6000
--               Administration Assistant    4000
--               Stock Clerk	             2000
--               Shipping Clerk	             3000
select job_title "������", trunc(avg(salary),-3) "�޿����"
from employees
left join jobs using(job_id)
group by job_title
having avg(salary)<(select avg(salary)
					from employees)
--==================================================================================================
-- ������ ��������
--ex13) 'SA_REP' ���޺��� �޿��� ���� 'ST_MAN'���� �������� ��ȸ�Ͻÿ�    -- 4 ���ڵ�
                                           
--[�м�]
--ST_MAN ����� �޿� 8000, 8200,7900,6500,5800 �� 5800�� ���ܵ�
--SA_REP�� �ּұ޿��� 6100�̱� ����
select distinct salary from employees where job_id='SA_REP' order by 1;
select salary from employees where job_id='ST_MAN' order by 1;
--last_name   job_id   salary
-------------------------------
--Weiss       ST_MAN    8000
--Fripp       ST_MAN    8200
--Kaufling    ST_MAN    7900
--Vollman     ST_MAN    6500
		< any : �񱳴���� �ִ밪���� ����
       > any : �񱳴���� �ּҰ����� ŭ   
                  (ex. ���������� �޿��� �޴� �����ȸ)
       =  any : in�����ڿ� ����
       <  all   : �񱳴���� �ּҰ����� ����
       >  all   : �񱳴���� �ִ밪���� ŭ 
                  (ex. ��������� ���޺��� �޿��� ���� �����ȸ)


select last_name, job_id, salary
from employees
where job_id='ST_MAN'
and salary > any (select distinct salary 
					from employees 
					where job_id='SA_REP')
--sa_rep�� �ּ� ��(�񱳴��)���� ū �޿��� �޴� st_man ���� ���
------------------------------------------------------------------------------------------------
--ex14) 'SA_REP' ������ �ּұ޿����� �޿��� ���� 'ST_MAN'���� �������� ��ȸ�Ͻÿ�   -- 1 ���ڵ�
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
--ex15) 'IT_PROG' ������ ���� ���� �޴� ����� �޿�����,�� �����޿��� �޴�   -- 10 ���ڵ�
--      'FI_ACCOUNT' �Ǵ� 'SA_REP' ���� �������� ��ȸ�Ͻÿ�
--      ����1) �޿������� �������������Ͻÿ�
--      ����2) �޿��� ���ڸ����� �޸�(,) ��� ȭ����� '�޷�'�� ���̽ÿ�
--      ����3) Ÿ��Ʋ��  �����, ����ID, �޿��� ǥ���Ͻÿ�

--      �����      ����ID          �޿�
--      ----------------------------------------
--      Ozer         SA_REP        11,500�޷�
--      Abel         SA_REP        11,000�޷�
--      Vishney      SA_REP        10,500�޷�
select last_name "�����", job_id "����ID", to_char(salary,'999,999') || '�޷�' "�޿�"
from employees
where job_id in ('FI_ACCOUNT','SA_REP')
and salary > all (select salary
					from employees
					where job_id='IT_PROG')
order by 3 desc;
--distinct salary ���� ������ ���� ū���� �ϳ��� ������ �ߺ��̵� �ƴϵ� �ϳ��� �����ϱ� distinct �ᵵ �׸� �Ƚᵵ �׸�.

------------------------------------------------------------------------------------------------
--ex16) 'IT_PROG'�� ���� �޿��� �޴� ������� �̸�,����ID,�޿��� ���� ���Ͻÿ�  ==> 10���ڵ�
--�̸�    ����ID   �޿�
---------------------------
--McEwen   SA_REP   9000
--Hall     SA_REP   9000
--any ���
select last_name "�����", job_id "����ID", salary "�޿�"
from employees
where salary = any (select salary
					from employees
					where job_id='IT_PROG')
order by 3 desc;

-- in ���
select last_name "�����", job_id "����ID", salary "�޿�"
from employees
where salary in (select salary
					from employees
					where job_id='IT_PROG')
order by 3 desc;


-------------------------------------------------------------------------------------------------
--ex17) ��ü������ ���� �����ڿ� ������ �����ϴ� ǥ�ø� �Ͻÿ�(in, not in�̿�)
--        ����1) ���к� ���������ϰ� �����ȣ�� �������������Ͻÿ�
-- �����ȣ      �̸�       ����
-------------------------------------
-- 100                King      ������
--in ������
select employee_id, last_name, manager_id from employees

select employee_id �����ȣ, last_name �̸�, 
		case when employee_id in (select manager_id from employees) then '������' 
		else '����' 
		end as "����"
from employees
order by 3, 1;

--union, in, not in
select employee_id �����ȣ, last_name �̸�, '������' as "����"
from employees
where employee_id in (select manager_id from employees)
union
select employee_id �����ȣ, last_name �̸�, '����' as "����"
from employees
where employee_id not in (select distinct manager_id 
							from employees
							where manager_id is not null)

--�������(correlated  subquery)   
--  : �������� ������ �а� �ش簪�� ������������ �����Ͽ� ������������� �����ϸ� true�� ��ȯ
 --     exists,  not exists : ���� ���ο� ���� true,false�� ��ȯ
--select null : ��ȸ�� ���̺��� ���� �Էµ��� ���� �����͸� �˻��� �� ���

select employee_id �����ȣ, last_name �̸�, '������' as "����"
from employees e
where exists (select null
				from employees
				where e.employee_id=manager_id)
union
select employee_id �����ȣ, last_name �̸�, '����' as "����"
from employees e
where not exists (select null
				from employees
				where e.employee_id=manager_id)
-------------------------------------------------------------------------------------------------
--ex18) ������ ���� ���ǿ� �´� ���� �˻��Ͻÿ�   ==> 28���ڵ�
--      ����1) ���޺� ��ձ޿��� ������ ��� ����� �� �޿��� �޴� ����� ��ȸ�Ͻÿ�
--               (��, 100���� ���� ����)
--      ����2) ����� �޿��� ���ڸ����� �޸��� $ǥ��
--      ����3) ����̸�(last_name),����(job_title) ,�޿�(salary) �� ǥ���Ͻÿ�
--      ����4) �޿������� �������� �����Ͻÿ�

--         ����̸�       ����               �޿�
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
--ex19) group by rollup : a,b�� ����
--�μ���, ����ID�� �޿���ձ��ϱ�(���Ϻμ��� ���� ������ ��ձ޿�)
--����1) �ݿø��ؼ� �Ҽ� 2°�ڸ����� ���Ͻÿ�
--����2) ������ Job_title, Department_name, Avg_sal�� ǥ���Ͻÿ�


------------------------------------------------------------------------------------------------
--ex20) group by cube :  a�� ���� �Ǵ� b�� ����
--�μ���, ����ID�� �޿���ձ��ϱ�(�μ��� �������� ��Ÿ���� ��ձ޿�)      

------------------------------------------------------------------------------------------------
--ex21) group by grouping sets
--������ ��ձ޿��� ��ü����� ��ձ޿��� �Բ� ���Ͻÿ�                 




















          