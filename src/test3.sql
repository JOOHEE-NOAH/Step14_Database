�� select 
select [distinct] [�÷�1,�÷�2,.....][as ����][ || ������][*]  --- 6
from ���̺��     --- 1
[where ������]    --- 2
[group by �÷���]  --- 3
[having ������]   --- 4
[order by �÷��� asc|desc ]  --- 5

group by : �׷��Լ�(max,min,sum,avg,count..)�� ���� ��� (~����)
having : ������� �׷��� ������
==================================================================================
--ex1) ������̺��� �޿��� ����� ���Ͻÿ�
--     ����)�Ҽ����ϴ� ����,���ڸ����� �޸�(,)
--     ����޿����
--     ------------
--            6,461
select to_char(trunc(avg(salary)),'999,999') "����޿����"
from employees

--ex2) �μ����� �޿������ ���ؼ� �μ�ID, �޿������ ����Ͻÿ�
select department_id, to_char(trunc(avg(salary)),'999,999') 
from employees
group by department_id
order by 1;

--ex3) ����ID�� �޿��� �հ踦 ���ؼ� ����ID, �޿��հ踦 ����Ͻÿ�
select job_id, to_char(sum(salary),'999,999') "�޿��հ�"
from employees
group by job_id
order by 1;

--ex4) �μ��� �޿������ ���ؼ� �����,�μ��� �޿������ ����Ͻÿ� (X)
select last name, department_id, to_char(avg(salary),'999,999') "�޿����" --�μ����� ��� �̸������� ��� �ȵ� (����)
from employees
group by department_id
order by 1;

--ex5) group by / having��
-- �μ��� �޿������ ���ؼ� ��ձ޿���  6000�̻��� �μ��� ���  (8 ���ڵ�)
-- (��ձ޿��� �Ҽ��� ���� ����)
--      �μ�ID   ��ձ޿�
--     -----------------------
--        100       8600
select department_id �μ�ID, to_char(trunc(avg(salary)),'999,999') ��ձ޿�
from employees
group by department_id
having avg(salary)>=6000;

--ex6)�μ��� �޿������ ���Ͻÿ�
--    ����1) �Ҽ����ϴ� �ݿø�
--    ����2) ���ڸ������޸�, ȭ����� �ܸ� ǥ��
--    ����3)  �μ��ڵ�        ��ձ޿�
--           ---------------------------
--             10              ��8,600
--    ����4) �μ����� �������������Ͻÿ� 
--    ����5) ��ձ޿��� 5000�̻��� �μ��� ǥ���Ͻÿ�
select department_id "�μ��ڵ�", to_char(round(avg(salary)),'L999,999') "��ձ޿�" 
from employees
group by department_id
having avg(salary)>=5000
order by 1;
--ex7) ��ȿ������ having��
--10�� 20 �μ����� �ִ�޿��� �޴»���� �޿��� ���Ͻÿ�, �μ����� �������� �����Ͻÿ�
--department_id     max_salary
-----------------------------
-- 10                    4400
-- 20                    13000 
--��ȿ������ �ڵ�
select department_id, max(salary)
from employees
group by department_id
having department_id in (10,20)
order by 1;
--ȿ������ �ڵ� , ���� ������ Ʃ��
select department_id, max(salary)
from employees
where department_id in (10,20)
group by department_id
order by 1;
--ex8) having�� (where + group by + having)
--10�� 20 �μ����� �ִ�޿��� �޴»���� �޿��� ���Ͻÿ�.  --1��
--[����1] �μ����� �������� �����Ͻÿ�
--[����2] �ִ�޿��� 5000�̻��� �μ��� ����Ͻÿ�
--         department_id     max_salary
--         -----------------------------------
--           20                    13000 
select department_id, max(salary)
from employees
where department_id in (10,20)
group by department_id
having max(salary)>=5000
order by 1;
--ex9) 20~80�� �μ�����  �޿��� ���� ���� �޴� ����� �޿��� ����Ͻÿ� --7��
--      �μ��� ������������ �Ұ�
--      [���]    department_id     min_salary
--��ȿ������ �ڵ�
select department_id, min(salary)
from employees
group by department_id
having department_id between 20 and 80 
order by 1;
--ȿ������ �ڵ� , ���� ������ Ʃ��
select department_id, min(salary)
from employees
where department_id between 20 and 80 
group by department_id
order by 1;



