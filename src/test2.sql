[������]
=  : ����
!=,  ^=,  <> : �����ʴ�
>=, <=, >, < : ũ�ų�����,�۰ų�����,ũ��,�۴�
and, or, between and, in, like, is null/is not null

�� select 
select  [distinct] [�÷�1, �÷�2.......][*][ ||���Ῥ����][as ����]
from ���̺��
[where ������]
[order by �÷��� asc|desc ]

order by : ����
                asc  - ��������(��������)
                desc - ��������
�÷��� : ���ڷε� ����
=======================================================================================
--ex1) �����,�μ�ID,�Ի����� �μ����� �������� �����Ͻÿ�


--ex2) �����, �μ�ID, �Ի�����  �μ����� �������� �����Ͻÿ�
--     �����μ��� ��������  �Ի��ϼ����� �����Ͻÿ�


--ex3) ������� ������ ������ ���������� �������������Ͻÿ�
--�� ��     �� ��     
-- ---------------
--King      28800



=======================================================================================
[������ �Լ�]
1. �����Լ� : mod(������), round(�ݿø�), trunc(����), ceil(�ø�) 
2. �����Լ� : lower, upper, length, substr, ltrim, rtrim, trim -- �ҹ���, �빮��, ����, trim:��������
3. ��¥�Լ� : sysdate, add_month, month_between
4. ��ȯ�Լ�
   (1) �Ͻ���(implict)��ȯ:�ڵ�
       VARCHAR2 �Ǵ� CHAR    ------>     NUMBER
       VARCHAR2 �Ǵ� CHAR    ------>     DATE
       NUMBER               ------>     VARCHAR2
       DATE                 ------>     VARCHAR2   

    (2) �����(explict)��ȯ:����
    
               TO_NUMBER        	   TO_DATE
                 <------               ------>
     NUMBER                CHARACTER           DATE
                 ----->                <------
                 TO_CHAR              TO_CHAR

-��¥����-
YYYY : ���ڸ�����(����)         (ex.  2005)  
YEAR : ����(����)
MM : ���ڸ� ������ ��Ÿ�� ��    (ex.   01, 08, 12)
MONTH : �� ��ü�̸�             (ex.   January) 
MON : ���ڸ� ���� ��Ÿ�� ��   (ex.   Jan)  
DY : ���ڸ� ���� ��Ÿ�� ����  (ex. Mon) 
DAY : ������ü                  (ex. Monday) 
DD : ���ڷ� ��Ÿ�� ���� ��      (ex. 31, 01) 

-��������-
9 : ���ڸ� ǥ��
0 : 0�� ������ ǥ��
$ : �ε�$��ȣ�� ǥ��
L : �ε� ������ȭ��ȣ ǥ��(�ѱ�,�Ϻ�...)
.  : �Ҽ������
,  : õ���� ������ ���

5. �׷�(����)�Լ�(������ �Լ�) : avg, sum, max, min, count
6. ��Ÿ�Լ� : nvl, dcode, case
=======================================================================================
--ex1)  �̸��� �ҹ��ڷ� �ٲ��� �˻�
--'Higgins'����� �����ȣ,�̸�,�μ���ȣ�� �˻��Ͻÿ�
select employee_id, last_name, department_id
from EMPLOYEES
where lower(last_name)='higgins'; 

--ex2) 10�� 3���� ���� ������ ���Ͻÿ�(mod)
select mod(10,3)
from dual; -- dual �������̺� ���� ����

--ex3) 35765.357�� �ݿø�(round)
select round(35765.357, 2) from dual; --�Ҽ��� �Ʒ� �ι�° �ڸ����� �ݿø� ----35765.36
select round(35765.357,0) from dual; --,0��������   35765
select round(35765.357,-2) from dual; --35800

--ex4) 35765.357�� ����(trunc)
select trunc(35765.357, 2) from dual; --35765.35
select trunc(35765.357,0) from dual; --,0��������   35765
select trunc(35765.357,-2) from dual; --35700

