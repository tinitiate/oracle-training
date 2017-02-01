-- ---
-- title: Oracle 12c create user
-- metadata:
--     description: 'Oracle create a user in oracle 12c'
--     keywords: 'Oracle create user, local user, common user, oracle 12c, example code, tutorials'
-- author: Venkata Bhattaram / tinitiate.com
-- code-alias: create-user
-- slug: oracle/oracle-dba/create-user-12c
-- ---

-- # Users in Oracle
-- * There are two types of users in Oracle 12c
-- * **Common Use** The user is present in all containers databases (root and all PDBs).
-- * **Local User** The user is only present in a specific PDB. The same username can be present in multiple PDBs, but they are unrelated.

-- ```sql
-- Login as SYSDBA and run the following

-- Step 1.
-- Get the name of the current PDB
SELECT    name, pdb
FROM      v$services
ORDER BY  name;

-- Open the database
alter database open;

-- Set the current PDB, on this installation there is only pdborcl
ALTER SESSION SET CONTAINER = pdborcl;

-- Create a Local user
create user tinitiate identified by tinitiate;
grant connect, resource to tinitiate;
-- ```