=======================================================================================
select * from employees;
select * from department;

[����(join)]

(employees)           (departments)                (join)
��       ��                ��        ��              ��     ��    ��
��       ��    +           ��        ��     =        ��     ��    ��
��       ��                ��        ��              ��     ��    ��
��       ȣ                ȣ        ��              ��     ȣ    ��

������
0. natural join(�ڿ�����) : �����÷��� ������ ������ ���� �÷� ��θ� and�����ؼ� ����
1. Inner join(��������) : ������ ������ ����. �̰� ���� ���

2. Outer join(�ܺ�����) : ������ ����(�������)�ؼ� ����
                                   left  join : �����÷� �������
                                   right join : �������÷� �������
3. full join : ����,������ ��� ����
4. self join : �ڱ��ڽ� ���̺�� ����
5. cross join : ��� ����� ���� ����
6. non equijoin : ������ ���ϴ��� ���θ� Ȯ��
7. n�� ���̺� ���� : �������� ���̺� ����

�ع��
1. ����Ŭ ��������
2. Ansiǥ�ر���

select * from employees;    --107 (�μ����� ��� 1��)
select * from departments;  --27

--ex1) inner join : �����ͳ����� ����
--������̺�� �μ����̺��� �μ��� ������� �����ȣ,�μ���ȣ,�μ��̸��� ����Ͻÿ�  -- 106��
---����Ŭ ���
select employee_id, departments.department_id, department_name
from employees, departments
where employees.department_id=departments.department_id;

select employee_id, d.department_id, department_name
from employees e, departments d
where e.department_id=d.department_id;


-- �Ƚ� ���(ȣȯ���� ���Ƽ� ���� �����)
select employee_id, department_id, department_name
from employees
inner join departments using(department_id); --inner�� ��������


--ex2)�μ����̺�� ��ġ���̺��� �����Ͽ� �μ��� ��ġ�� ���ø� �˾Ƴ��ÿ�(inner join)   
select * from departments;
select * from locations; 
--     (departments, locations)
--  department_id     city
----------------------------------
--  10                   Seattle
--����Ŭ ���
select department_id, city
from departments d, locations l
where d.location_id=l.location_id
--�Ƚù��
select department_id, city
from departments
inner join locations using(location_id);

--ex3) outer join(left) : ���� ���̺��� ��� �����Ͽ� ����
--������̺�� �μ����̺��� �μ���ȣ�� ���� ����� �����Ͻÿ� ==> 107���ڵ�
--���� 1) ����̸�, �μ�ID, �μ��̸��� ����Ͻÿ�
--���� 2) ������̺��� ��� ����� �����Ͻÿ�
select last_name, e.department_id, department_name
from employees e, departments d
where e.department_id=d.department_id(+);

select last_name, department_id, department_name
from employees
left outer join departments using(department_id);

--ex4) outer join(right) : ������ ���̺��� ��������Ͽ� ����
--������̺�� �μ����̺��� �μ���ȣ�� ���� ����� �����Ͻÿ� ===> 122���ڵ�
--���� 1) ����̸�, �μ�ID, �μ��̸��� ����Ͻÿ�
--���� 2) �μ����̺��� ��� �μ��� �����Ͻÿ�
select last_name, e.department_id, department_name
from employees e, departments d
where e.department_id(+)=d.department_id;

select last_name, department_id, department_name
from employees
right outer join departments using(department_id);


--ex5) full join : ����,������ ���̺��� ��������Ͽ� ����
--������̺�� �μ����̺��� �μ���ȣ�� ���� ����� �����Ͻÿ� ===> 123���ڵ�
--���� 1) ����̸�, �μ�ID, �μ��̸��� ����Ͻÿ�
--���� 2) ������̺��� ������� �μ����̺��� ��� �μ��� �����Ͻÿ�
--����Ŭ ����� ����
--�Ƚ� ���
select last_name, department_id, department_name
from employees
full join departments using(department_id);