select ceil(35765.357) from dual; ---35766

--ex5) concat('���ڿ�1','���ڿ�2') : ���ڿ��� ����(���ڿ�1+���ڿ�2)
select concat('hello','oracle') �λ縻 from dual;

--ex6) length('���ڿ�')  : ���ڿ�(ĳ����)�� ����
--     lengthb('���ڿ�') : ���ڿ�(BYTE)�� ����
  
--     ��뿹)  ����Ʈ , ����Ʈ
--                          char(20)           varchar2(20)
--           length           14  ->  ����Ʈ ��     3            <---- ����Ʈ
--           lengthb          20                  9            <---- ����Ʈ


--     ��뿹)  elite , elite
--                          char(20)           varchar2(20)
--           length           20                  5             <---- elite
--           lengthb          20                  5             <---- elite


create table text (  
					str1 char(20),   
					str2 varchar2(20)
					);  
--������ ���̽� ���̺� ������ ���� �ѹ��� ����--�÷�  �ڷ���(�������� ũ��)					
insert into text(str1,str2) values('����Ʈ','����Ʈ'); 
--insert into : ������ �߰� ���  �����ϰ����ϴ� �÷�  
--values: �ش��ϴ� �� ����
insert into text(str1,str2) values('elite','elite');
commit;
-- Ʈ������� ������ ����
--Ʈ�����: �Ϸ��� �۾����� �ѹ�: �����Ѱ� ������Ұ�����(������ ���̽� �ȿ��� ó��) ���� ó�� �������� ������ ���ٸ�, Ŀ�� ó��. 
--��, Ŀ��ó���ϴ� �߿��� �ͼ����� �߻��� �� �ִ�. �̶��� �ѹ��� �� ����.
select * from tab;
select * from text;
select length(str1),length(str2) from text where str1='����Ʈ';     --14   3
select lengthb(str1),lengthb(str2) from text where str1='����Ʈ';    --20   9

select length(str1),length(str2) from text where str1='elite';     --20   5
select lengthb(str1),lengthb(str2) from text where str1='elite';   --20   5

--ex7) 
select length('korea') from dual;  --5
select length('�ڸ���') from dual;  --3
select lengthb('korea') from dual;  --5
select lengthb('�ڸ���') from dual; --9

--ex8) �����ѹ��ڿ�ã�� : instr(ǥ����,ã�¹���,[��ġ]) 1:��(��������), -1:��
select instr('HelloWorld','W') from dual;
select instr('HelloToWorld','o',-5) from dual; -- -5�� ������ġ

--ex9) ������ ������ ���ڿ��� ���� : substr(ǥ����,����,[����])  
select substr('I am very happy', 6, 4) from dual;--������° �ڸ����� 4����
select substr('I am very happy', 6) from dual; -- ������° �ڸ��� ������ ���

--ex10) employees ���̺��� ���ǿ� �°� �˻��Ͻÿ�(concat,  length)   -- 19���ڵ�
--      ����1) �̸��� ���� �����Ͻÿ�(concat)
--      ����2) ������ �̸��� ���̸� ���Ͻÿ�(length)
--      ����3) ���� n���� ������ ���(substr)

--employee_id        name           length
-- -----------------------------------------------
--  102              LexDeHaan       10
select employee_id, concat(first_name,last_name) as "name", length(concat(first_name,last_name)) as "length"
from employees
where substr(last_name,-1,1)='n';


--ex11) ������ ���� ������ �������� �����ġ : width_bucket(ǥ����,�ּҰ�,�ִ밪,����)
--�ּ�-�ִ밪�� �����ϰ� 10���� ������ ������ ��ġã��
--0-100������ ������ ������ 74�� ���ԵǾ��ִ±����� ǥ���Ͻÿ�
select width_bucket(74, 0, 100, 10) from dual;

--ex12) �������� : ltrim(��), rtrim(����), trim(����)
select rtrim('test     ') || 'exam' from dual;

