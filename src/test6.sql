[���̺�����]
create table ���̺���(�÷���1   �÷�Ÿ��  [��������],�÷���2  �÷�Ÿ��  [��������],.....);

 -  ���ڷν���(30���̳�) : ���� ��ҹ���,����,Ư������( _ , $ , # ),�ѱ�
 -  �ߺ��Ǵ� �̸��� ���ȵ�
 -  �����(create, table, column��)�� ����Ҽ� ����
 -  �ڷ���
    number :  number(��ü�ڸ�,�Ҽ�����), number  ==> ������(������)
    int    :  ������ ����(������)
    float / double : �Ǽ��� ����(������)
    varchar/varchar2 :  ����,���ڿ�(������) ==> �ִ� 4000byte
    char :                    ����,���ڿ�(������) ==> 2000byte
    date :                    ��¥��
    clob :                    ���ڿ� ===> �ִ�4GB
    blob:                    ���̳ʸ���(�׸�,����,������..)  ===> �ִ�4GB  

  - ��������
     not null :  �ش��÷��� NULL�� ���Ե��� �ʵ��� ��        (�÷�)
     unique  :  �ش��÷� �Ǵ� �÷� ���հ��� �����ϵ��� ��   (�÷�,���̺�)
     primary key : �� ���� �����ϰ� �ĺ��Ҽ� �ֵ�����        (�÷�,���̺�)
     references  table(column)                                               
             : �ش� �÷��� �����ϰ� �ִ� (�θ�)���̺��� Ư��   (�÷�,���̺�)
               �÷������ ��ġ�ϰų� �Ǵ� NULL�� �ǵ���
               ������
     check : �ش��÷��� Ư�� ������ �׻� ������Ű������    (�÷�, ���̺�)
     [����]  primary key = unique + not null

     ex)      idx                   �Ϸù�ȣ            primary key   
               id                     ���̵�              unique 
               name                �̸�                 not null 
               phone               ��ȭ��ȣ          
               address              �ּ�      
               score                 ����                check
               subject_code        �����ڵ�         
               hire_date             ������            (�⺻��:���ó�¥)
               marriage             ��ȥ                check  (�⺻�� : N)  
             ---------------------------------------------------------------------
    - ��������Ȯ��
      constraint_name:�̸�
      constraint_type:����
                p:primary key 
                u:unique 
                r:reference 
                c:check, not null

      search_condition :  check���� ����
      r_constraint_name : �������̺��� primary key �̸�
      delete_rule : �������̺��� primary key �÷��� �����ɶ� ����Ǵ� ��Ģ
                           (no action, set null, cascade��)


     - ���� RULE
       on delete cascade:��� �����͸� �����ϰ�,�ش� �����͸� �����ϴ� �����͵� ����
       on delete set null:��� �����͸� �����ϰ�,�ش� �����͸� �����ϴ� �����ʹ� NULL�� �ٲ�
       on delete restricted:������� �����͸� �����ϴ� �����Ͱ� �����ϸ� �����Ҽ� ����(�⺻��)

     - ���� RULE
       on update cascade:��� �����͸� �����ϸ�,�ش� �����͸� �����ϴ� �����͵� ����
---------------------------------------------------------------------------------
[���̺�����]
-����-
alter  table ���̺��� 
add    �÷���  ������Ÿ�� [��������]
add    constraint  �������Ǹ�  ��������Ÿ��(�÷���)
modify �÷��� ������Ÿ�� 
drop   column  �÷��� [cascade constraints]
drop   primary key [cascade] | union (�÷���,.....) [cascade] .... | constraint 
�������Ǹ� [cascade]

-�̸�����-
alter table  �������̺���  rename to  �����̺���
rename  �������̺���  to �����̺���

alter table ���̺��� rename column  �����÷��� to ���÷���
alter table ���̺��� rename constraint �����������Ǹ� to ���������Ǹ�
---------------------------------------------------------------------------------
[���̺�����]
  - ���������� �̿��� ���̺������� ��(���ڵ�)����
  - ���������� �̿��ؼ� �����Ѱ�� not null�� ������ ���������� ����ȵ�
    (not null�������ǵ�  sys_*****�� �����)

