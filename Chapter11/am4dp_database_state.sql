-- ===================================================================
-- SQL*Plus script:   am4dp_database_state.sql
--                    Creates a valid database state in the AM4DP schema
--                    Generates a spool file am4dp_database_state.txt
-- For more details:  See Appendix A
-- 
-- Modifications:
-- January 2007, Toon, creation
--
-- ===================================================================
--  
set  echo off termout off
-- 
-- ===================================================================
-- Drop current database state first ...
-- ===================================================================
-- 
delete from reg;
delete from offr;
delete from crs;
delete from srep;
delete from term;
delete from memp;
delete from hist;
delete from emp;
delete from dept;
delete from grd;
-- 
alter session set nls_date_format='DD-MM-YYYY';
--
set   echo on termout on trimspool on
spool am4dp_database_state.txt
-- 
-- ===================================================================
-- Set up base data in GRD, EMP, SREP, MEMP and DEPT.
-- ===================================================================
-- 
-- GRD
-- 
insert into grd(grade,llimit,ulimit,bonus) values(1,500,1500,250);
insert into grd(grade,llimit,ulimit,bonus) values(2,1000,2500,500);
insert into grd(grade,llimit,ulimit,bonus) values(3,2000,3500,500);
insert into grd(grade,llimit,ulimit,bonus) values(4,3000,4500,500);
insert into grd(grade,llimit,ulimit,bonus) values(5,4000,5500,1000);
insert into grd(grade,llimit,ulimit,bonus) values(6,5000,6500,1000);
insert into grd(grade,llimit,ulimit,bonus) values(7,6000,7500,1000);
insert into grd(grade,llimit,ulimit,bonus) values(8,7000,8500,2000);
insert into grd(grade,llimit,ulimit,bonus) values(9,8000,9500,2000);
insert into grd(grade,llimit,ulimit,bonus) values(10,9000,10500,3500);
insert into grd(grade,llimit,ulimit,bonus) values(11,10000,16500,5500);
commit;
--
-- Set up first department.
--
insert into dept(deptno,dname,loc,mgr) values(10,'HEAD OFFICE','DALLAS',1001);
--
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1002,'Petra','ADMIN','21-03-1956','01-07-1987',3,3300,'PETRA',10);
--
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1000,'Hans','PRESIDENT','22-12-1957','01-01-1992',11,15500,'HANS',10);
--
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1001,'Ronald','MANAGER','04-09-1964','01-07-1999',10,9300,'RONALD',10);
--
insert into memp(empno,mgr) values(1001,1000);
insert into memp(empno,mgr) values(1002,1001);
--
commit;
--
-- Set up other departments.
--
insert into dept(deptno,dname,loc,mgr) values(11,'MARKETING','HOUSTON',1003);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1004,'Sandra','ADMIN','25-04-1982','01-07-2000',2,2400,'SANDRA',11);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1003,'Koen','MANAGER','30-03-1973','01-07-2000',9,8250,'KOEN',11);
insert into memp(empno,mgr) values(1004,1003);
insert into memp(empno,mgr) values(1003,1000);
commit;
--
insert into dept(deptno,dname,loc,mgr) values(12,'FINANCE','NEW YORK',1005);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1006,'Debbie','ADMIN','09-07-1977','01-07-2000',2,2150,'DEBBIE',12);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1005,'Harry','MANAGER','20-04-1968','01-07-2000',8,7900,'HARRY',12);
insert into memp(empno,mgr) values(1006,1005);
insert into memp(empno,mgr) values(1005,1000);
commit;
--
insert into dept(deptno,dname,loc,mgr) values(13,'RESEARCH','AMSTERDAM',1007);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1008,'Monique','ADMIN','24-01-1969','01-05-1997',3,2900,'MONIQUE',13);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1007,'Toon','MANAGER','14-02-1965','01-09-2001',9,9450,'TOON',13);
insert into memp(empno,mgr) values(1008,1007);
insert into memp(empno,mgr) values(1007,1000);
commit;
--
insert into dept(deptno,dname,loc,mgr) values(14,'EDUCATION','DENVER',1009);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1010,'Julie','ADMIN','16-11-1958','01-09-1999',3,2900,'JULIE',14);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1009,'Lex','MANAGER','11-08-1954','01-09-1999',9,9450,'LEX',14);
insert into memp(empno,mgr) values(1010,1009);
insert into memp(empno,mgr) values(1009,1000);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1012,'Patrick','SALESREP','03-12-1969','01-08-2003',5,5150,'PATRICK',14);
insert into srep(empno,target,comm) values(1012,45000,3000);
insert into memp values(1012,1009);
commit;
--
insert into dept(deptno,dname,loc,mgr) values(15,'CONSULTING','SAN FRANCISCO',1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1011,'Emiel','SALESREP','17-04-1972','01-03-2000',5,5300,'EMIEL',15);
insert into srep(empno,target,comm) values(1011,100000,11000);
insert into memp values(1011,1001);
commit;
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1013,'Miriam','SALESREP','12-08-1968','01-03-2001',5,4900,'MIRIAM',15);
insert into srep(empno,target,comm) values(1013,20000,1500);
insert into memp values(1013,1001);
commit;
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1014,'Johan','SALESREP','03-11-1965','01-01-1994',6,5500,'JOHAN',15);
insert into srep(empno,target,comm) values(1014,25000,2100);
insert into memp values(1014,1001);
commit;
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1015,'Antoinet','SALESREP','03-11-1971','01-09-2001',5,4800,'ANTOINETTE',15);
insert into srep(empno,target,comm) values(1015,17500,1500);
insert into memp values(1015,1001);
commit;
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1016,'Mark','TRAINER','12-04-1967','01-02-1998',6,6100,'MARK',15);
insert into memp values(1016,1001);
commit;
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1017,'Marcel','TRAINER','12-04-1972','01-07-1996',6,5800,'MARCEL',15);
insert into memp values(1017,1001);
commit;
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1018,'Marco','TRAINER','28-10-1968','01-01-1997',6,6000,'MARCO',15);
insert into memp values(1018,1001);
commit;
--
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1019,'Ad','ADMIN','10-10-1970','01-01-2000',4,4000,'AD',15);
insert into memp values(1019,1001);
commit;
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1020,'Lotte','ADMIN','10-10-1970','01-01-2000',4,4000,'LOTTE',15);
insert into memp values(1020,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1021,'Marian','ADMIN','11-11-1971','01-01-2000',4,4000,'MARIAN',15);
insert into memp values(1021,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1022,'Kitty','ADMIN','12-12-1972','01-01-2000',4,4000,'KITTY',15);
insert into memp values(1022,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1023,'Nicole','ADMIN','04-08-1967','01-01-2000',4,4000,'NICOLE',15);
insert into memp values(1023,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1024,'Eric','ADMIN','10-09-1967','01-01-2000',4,4000,'ERIC',15);
insert into memp values(1024,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1025,'Gerrit','ADMIN','04-05-1967','01-01-2000',4,4000,'GERRIT',15);
insert into memp values(1025,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1026,'Jos','ADMIN','05-10-1972','01-01-2000',4,4000,'JOS',15);
insert into memp values(1026,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1027,'Robert','ADMIN','30-08-1972','01-01-2000',4,4000,'ROBERT',15);
insert into memp values(1027,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1028,'Daan','ADMIN','30-01-1972','01-01-2000',4,4000,'DAAN',15);
insert into memp values(1028,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1029,'Pim','ADMIN','14-06-1970','01-01-2000',4,4000,'PIMMIE',15);
insert into memp values(1029,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1030,'Jaap','ADMIN','19-11-1970','01-01-2000',4,4000,'JAAP',15);
insert into memp values(1030,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1031,'Ronaldo','ADMIN','04-12-1964','01-01-2000',4,4000,'RONALDO',15);
insert into memp values(1031,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1032,'Bas','ADMIN','26-03-1964','01-01-2000',4,4000,'BAS',15);
insert into memp values(1032,1001);
insert into emp(empno,ename,job,born,hired,sgrade,msal,username,deptno)
values(1033,'Vince','ADMIN','21-03-1965','01-01-2000',4,4000,'VINCE',15);
insert into memp values(1033,1001);
commit;
-- 
-- ===================================================================
-- Set up base data in CRS and OFFR.
-- ===================================================================
-- 
insert into crs(code,descr,cat,dur) values('AM4DP','Applied Math for DB-Pros','DSG',10);
insert into crs(code,descr,cat,dur) values('AM4DPM','AM4DP for Managers','DSG',1);
insert into crs(code,descr,cat,dur) values('RGDEV','RuleGen for Developers','GEN',3);
insert into crs(code,descr,cat,dur) values('RGARCH','RuleGen for Architects','BLD',4);
insert into crs(code,descr,cat,dur) values('DBCENT','DB-Centric Software Arhitectures','DSG',4);
insert into crs(code,descr,cat,dur) values('PLSQL','PL/SQL for Database Developers','BLD',3);
insert into crs(code,descr,cat,dur) values('J2EE','J2EE for Dummies','BLD',1);
insert into crs(code,descr,cat,dur) values('APEX','ApEx for Dummies','BLD',1);
commit;
-- Let trainer 1017 offer all courses (one year after hired).
insert into offr(course,starts,status,maxcap,trainer,loc)
values('J2EE','14-08-1997','CONF',6,1017,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1018,'J2EE','14-08-1997',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('APEX','15-08-1997','CONF',6,1017,'SAN FRANCISCO'); 
insert into reg (stud,course,starts,eval) values(1018,'APEX','15-08-1997',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('PLSQL','16-08-1997','CONF',6,1017,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1018,'PLSQL','16-08-1997',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('DBCENT','20-08-1997','CONF',6,1017,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1018,'DBCENT','20-08-1997',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGARCH','24-08-1997','CONF',6,1017,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1018,'RGARCH','24-08-1997',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGDEV','28-08-1997','CONF',6,1017,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1018,'RGDEV','28-08-1997',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DPM','03-09-1997','CONF',6,1017,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1018,'AM4DPM','03-09-1997',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DP','06-09-1997','CONF',6,1017,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1018,'AM4DP','06-09-1997',5);
commit;
-- Let trainer 1018 offer all courses (one year after hired).
insert into offr(course,starts,status,maxcap,trainer,loc)
values('J2EE','14-08-1998','CONF',6,1018,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'J2EE','14-08-1998',5);
insert into reg (stud,course,starts,eval) values(1016,'J2EE','14-08-1998',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('APEX','15-08-1998','CONF',6,1018,'SAN FRANCISCO'); 
insert into reg (stud,course,starts,eval) values(1017,'APEX','15-08-1998',5);
insert into reg (stud,course,starts,eval) values(1016,'APEX','15-08-1998',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('PLSQL','16-08-1998','CONF',6,1018,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'PLSQL','16-08-1998',5);
insert into reg (stud,course,starts,eval) values(1016,'PLSQL','16-08-1998',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('DBCENT','20-08-1998','CONF',6,1018,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'DBCENT','20-08-1998',5);
insert into reg (stud,course,starts,eval) values(1016,'DBCENT','20-08-1998',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGARCH','24-08-1998','CONF',6,1018,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'RGARCH','24-08-1998',5);
insert into reg (stud,course,starts,eval) values(1016,'RGARCH','24-08-1998',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGDEV','28-08-1998','CONF',6,1018,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'RGDEV','28-08-1998',5);
insert into reg (stud,course,starts,eval) values(1016,'RGDEV','28-08-1998',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DPM','03-09-1998','CONF',6,1018,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'AM4DPM','03-09-1998',5);
insert into reg (stud,course,starts,eval) values(1016,'AM4DPM','03-09-1998',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DP','06-09-1998','CONF',6,1018,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'AM4DP','06-09-1998',5);
insert into reg (stud,course,starts,eval) values(1016,'AM4DP','06-09-1998',5);
commit;
-- Let trainer 1016 offer all courses (one year after hired).
insert into offr(course,starts,status,maxcap,trainer,loc)
values('J2EE','10-10-2001','CONF',6,1016,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'J2EE','10-10-2001',5);
insert into reg (stud,course,starts,eval) values(1011,'J2EE','10-10-2001',5);
insert into reg (stud,course,starts,eval) values(1013,'J2EE','10-10-2001',5);
insert into reg (stud,course,starts,eval) values(1014,'J2EE','10-10-2001',5);
insert into reg (stud,course,starts,eval) values(1015,'J2EE','10-10-2001',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('APEX','11-10-2001','CONF',6,1016,'SAN FRANCISCO'); 
insert into reg (stud,course,starts,eval) values(1017,'APEX','11-10-2001',5);
insert into reg (stud,course,starts,eval) values(1011,'APEX','11-10-2001',4);
insert into reg (stud,course,starts,eval) values(1013,'APEX','11-10-2001',3);
insert into reg (stud,course,starts,eval) values(1014,'APEX','11-10-2001',3);
insert into reg (stud,course,starts,eval) values(1015,'APEX','11-10-2001',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('PLSQL','12-10-2001','CONF',6,1016,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'PLSQL','12-10-2001',3);
insert into reg (stud,course,starts,eval) values(1011,'PLSQL','12-10-2001',3);
insert into reg (stud,course,starts,eval) values(1013,'PLSQL','12-10-2001',5);
insert into reg (stud,course,starts,eval) values(1014,'PLSQL','12-10-2001',5);
insert into reg (stud,course,starts,eval) values(1015,'PLSQL','12-10-2001',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('DBCENT','17-10-2001','CONF',6,1016,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'DBCENT','17-10-2001',5);
insert into reg (stud,course,starts,eval) values(1011,'DBCENT','17-10-2001',3);
insert into reg (stud,course,starts,eval) values(1013,'DBCENT','17-10-2001',4);
insert into reg (stud,course,starts,eval) values(1014,'DBCENT','17-10-2001',5);
insert into reg (stud,course,starts,eval) values(1015,'DBCENT','17-10-2001',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGARCH','22-10-2001','CONF',6,1016,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'RGARCH','22-10-2001',3);
insert into reg (stud,course,starts,eval) values(1011,'RGARCH','22-10-2001',5);
insert into reg (stud,course,starts,eval) values(1013,'RGARCH','22-10-2001',4);
insert into reg (stud,course,starts,eval) values(1014,'RGARCH','22-10-2001',4);
insert into reg (stud,course,starts,eval) values(1015,'RGARCH','22-10-2001',5);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGDEV','27-10-2001','CONF',6,1016,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'RGDEV','27-10-2001',3);
insert into reg (stud,course,starts,eval) values(1011,'RGDEV','27-10-2001',3);
insert into reg (stud,course,starts,eval) values(1013,'RGDEV','27-10-2001',4);
insert into reg (stud,course,starts,eval) values(1014,'RGDEV','27-10-2001',5);
insert into reg (stud,course,starts,eval) values(1015,'RGDEV','27-10-2001',3);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DPM','30-10-2001','CONF',6,1016,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'AM4DPM','30-10-2001',3);
insert into reg (stud,course,starts,eval) values(1011,'AM4DPM','30-10-2001',5);
insert into reg (stud,course,starts,eval) values(1013,'AM4DPM','30-10-2001',4);
insert into reg (stud,course,starts,eval) values(1014,'AM4DPM','30-10-2001',5);
insert into reg (stud,course,starts,eval) values(1015,'AM4DPM','30-10-2001',4);
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DP','03-11-2001','CONF',6,1016,'SAN FRANCISCO');
insert into reg (stud,course,starts,eval) values(1017,'AM4DP','03-11-2001',4);
insert into reg (stud,course,starts,eval) values(1011,'AM4DP','03-11-2001',4);
insert into reg (stud,course,starts,eval) values(1013,'AM4DP','03-11-2001',4);
insert into reg (stud,course,starts,eval) values(1014,'AM4DP','03-11-2001',4);
insert into reg (stud,course,starts,eval) values(1015,'AM4DP','03-11-2001',4);
commit;
-- Other offerings.
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DP','02-03-2004','CONF',12,1016,'AMSTERDAM');
insert into reg (stud,course,starts,eval) values(1019,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1020,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1021,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1022,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1023,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1024,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1025,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1026,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1027,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1028,'AM4DP','02-03-2004',4);
insert into reg (stud,course,starts,eval) values(1029,'AM4DP','02-03-2004',4);
commit;
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DP','03-03-2004','CONF',8,1017,'DALLAS');
insert into reg (stud,course,starts,eval) values(1030,'AM4DP','03-03-2004',4);
insert into reg (stud,course,starts,eval) values(1031,'AM4DP','03-03-2004',4);
insert into reg (stud,course,starts,eval) values(1032,'AM4DP','03-03-2004',4);
insert into reg (stud,course,starts,eval) values(1033,'AM4DP','03-03-2004',4);
commit;
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGDEV','02-09-2004','CONF',12,1017,'HOUSTON');
insert into reg (stud,course,starts,eval) values(1019,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1020,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1021,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1022,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1023,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1024,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1025,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1026,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1027,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1028,'RGDEV','02-09-2004',4);
insert into reg (stud,course,starts,eval) values(1029,'RGDEV','02-09-2004',4);
commit;
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGDEV','03-09-2004','CONF',8,1018,'DENVER');
insert into reg (stud,course,starts,eval) values(1030,'RGDEV','03-09-2004',4);
insert into reg (stud,course,starts,eval) values(1031,'RGDEV','03-09-2004',4);
insert into reg (stud,course,starts,eval) values(1032,'RGDEV','03-09-2004',4);
insert into reg (stud,course,starts,eval) values(1033,'RGDEV','03-09-2004',4);
commit;
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DPM','03-04-2005','CONF',6,1018,'AMSTERDAM');
insert into reg (stud,course,starts,eval) values(1000,'AM4DPM','03-04-2005',4);
insert into reg (stud,course,starts,eval) values(1001,'AM4DPM','03-04-2005',4);
insert into reg (stud,course,starts,eval) values(1003,'AM4DPM','03-04-2005',4);
insert into reg (stud,course,starts,eval) values(1005,'AM4DPM','03-04-2005',4);
insert into reg (stud,course,starts,eval) values(1007,'AM4DPM','03-04-2005',4);
insert into reg (stud,course,starts,eval) values(1009,'AM4DPM','03-04-2005',4);
commit;
-- Cancelled offerings.
insert into offr(course,starts,status,maxcap,trainer,loc)
values('DBCENT','03-10-2004','CANC',6,1016,'HOUSTON');
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGARCH','03-10-2004','CANC',6,1017,'SAN FRANCISCO');
insert into offr(course,starts,status,maxcap,trainer,loc)
values('J2EE','03-10-2004','CANC',6,1018,'NEW YORK');
commit;
-- Scheduled offerings.
insert into offr(course,starts,status,maxcap,trainer,loc)
values('DBCENT','03-10-2006','SCHD',6,1016,'AMSTERDAM');
insert into reg (stud,course,starts,eval) values(1022,'DBCENT','03-10-2006',-1);
insert into reg (stud,course,starts,eval) values(1028,'DBCENT','03-10-2006',-1);
commit;
insert into offr(course,starts,status,maxcap,trainer,loc)
values('AM4DP','03-08-2006','SCHD',6,1016,'DENVER');
insert into reg (stud,course,starts,eval) values(1021,'AM4DP','03-08-2006',-1);
insert into reg (stud,course,starts,eval) values(1023,'AM4DP','03-08-2006',-1);
insert into reg (stud,course,starts,eval) values(1024,'AM4DP','03-08-2006',-1);
insert into reg (stud,course,starts,eval) values(1031,'AM4DP','03-08-2006',-1);
commit;
insert into offr(course,starts,status,maxcap,trainer,loc)
values('RGDEV','03-09-2006','SCHD',6,1016,'DALLAS');
commit;
-- 
-- ===================================================================
-- Cleanup section
-- ===================================================================
-- 
spool off
set echo off