--ex13) sysdate : �ý��ۿ� ������ �ð�ǥ��
-- 2015�� 1�� 05��
select sysdate from dual;

         TO_NUMBER        	   TO_DATE
                 <------               ------>
     NUMBER                CHARACTER           DATE
                 ----->                <------
                 TO_CHAR              TO_CHAR

select to_char(sysdate,'YYYY"��" MM"��" DD"��"') as "���ó�¥" from dual;
select to_char(to_date('15/1/5'),'YYYY"��" MM"��" DD"��"') as "���ó�¥" from dual; --��¥ ������ �������·� �ٲ㼭 ���
select to_char(to_date('15/01/05'),'YYYY"��" fmMM"��" DD"��"') from dual; --fm(format): ��ȿ���� ���� ���� ����/�߰�
select to_char(to_date('15/01/05'),'YYYY"��" fmMM"��" fmDD"��"') from dual;

--ex14) add_months(date, �޼�):��¥�� �޼� ���ϱ�
select add_months(sysdate, 5) from dual;

--ex15) last_day(date) : �ش���� ��������
select last_day(sysdate) from dual;
select last_day('2004-02-01') from dual;

--ex16) ���ú��� �̹��� ������ �� ���� ������ ���Ͻÿ�(���� ���� ���� ��¥�� �� ŭ)
select last_day(sysdate)-sysdate from dual;

--ex17) months_between(date1,date2) : �� ��¥������ �޼�
select months_between('2004-02-01',sysdate) from dual; --���� ���
select months_between(sysdate,'2004-02-01') from dual;  --��� ���

--ex18) �Ͻ����� ��ȯ(�ڵ�)
desc employees

select employee_id, last_name
from employees
where department_id='90'; -- �ڵ�����ȯ

select months_between('15-10-21','2004-02-01') from dual;
--						Date-->Number

--ex19) ������� ��ȯ(����)     number --> character
select last_name, salary
from employees
where last_name='King';
--���� �޿��� ���� �ڷ����ε� ���������� ��ȯ������ to_char
select last_name, to_char(salary,'L99,999.00')
from employees
where last_name='King';

--ex20) fm���� : ���İ� �����Ͱ� �ݵ�� ��ġ�ؾ���(fm - fm���̰��� ��ġ)
select last_name, hire_date from employees where hire_date='05/06/25'; --05/06/25 
select last_name, hire_date from employees where hire_date='05/6/25'; --05/06/25 

select to_char(to_date('15-04-07'), 'YYYY-MM-DD') from dual;
select to_char(to_date('15-04-07'), 'YYYY-fmMM-DD') from dual;
select to_char(to_date('15-04-07'), 'YYYY-fmMM-fmDD') from dual; --�ٽ� fm ������ ������� ���ư�

--ex)2007-02-07�� �Ի��� ����� �˻��Ͻÿ�
select last_name, hire_date from employees where hire_date='2007-02-07';
select last_name, hire_date from employees where hire_date='2007/02/07'; --�������ε� ��¥������ ��ȯ

select last_name, hire_date
from employees
where hire_date=to_char(to_date('2007-02-07'), 'YYYY-MM-DD');

select last_name, hire_date
from employees
where to_char(hire_date, 'YY-MM-DD')=to_char(to_date('07/02/07'), 'YY-MM-DD');

select last_name, hire_date
from employees
where to_char(hire_date, 'YY-MM-DD')=to_char(to_date('07/02/07'), 'YYYY-MM-DD'); --��� �ȳ���(�º� �캯 ���� ����ġ)

select last_name, hire_date
from employees
where to_char(hire_date, 'YYYY-MM-DD')=to_char(to_date('07/02/07'), 'YYYY-MM-DD');

select last_name, hire_date
from employees
where to_char(hire_date, 'YYYY-MM-DD')=to_char(to_date('07/02/07'), 'YYYY-fmMM-DD'); --��� �ȳ���(�º� �캯 ���� ����ġ)

