-- ===================================================================
-- SQL*Plus script:   am4dp_create.sql
--                    Creates the AM4DP schema
--                    Generates a spool file am4dp_creation.txt
-- For more details:  See Appendix A
-- 
-- Modifications:
-- November   , Lex   creation
-- 09-dec-2005, Lex   added offr.status column
-- 12-dec-2005, Lex   added offr.maxcap column
-- 31-nov-2006, Toon  updated to reflect all changes made to the UEX
--                    database design
-- ===================================================================
--  
set  echo off termout off
-- 
-- ===================================================================
-- Drop all tables first ...
-- ===================================================================
-- 
drop table emp  cascade constraints;
drop table srep cascade constraints;
drop table memp cascade constraints;
drop table term cascade constraints;
drop table dept cascade constraints;
drop table grd  cascade constraints;
drop table crs  cascade constraints;
drop table offr cascade constraints;
drop table reg  cascade constraints;
drop table hist cascade constraints;
purge recyclebin;
-- 
set   echo on termout on trimspool on
spool am4dp_creation.txt
-- 
-- ===================================================================
-- Create GRD
-- ===================================================================
-- 
create table  grd
( grade       number(2,0)   not null
, llimit      number(7,2)   not null
, ulimit      number(7,2)   not null
, bonus       number(7,2)   not null
  -- 
  -- attribute constraints:
, constraint  grd_chk_grad  check (grade  > 0)
, constraint  grd_chk_llim  check (llimit > 0)
, constraint  grd_chk_ulim  check (ulimit > 0)
, constraint  grd_chk_bon1  check (bonus  > 0)
  -- 
  -- tuple constraints:
, constraint  grd_chk_bndw  check (llimit <= ulimit - 500)
, constraint  grd_chk_bon2  check (bonus < llimit)
  -- 
  -- table constraints:
, constraint  grd_pk        primary key (grade)
, constraint  grd_unq1      unique (llimit)
, constraint  grd_unq2      unique (ulimit)
  --
  -- database constraints:
);
-- 
-- ===================================================================
-- Create EMP
-- ===================================================================
-- 
create table  emp
( empno       number(4,0)   not null
, ename       varchar(8)    not null
, job         varchar(9)    not null
, born        date          not null
, hired       date          not null
, sgrade      number(2,0)   not null
, msal        number(7,2)   not null
, username    varchar2(15)  not null
, deptno      number(2,0)   not null
  -- 
  -- attribute constraints:
, constraint  emp_chk_empno check (empno > 999)
, constraint  emp_chk_job   check (job in ('PRESIDENT'
                                         ,'MANAGER'
                                         ,'SALESREP'
                                         ,'TRAINER'
                                         ,'ADMIN'  ))
, constraint  emp_chk_brn   check (trunc(born) = born)
, constraint  emp_chk_hrd   check (trunc(hired) = hired)
, constraint  emp_chk_msal  check (msal > 0)
, constraint  emp_chk_usrnm check(upper(username) = username)
  -- 
  -- tuple constraints:
, constraint  emp_chk_adlt  check (born + interval '18' year <= hired)
, constraint  emp_chk_dsal  check (job <> 'PRESIDENT' or msal > 10000)
, constraint  emp_chk_asal  check (job <> 'ADMIN'     or msal <  5000)
 -- 
 -- table constraints:
, constraint  emp_pk        primary key (empno)
, constraint  emp_unq1      unique (username)
 -- 
 -- database constraints:
, constraint  emp_fk_grd    foreign key (sgrade)
                            references grd(grade)
-- (Created later)
--, constraint  emp_fk_dep    foreign key (deptno)
--                            references dept(deptno)
);
-- 
-- ===================================================================
-- Create SREP
-- ===================================================================
-- 
create table  srep
( empno       number(4,0)   not null
, target      number(6,0)   not null
, comm        number(7,2)   not null
  -- 
  -- attribute constraints:
, constraint  srp_chk_empno check (empno > 999)
, constraint  srp_chk_targ  check (target > 9999)
, constraint  srp_chk_comm  check (comm > 0)
  -- 
  -- tuple constraints:
  -- 
  -- table constraints:
, constraint  srp_pk        primary key (empno)
  -- 
  -- database constraints:
, constraint  srp_fk_emp    foreign key (empno)
                            references emp(empno)
);
-- 
-- ===================================================================
-- Create MEMP
-- ===================================================================
-- 
create table  memp
( empno       number(4,0)   not null
, mgr         number(4,0)   not null
  -- 
  -- attribute constraints:
, constraint  mmp_chk_empno check (empno > 999)
, constraint  mmp_chk_mgr   check (mgr > 999)
  -- 
  -- tuple constraints:
, constraint  mmp_chk_cycl  check (empno <> mgr)
  -- 
  -- table constraints:
, constraint  mmp_pk        primary key (empno)
  -- 
  -- database constraints:
, constraint  mmp_fk1_emp   foreign key (empno)
                            references emp(empno)
, constraint  mmp_fk2_emp   foreign key (mgr)
                            references emp(empno)
);
-- ===================================================================
-- Create TERM
-- ===================================================================
-- 
create table  term
( empno       number(4,0)   not null
, left        date          not null
, comments    varchar(60)   
  -- 
  -- attribute constraints:
, constraint  trm_chk_empno check (empno > 999)
, constraint  trm_chk_lft   check (trunc(left) = left)
  -- 
  -- tuple constraints:
  -- 
  -- table constraints:
, constraint  trm_pk        primary key (empno)
  -- 
  -- database constraints:
, constraint  trm_fk_emp    foreign key (empno)
                            references emp(empno)
);
-- 
-- ===================================================================
-- Create DEPT
-- ===================================================================
-- 
create table  dept
( deptno      number(2,0)   not null
, dname       varchar(12)   not null
, loc         varchar(14)    not null
, mgr         number(4,0)   not null
  -- 
  -- attribute constraints:
, constraint  dep_chk_dno   check (deptno > 0)
, constraint  dep_chk_dnm   check (upper(dname) = dname)
, constraint  dep_chk_loc   check (upper(loc) = loc)
, constraint  dep_chk_mgr   check (mgr > 999)
  -- 
  -- tuple constraints:
  -- 
  -- table constraints:
, constraint  dep_pk        primary key (deptno)
, constraint  dep_unq1      unique (dname,loc)
 -- 
 -- database constraints:
, constraint  dep_fk_emp    foreign key (mgr)
                            references emp(empno) initially deferred
);
--
-- Now create FK from emp to dept.
--
alter table emp add
( constraint  emp_fk_dep    foreign key (deptno)
                            references dept(deptno));