--ex6) departments ��  locations �ڿ������� ��(�����÷� : location_id)  ==> 27���ڵ�
--        �ΰ��� ���̺��� �����ؼ� 
--        �μ���ġ(location_id), ����(city), �μ��̸�(department_name)�� ����Ͻÿ�
--�̳�
select department_id, city, department_name
from departments
inner join locations using(location_id);
--�ڿ�
select department_id, city, department_name
from departments
natural join locations;
--ex7) inner join,  natural join : �ΰ��� �÷��� ��ġ�ϴ°��
--        �μ�ID�� �Ŵ���ID��  ���� ����� �����Ͻÿ�
--       (�������̺� : departments, employees)  : 32 ���ڵ�

--        last_name     department_id   manager_id
--        ------------------------------------------
--����Ŭ ���
select last_name, d.department_id, e.manager_id
from employees e, departments d
where e.department_id=d.department_id and e.manager_id=d.manager_id;
--�Ƚ�
select last_name, department_id, manager_id
from employees
inner join departments using(department_id, manager_id);
--�ڿ�
select last_name, department_id, manager_id
from employees
natural join departments;

--ex8) ������ ������ �÷����� �ٸ���쿡 �������� �����ϱ�
--       departments(location_id) , locations2(loc_id)
        select * from locations;
--      �μ�ID    �μ���             ����
--      -----------------------------------------------------
--      60	      IT	             Southlake
--      50	     Shipping	South San Francisco
--      10	     Administration	Seattle
---���̺� ���� (�����ͱ��� �����ϴ� ���, ������ �����ϴ� ����� �ִ�.)
--���̺� ����(���� ����)
create table locations2
as
select * from locations;

select * from tab; -- ������ ���̽��� ������ �ִ� ���̺� ���
select * from locations2;
---locations2���� location_id�� loc_id�� �̸� ����
alter table locations2
rename column location_id to loc_id;

---����Ŭ ���
select department_id, department_name, city
from departments d, locations2 l
where location_id=loc_id;

--�Ƚ� ���
select department_id, department_name, city
from departments
join locations2 on(location_id=loc_id);

--ex9) self ���� : �ڱ��ڽ��� ���̺�� �����ϴ°��
--        ����� �����ڸ� �����Ͻÿ�, ��� ����� ǥ���Ͻÿ�

--        �����ȣ   ����̸�      ������
--        ----------------------------------
--        101           Kochhar      King   
select * from employees;

---����Ŭ ���
select e.employee_id "�����ȣ", e.last_name "����̸�", f.last_name "������"
from employees e, employees f
where e.manager_id=f.employee_id(+);
--�Ƚ� ���(���� ��� �Ⱦ����� self�϶��� ���)
select e.employee_id "�����ȣ", e.last_name "����̸�", f.last_name "������"
from employees e
left outer join employees f on(e.manager_id=f.employee_id);

--ex10) cross join:����࿡ ���� ������ ��������� �����ϴ� ����
select count(*) from countries;
select count(*) from locations; --25*23-->575
--��� ��� ���� 
--window--> preferences--> Data Manament -> SQL Development ->
--                             SQL Result View--> Max Row Count--> 1000

--����Ŭ ���
select * from countries, locations;
--�Ƚ� ���
select *
from countries
cross join locations;
--ex11) Non Equijoin (�� ��ť����) 
--        : �÷����� ������찡 �ƴ� ������ ���ϴ��� ���θ� Ȯ���Ҷ�
--        [����]  on ( �÷��� between �÷���1 and �÷���2)
select * from employees;

create table salgrade(
salvel varchar2(2),
lowst number,
highst number);

insert into salgrade values('A',20000,29999);
insert into salgrade values('B',10000,19999);
insert into salgrade values('C',0,9999);
commit;

select * from salgrade;
select * from tab;

--ex12) �ڽ��� �޴� �޿��� ������������ Ȯ���Ͻÿ�
--    ����1) Ÿ��Ʋ�� ����̸�, �޿�, �޿����
--    ����2) �޿��� ������������ �����Ͻÿ�
--           ����̸�       �޿�      �޿����
--           ------------------------------------
--            King	          24000	       A
--            De Haan      17000	       B
select last_name "����̸�", salary "�޿�", salvel "�޿����"
from employees
join salgrade on(salary between lowst and highst)