--ex21) RR, YY����

   (��ȯ��:����⵵�� ����)                  �����ѿ���(�� ���ڸ�)
                                -----------------------------------------------------
                                         0 - 49                      50 - 99     
   ===================================================================================
   ���翬�� (�� ���ڸ�)    0 - 49     ��ȯ���� ���缼��       ��ȯ���� ��������
                            ----------------------------------------------------------
                            50 - 99    ��ȯ���� ��������      ��ȯ���� ���缼��


   ��)  ����⵵            �����ѳ�¥          RR����            YY����
        -----------------------------------------------------------------
           1995              27-oct-95      1995  			2095    
           1995              27-oct-17      1995  			2095       
           2001              27-oct-17            
           2001              27-oct-95             


--ex22)
select to_char(to_date('97/9/30','YY-MM-DD'), 'YYYY-MM-DD') from dual; --2097��
select to_char(to_date('97/9/30','RR-MM-DD'), 'RRRR-MM-DD') from dual; --1997��
select to_char(to_date('57/9/30','YY-MM-DD'), 'YYYY-MM-DD') from dual; --2057��
select to_char(to_date('57/9/30','RR-MM-DD'), 'RRRR-MM-DD') from dual; --1957��

select to_char(to_date('03/9/30','YY-MM-DD'), 'YYYY-MM-DD') from dual; --2003��
select to_char(to_date('03/9/30','RR-MM-DD'), 'RRRR-MM-DD') from dual; --2003��

select to_char(to_date('1903/9/30','YY-MM-DD'), 'YYYY-MM-DD') from dual; --1903��
select to_char(to_date('1903/9/30','RR-MM-DD'), 'RRRR-MM-DD') from dual; --1903��

--ex23)2005�� ���Ŀ� ���� ����� ã���ÿ�
--last_name     hire_date
------------------------------------
--King           17-Jan-1987
--Kochhar        21-sep-1989
--Whalen         17-sep-1987
select last_name,to_char(to_date(hire_date),'DD-MON-YYYY')
from employees
where hire_date>=to_date('2005/01/01'); 
-- =  hire_date>='2005/01/01' (�ڵ��� ��ȯ �ż� ��¥�� �ν�)

--���� ��
select last_name,to_char(to_date(hire_date),'DD-MON-YYYY')
from employees
where hire_date> to_date('2005/12/31');
                     
--**�׷��Լ�    
--ex24) count(�÷���), max(�÷���), min(�÷���),avg(�÷���),sum(�÷���) �Լ�
--employees���̺��� �޿��� �ִ�,�ּ�,���,���� ���Ͻÿ�
--����) ����� �Ҽ���������, ���� ���ڸ� ���� �޸���� \(�������� �ƴϰ� ��ȭ��ȣ �� ����)
select count(salary), max(salary), min(salary),trunc(avg(salary)),to_char(sum(salary),'L999,999,999')
from employees
--sum�� 'L999,999,999'���� L�� ��ȭ����

--ex25) Ŀ�̼��� ���� �ʴ� ����� �ο����� ���Ͻÿ�
select count(commission_pct)
from employees
where commission_pct is null

--ex26) employees���̺��� ���ºμ������ؼ�,�� �μ��� ���� ���Ͻÿ�(�� : 12��)
--      (nvl���) nvl(null value): nvl(�÷���, �ٲܰ�) null�� �ٲٰ��� �ϴ� ������. ���⼭�� ī��Ʈ�� ���� �������� �ʾ� 11�� ��µǴ� ���� �ƹ� �ǹ̳� ����ֱ�
select count(distinct nvl(department_id,0))
from employees;

--����) ���������� ����Ͻÿ�
--        ����1) ����̸�, �޿�, Ŀ�̼�, ������ ����Ͻÿ�
--        ����2) ���� = �޿�*12 + (�޿�*12)*Ŀ�̼����� �Ѵ�
--        ����3) Ŀ�̼��� ���� �ʴ°�쿡�� 0���� ǥ���Ѵ�
select last_name ����̸�, salary �޿�, nvl(commission_pct,0) Ŀ�̼�, salary*12+(salary*12)*nvl(commission_pct,0) as ����
from employees;