-- 
-- ===================================================================
-- Create CRS
-- ===================================================================
-- 
create table  crs
( code        varchar(6)    not null
, descr       varchar(40)   not null
, cat         varchar(3)    not null
, dur         number(2,0)   not null
  -- attribute constraints:
, constraint  reg_chk_code  check (code = upper(code))
, constraint  reg_chk_cat   check (cat in ('GEN','BLD','DSG'))
, constraint  reg_chk_dur1  check (dur between 1 and 15)
  -- 
  -- tuple constraints:
, constraint  reg_chk_dur2  check (cat <> 'BLD' OR dur <= 5)
  -- 
  -- table constraints:
, constraint  crs_pk        primary key (code)
  -- 
  -- database constraints:
);
-- 
-- ===================================================================
-- Create OFFR
-- ===================================================================
-- 
create table  offr
( course      varchar(6)    not null
, starts      date          not null
, status      varchar(4)    not null
, maxcap      number(2,0)   not null
, trainer     number(4,0)   
, loc         varchar(14)    not null
  -- 
  -- attribute constraints:
, constraint  ofr_chk_crse  check (course = upper(course))
, constraint  ofr_chk_strs  check (trunc(starts) = starts)
, constraint  ofr_chk_stat  check (status in ('SCHD','CONF','CANC'))
, constraint  ofr_chk_trnr  check (trainer > 999 or trainer is null)
, constraint  ofr_chk_mxcp  check (maxcap between 6 and 99)
  -- 
  -- tuple constraints:
, constraint  ofr_chk_trst  check (trainer is not null or status in ('CANC','SCHD'))
  -- 
  -- table constraints:
, constraint  ofr_pk        primary key (course,starts)
, constraint  ofr_unq       unique (starts,trainer)
  -- 
  -- database constraints:
, constraint  ofr_fk_crs    foreign key (course)
                            references crs(code)
, constraint  ofr_fk_emp    foreign key (trainer)
                            references emp(empno)
);
-- 
-- ===================================================================
-- Create REG
-- ===================================================================
-- 
create table  reg
( stud        number(4,0)   not null
, course      varchar(6)    not null
, starts      date          not null
, eval        number(1,0)   not null
  -- 
  -- attribute constraints:
, constraint  reg_chk_stud  check (stud > 999)
, constraint  reg_chk_crse  check (course = upper(course))
, constraint  reg_chk_strs  check (trunc(starts) = starts)
, constraint  reg_chk_eval  check (eval between -1 and 5)
  -- 
  -- tuple constraints:
  -- 
  -- table constraints:
, constraint  reg_pk        primary key (stud,starts)
  -- 
  -- database constraints:
, constraint  reg_fk_emp    foreign key (stud)
                            references emp(empno)
, constraint  reg_fk_ofr    foreign key (course,starts)
                            references offr(course,starts)
);
-- 
-- ===================================================================
-- Create HIST
-- ===================================================================
-- 
create table  hist
( empno       number(4,0)   not null
, until       date          not null
, deptno      number(2,0)   not null
, msal        number(7,2)   not null
  -- 
  -- attribute constraints:
, constraint  hst_chk_eno   check (empno > 999)
, constraint  hst_chk_unt   check (trunc(until) = until)
, constraint  hst_chk_dno   check (deptno > 0)
, constraint  hst_chk_msal  check (msal > 0)
  -- 
  -- tuple constraints:
  -- 
  -- table constraints:
, constraint  hst_pk        primary key (empno,until)
  -- 
  -- database constraints:
, constraint  hst_fk_emp    foreign key (empno)
                            references emp(empno)
, constraint  hst_fk_dep    foreign key (deptno)
                            references dept(deptno)
);
-- 
-- ===================================================================
-- Cleanup section
-- ===================================================================
-- 
spool off
set echo off