- ���� - 
create table ���̺���([�÷���1,�÷���2.....]) as ��������  

- ���������� - 
create table ���̺���1 
as  select  *  from ���̺���2  where 1=0
---------------------------------------------------------------------------------
[������]
 : ���������� �������� �ڵ����� �����ϴ� ��ü

create  sequence  ��������
[increment by ������] [start with ���۰�]
[maxvalue  �ִ밪 | minvalue  �ּҰ�]
[cycle | nocycle]
[cache | nocache]

  - increment  by  ������ : ����/���� ����(�⺻�� : 1)
  - start with : ���۹�ȣ(�⺻�� : 1)
  - maxvalue / minvalue : �������� �ִ�/�ּҰ�����
  - cycle/nocycle : �ִ�/�ּҰ��� ���޽� �ݺ����ΰ���
  - cache / nocache : �����Ѽ�����ŭ �޸� �������ΰ��� (�ּҰ� : 2, �⺻�� : 20)

---------------------------------------------------------------------------------
[ insert ]
 : ���̺��� ������(���ο���)�߰� -- ���� ���� ����

insert into ���̺��� [ (column1, column2, .....)]   values (value1,value2,.....)
 -  column�� values�� ������ġ
 -  column�� values��  ���� ��ġ

---------------------------------------------------------------------------------
[ update ]
 : ���̺��� ���Ե� ���� �����ͼ��� -- ���� ���� ������� ����
   ��ü ������ �Ǽ�(���)�� �޶����� ����
   ���ǿ� �´� ��(�Ǵ� ��)�� �÷����� �����Ҽ� �ִ�

update ���̺���  set  �÷���1=value1, �÷���2=value2 ..... [where  ������]
   - where �� ������ �Ǹ� ��ü���� ����
   - set���� ����������밡��, default�ɼ� ��밡�� 
---------------------------------------------------------------------------------
[ delete ]
 : ���̺��� ���Ե� ���������͸� ����  -- ���� ���� ����
   �� ������ �����ǹǷ� ��ü����� �޶���
   
delete [from] ���̺��� [where  ������];
 - where�� �����ϸ� ��ü���� ������
 - �����ʹ� �����ǰ� ���̺� ������ ������

---------------------------------------------------------------------------------
[ tracnsationó�� ]
  : ���� ���۰� ���� �Ϻ��ϰ� ������(commit)
    ó������ ���ͷ�Ʈ(interrupt:���)�� �߻��ϸ� �ǵ��ƿ�(rollback)
==================================================================================================
--������ �ٲٽÿ� : edu/1234
select * from tab;

--ex1) ���̺� : test 
--id   number(5), name char(10),  address varchar2(50);
create table test(
id number(5),
name char(10),
address varchar2(50));

desc test;   --���̺��� ����Ȯ��

--ex2) ���̺��� : user1
create table user1(
idx     number  primary key,
id      varchar2(10) unique,
name    varchar2(10) not null,
phone   varchar2(15),
address varchar2(50),
score   number(6,2)  check(score >=0 and score <= 100),
subject_code  number(5),
hire_date  date default sysdate,
marriage   char(1)  default 'N'  check(marriage in('Y','N')));

--ex3) ��������Ȯ��
--1	SYS_C004081 	C
--2	SYS_C004082	  C
--3	SYS_C004083 	C
--4	SYS_C004084	  P
--5	SYS_C004085	  U







--ex4) ���̺��� : user2
create table user2(
idx     number        constraint PKIDX primary key,
id      varchar2(10)  constraint UNID unique,
name    varchar2(10)  constraint NOTNAME not null,
phone   varchar2(15),
address varchar2(50),
score   number(6,2)   constraint CKSCORE check(score >=0 and score <= 100),
subject_code  number(5),
hire_date  date default sysdate,
marriage   char(1)  default 'N' constraint CKMARR check(marriage in('Y','N')));

--ex5) ��������Ȯ��

--1	NOTNAME       C
--2	CKSCORE	        C
--3	CKMARR	        C
--4	PKIDX	        P
--5	UNID	        U