--ex13) n(����)���� ���̺��� ����
--����ID���� ������� ����̸�,��������,�μ��̸��� ����Ͻÿ�
--(employees, jobs,departments���̺��� ����)
select * from jobs
--[�м�]
--employees           jobs            departments
----------------------------------------------------
--department_id      job_id          department_id
--job_id

--[����]
--1. �μ��̸� ������ ���� �μ��̸��� ��� ���������� �������� �����Ͻÿ�
--2. ����̸�, �μ��̸�, �������� �̸����� ����Ͻÿ�

--[���]
--����̸�      �μ��̸�                 ������    ===> employees   departments   jobs
----------------------------------------------------
--Higgins	Accounting Manager	 Accounting
--Gietz		Public Accountant	 Accounting
select last_name ����̸�, department_name �μ��̸�, job_title ������
from employees
join departments using(department_id)
join jobs using(job_id)
order by 2, 3;
------------------------------------------------------------------------------------
--[����1] manager_id�� ���� ����� �����Ͽ� 
--        �̸�(last_name), �μ��̸�, �޴���ID�� ����Ͻÿ�  --4��
--        (�������̺� : employees, departments)

--  ����1)�μ��̸��� IT�� ����� ����Ͻÿ�
--  ����2)�̸����� �������� ����Ͻÿ�
--  ����3)Ansiǥ���� �̿��Ͽ� join�Ͻÿ�

--  �̸�   �μ��̸�   �޴���ID
--  ----------------------------



------------------------------------------------------------------------------------
--[����2] �μ���ġ�� �����Ͽ� ���ø� �˾Ƴ��ÿ�  --21��
--        (�������̺� : departments, locations)

--����1) ���ð� 'Seattle'�� ����Ͻÿ�
--����2) �μ�ID�� �������� �����Ͻÿ�

-- department_id      city
-- -----------------------------
-- 10                      Seattle



------------------------------------------------------------------------------------
--[����3] �μ���ȣ�� ���� ����� Ansiǥ������ �����Ͻÿ� --9��
--        (�������̺� : departments, employees)
--  ����1) Ÿ��Ʋ��  ����̸�(last_name), �μ�ID, �μ��̸����� ����Ͻÿ�
--  ����2) �μ���ȣ�� 30�� �Ǵ� 90���� ����鸸 ����Ͻÿ�
--  ����3) ����̸��� �������� �����Ͻÿ�



------------------------------------------------------------------------------------
--[����4] ��ġID�� �����ؼ� ����̸�,����,�μ��̸��� ����Ͻÿ�  ==> 52���ڵ�
--        (�������̺� : employees, locations2, departments)

--	����1 : ����̸� ,����,�μ��̸��� ������ ǥ���Ͻÿ�	
--	����2 : Seattle �Ǵ� Oxford ���� �ٹ��ϴ� ���
--	����3 : ���ü����� �������������Ͻÿ� 
--	����4 : ��� ����� �����Ѵ�

--  ����̸�      ��    ��     �μ��̸�
-- -------------------------------------
--   Hall        Oxford       Sales

--[�м�]
--employees                departments            locations2
-- -----------------------------------------------------------
--department_id            department_id
--                         location_id              loc_id            





------------------------------------------------------------------------------------
--[����5] �μ�ID,����ID,�μ���ġ�� �����ؼ� ������ ���� �ϼ��Ͻÿ�   -- 1 ���ڵ�
--        (�������̺� : employees,locations2, departments,countries)
--      ����1 : �����ȣ,����̸�,�μ��̸�,����,�����ּ�(street_address),������ ������ ǥ���Ͻÿ�
--      ����2 : �����ּҿ�  Vi �Ǵ� St�� ���ԵǾ� �ִ� �����͸� ǥ���Ͻÿ�
--      ����3 : �����, ���ú��� �������������Ͻÿ�
--      ����4 : ������� �����Ѵ�

-- employees                 locations2          departments         countries
-- -------------------------------------------------------------------------------
--  department_id                                  department_id 
--                                loc_id                location_id  
--                                country_id                                     country_id                                                
























