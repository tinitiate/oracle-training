alter session set container = pdborcl;
alter database open;


SELECT DBMS_XDB_CONFIG.gethttpsport FROM dual;

begin 
  DBMS_XDB_CONFIG.sethttpsport(5500);
end;