--ex27) �� decode(ǥ����,�˻�1,���1,�˻�2,���2....[default])
--        : ǥ���İ� �˻��� ���Ͽ� ��� ���� ��ȯ �ٸ��� default
--        �� case  [value]  when  ǥ����  then   ����1
--                               when  ǥ����  then   ����2
--                                                 :
--                               else  ����3
--            end

--ex28)���� id�� 'SA_MAN' �Ǵ� ��SA_REP'�̸� 'Sales Dept' �� �� �μ��̸� 'Another'�� ǥ��
--����) �з����� ������������ 
--        ����          �з�
--       --------------------------
--       SA_MAN    Sales Dept
--       SA_REP      Sales Dept
--       IT_PROG    Another
select job_id ����,  
		decode(job_id, 'SA_MAN','Sales Dept','SA_REP','Sales Dept','Another') �з�
from employees
order by 2;
--2�� �ι�° �÷��������� ����
select job_id as "����",
		case job_id when 'SA_MAN' then 'Sales Dept'
					when 'SA_REP' then 'Sales Dept'
					else 'Another'
					end as "�з�"
from employees

--ex28) �޿��� 10000�̸��̸� �ʱ�, 20000�̸��̸� �߱� �� ���̸� ����� ����Ͻÿ� 
--      ����1) �÷�����  '����'���� �Ͻÿ�
--      ����2) ������ �����ȣ, �����, ��  ��
--      ����3) ����(��������)���� �����ϰ�, ���а��� ������ �����(��������)���� �����Ͻÿ�

select employee_id as "�����ȣ", last_name as "�����",
		case 	when salary<10000 then '�ʱ�'
				when salary<20000 then '�߱�'
					else '���'
					end as "��  ��"
from employees
order by 3asc, 2 asc;

--rank�Լ� : ��ü���� ������� ������ ����
--rank(ǥ����) within group(order by ǥ����)     ---> �κ�
--rank() over(������Ƽ��)                                ---> ��ü������ ǥ��

--ex29)�޿��� 3000�� ����� ���� �޿������� ���Ͻÿ�
select salary from employees order by 1;

 -->3000�� ������ �׷쿡�� ���° �����ΰ�? ��� ��.
select rank(3000) within group(order by salary desc) "rank"
from employees

--ex30)��ü����� �޿������� ���Ͻÿ�
select last_name, salary, rank() over(order by salary desc) "rank"
from employees

--first_value�Լ� : ���ĵ� �� �߿��� ù��°�� ��ȯ
--first_value(ǥ����) over(������Ƽ��)

--ex31)��ü����� �޿��� �Բ� ���μ��� �ְ�޿��� ��Ÿ���� ���Ͻÿ�
=================================================================================================
--[����1] ������̺��� �����ȣ, �̸�, �޿�, Ŀ�̼�, ������ ����Ͻÿ�
--        ����1) ������ $ ǥ�ÿ� ���ڸ����� �޸��� ����Ͻÿ�
--        ����2) ���� = �޿� * 12 + (�޿� * 12 * Ŀ�̼�) 
--        ����3) Ŀ�̼��� ���� �ʴ� ����� �����ؼ� ����Ͻÿ�




--[����2] �Ŵ����� ���� ����� �Ŵ���id��, 1000���� ǥ��
--        ����1) ������ �����ȣ,�̸�,�Ŵ���ID
--        ����2) ��� ����� ǥ���Ͻÿ�       
--                �����ȣ     �̸�       �Ŵ���ID
--	          ---------------------------------
--	           100           King        1000 





--[����3] �޿���  7000�̻��̸� '���'  3000�̻��̸� '�߱�'  3000�̸��̸� '�ʱ�'�� ���
--          grade���� �������� �����Ͻÿ�  
--                last_name        salary       grade
--              --------------------------------------------
--                 King               24000      ���




