--ex6) �߰�
insert into user1(idx, id, name, phone, address, score, subject_code, hire_date, marriage)
values(1,'aaa', 'kim', '010-111-1111', '����', 75, 100, '2010-08-01', 'Y');

insert into user1(idx, id, name, phone, address, score, subject_code, hire_date, marriage)
values(1,'aaa', 'kim', '010-111-1111', '����', 75, 100, '2010-08-01', 'Y');
--����:���Ἲ �������� ����, idx 1 �ߺ�

insert into user1(idx, id, name, phone, address, score, subject_code, hire_date, marriage)
values(2,'aaa', 'kim', '010-111-1111', '����', 75, 100, '2010-08-01', 'Y');
--����:���Ἲ �������� ����, id 'aaa'�ߺ�

insert into user1(idx, id, name, phone, address, score, subject_code, hire_date, marriage)
values(2,'bbb', '010-111-1111', '����', 75, 100, '2010-08-01', 'Y');
--����:���� ���� ����ġ

insert into user1(idx, id, name, phone, address, score, subject_code, hire_date, marriage)
values(2,'bbb', 'lee', '010-111-1111', '����', 175, 100, '2010-08-01', 'Y');
--����: üũ �������� ����, ���� ������ ��ġ���� ���� 175.

insert into user1(idx, id, name, phone, address, score, subject_code, hire_date, marriage)
values(2,'bbb', 'lee', '010-111-1111', '����', 75, 100, '2010-08-01', 'K');
--����: üũ �������� ����, ���� ������ ��ġ���� ���� K -> Y

insert into user1(idx, id, name, phone, address, score, subject_code, hire_date, marriage)
values(2,'bbb', 'lee', '010-111-1111', '����', 75, 100, '2010-08-01', 'N');
--����

--����: üũ �������� ����, ���� ������ ��ġ���� ���� 175.
--ex7) ���̺����Ȯ��
select * from tab;

--ex8) user1, user2 ���̺��� ������ ���� Ȯ��
select * from user1;
select * from user2;


--ex9) user1 ���̺��� ����Ȯ��
desc user1;

--ex10) ��������Ȯ��(���������� �̸��� �������� �������-user1)
select constraint_name, constraint_type
from user_constraints
where table_name='USER1' -- ���̺� ������ ������ �빮�ڷ� �˻�

select *
from user_constraints;


--ex11) ��������Ȯ��(���������� �̸��� ������ ���-user2)
select constraint_name, constraint_type, search_condition
from user_constraints
where table_name='USER2'



===============================================================
[�÷����� / ���̺�����]-- ���� ���� ���� ���
create table exam1(
	num							number				constraint			PNUM		primary key,
	id							varchar2(10)		constraint			UNIID		unique,
	name						varchar2(10)		constraint			NONAME		not null
);
--not null ���� ������ �÷� �����θ� ���� ����
create table exam2(
	num							number,
	id							varchar2(10),
	name						varchar2(10)		constraint			NONAME2		not null, --�÷� ����
	constraint					PNUM2				primary key(num),						  --���̺� ����
	constraint					UNIID2				unique(id)
);

select * from tab;

select constraint_name, constraint_type
from user_constraints
where table_name='EXAM2';

alter table exam2 drop constraint NONAME2 cascade;
alter table exam2 drop constraint PNUM2 cascade;
alter table exam2 drop constraint UNIID2 cascade;





================================================================
--ex12) ���̺��� ���� : test ==> user3




--ex13) �÷��߰� :  user3  == > phone  varchar2(15)



--ex14) ���������߰� : user3  ==>  id��  unique ,�������Ǹ� UID2






--ex15)  �÷��߰� : user3 ==> no  number  (PK����)



--ex16) �������� : user3 ==> name  char(10) �� varchar2(10)�� �ٲ�



--ex17) �÷����� : user3 ==> address



--ex18) ���̺����� / ���������: user3






--ex19) user1�� ������ �����Ͽ� user4�� �����Ұ�  
-- �̶�, idx-> bunho,  id->sid,  name-> irum, address-> juso�� ����




--ex19_1) insert, update, delete �׽�Ʈ
insert into user4(bunho, sid, irum, juso) values(1, 'aaa','lee','����');
insert into user4 values(2,'bbb','lee','����');
insert into user4 values(3,'ccc','park','�λ�');
insert into user4(bunho, sid, irum) values(4,'ddd','hong');
insert into user4(bunho, sid, irum) values(5,'eee','kang');
insert into user4 values(6,'fff','jeung','����');
insert into user4(irum) values('min');
commit;
select * from user4;

--[����1]user4�� 'hong'�� �ּҸ� '����'���� �ٲٰ� ID�� 'abc'�� �ٲٱ�



--[����2]user4�� �ּҰ�  '��'�� ������ �����͸� �����ϰ� ��� �����Ͻÿ�



--[����3] juso�� null�� �����͸� ��� �����Ͻÿ�



--[����4]user4�� ������ ����� ������� �����Ͻÿ�


---------------------------------------------------------------------------
--ex20) ���������� / ����




--ex21) ���̺������� ����������









insert into book(num,subject,price, year)
values(num_seq.nextval,'����Ŭ �����������ϱ�',10000,sysdate);

insert into book(num,subject,price, year)
values(num_seq.nextval,'�ڹ�3�Ͽϼ�',15000,'2015-12-12');

insert into book values(num_seq.nextval,'JSP ���εǱ�',18000,to_char(sysdate,'YYYY-MM-DD'));

select * from book;

--ex22) user2�� user3�� ���̺� ������ �����Ͻÿ�
--      (�÷����� �״�� ����)








--ex23) ���̺�(idx->bunho,  name -> irum,  address -> juso) �� �����ϰ�  
--id��  bbb�� ���ڵ带 �����Ͻÿ�
--�������̺� : user1   / �纻���̺� : user5






================================================================================================
--ex24) ���̺������� ���߰�
--���̺��� : dept
--deptno    number         ==> �⺻Ű, �������Ǹ�(DNO)
--dname     varcahr2(30)   ==> �� ���ȵ�, �������Ǹ�(DNAME)

--���̺��� : emp
--empno   number       ==> �⺻Ű,�������Ǹ�(ENO)
--ename   varchar2(30) ==> �����ȵ�, �������Ǹ�(ENAME)
--deptno  number       ==> �ܷ�Ű, �������Ǹ�(FKNO),
--                                    ������͸� �����ϰ� �����ϴµ����ʹ� NULL�� �ٲ�











select * from dept;
select * from emp;
--ex25) ����
--dept���̺����� 20�� �μ��� �����Ͻÿ� 



--������ ���� �ǵ����ÿ�



--ex26) ����(delete)
--40���μ��� �����Ͻÿ�



--������ ���� �ǵ����ÿ�



--����)  
--dept���̺���  deptno=40��  emp���̺��� deptno=40�� releation �� �����Ȱ�� 
--  ==> �����ȵ�(�ڽķ��ڵ尡 �߰ߵǾ����ϴ�)
--on delete cascade�� �����ϸ� �θ����̺��� �ڽ����̺��� ���ڵ尡 �Բ� ������
--on delete set null�� �����ϸ� �θ����̺��� �����ǰ� �ڽ����̺��� null�� �ٲ�

--ex27) ����(update)
--�嵿���� �μ��� 30���� �����Ͻÿ�



--================================================================================================
--[����5]
--���̺��� : member
-- idx, ����(5), �⺻Ű / name, ����(10), �����X / kor, ����(5) / eng, ����(5) / mat, ����(5)

-- �������� : m_seq, 1���� 1������, nocycle, nocache

--����Ÿ : �Ѹ�, 90, 80,95
--         ��ġ, 75, 90,65
--         ���浿, 100,95,90
--         ������, 60,60,60
--         �����, 75,80,75
--         ����, 80,78,90
-- idx�� �ڵ����� 1���������� �����ÿ�

--select������ ������ ���� ����Ͻÿ�
--����1)��պ� �������� �����Ͻÿ�
--����2)����� �Ҽ������� 2°�ڸ����� ����Ͻÿ�
--����3)Ÿ��Ʋ�� �Ʒ��� ���� ó���� �ֽÿ�

--�й�     �̸�    ����   ����   ����    ����   ���
-- -----------------------------------------------------
--  1      �Ѹ�    90     80     96       266    88.66



















