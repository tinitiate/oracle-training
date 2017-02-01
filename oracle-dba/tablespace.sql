-- ---
-- title: Oracle Tablespace, Datablocks, Extents, Segments
-- metadata:
--     description: 'Oracle Tablespace, Datablocks, Extents, Segments explained'
--     keywords: 'Oracle dba, create tablespace, Oracle Tablespace, Datablocks, Extents, Segments, example code, tutorials'
-- author: Venkata Bhattaram / tinitiate.com
-- code-alias: tablespace
-- slug: oracle/oracle-dba/tablespace
-- ---

-- # Tablespace
-- * All data in an Oracle Database is organised logically in tablespaces and 
--   stored physically on the operating system in datafiles.
-- * Each tablespace is comprised of one or more datafiles (actual operating system files)
-- * The units of tablespace (logical database allocation) are data blocks, extents, and segments.

-- ## Data Block
-- * At the lowest level of granularity, Oracle DB stores data in data blocks
-- * Oracle DB requests data in multiples of Oracle blocks, not operating system blocks. 
-- * It is important to select the right block size to avoid unnecessary I/O.

-- ### Selecting a right BLOCK SIZE for datablock
-- * For online transaction processing (OLTP) and heavy insert/update operations
--   it is recommended to use smaller block sizes (2 KB, 4 KB).
-- * **SMALLER BLOCK SIZES** are good for small rows and this reduces block level contention.  
-- * The downside of using smaller block size is the metadata like block header 
--   uses up space leaving less for the actual data and hence not ideal for large rows.
-- * This might result in having very few rows stored in each block
--   and may cause, "row chaining" if a single row spans across blocks.
-- * Row chaining is a scenario when a row spans across blocks and this will cause 
--   more IO while writing and retriving the row data.
-- * **LARGER BLOCK SIZES** (8 KB, 16 KB, 32 KB) are good for  for datawarehouse environment 
--   or datasets having large rows, more columns or CLOBS/BLOBS.
-- * Larger blocks have more space to store data and this enables to store or read 
--   multiple rows with fewer IO.
-- * This provides sequential access on large datasets, which is faster.
-- * If the row data is small then, lot of HDD space is wasted.

-- ### PCTFREE and PCTUSED explained
-- * These are parameters that are used when creating a table, 
-- * They are used to determine the space usage of a row in a datablock.
-- * **PCTFREE** 
-- * The pctfree parameter is used to set the percentage of a block to kept free for possible updates to rows 
-- * **PCTUSED** 
-- * The pctused parameter is used to set the percentage of a block to used to add/insert row(s) into a block 
-- * Choosing the right PCTFREE is determined by the change in row side due to updates, it could grow 20% or 50%
--   or not change at all, in such cases PCTFREE must be 20%, 50% and 0% respectively

-- ### Automatic Segment Space Management
-- * This is a oracle 9i feature, and the developer can leave the decision to handle 
--   PCTFREE to the oracle database
-- * The clause "SEGMENT SPACE MANAGEMENT AUTO" must be used when creating the tablespace,
--   in-order to enable this feature.

-- ## Extent
-- * An extent is a logical unit of database storage space allocation made up of a
--   number of contiguous data blocks.
-- * They are used for every operation in the DB involving IO.

-- ## Segments
-- * A segment is a set of extents that have been allocated for a specific type of data 
--   structure, and that all are stored in the same tablespace.
-- * For example, each table's data is stored in its own data segment and index's data 
--   is stored in its own index segment.


-- ## Create a Oracle Table space and Data File
-- * This is a file created on the Host OS,
-- * Login as sysdba, and run the following command
-- ```sql

-- Step 1.
-- Check all datafiles
select *
from   dba_data_files;

-- Check all tablespaces
select *
from   dba_tablespaces;

select name, pdb
FROM   v$services
order by name;

-- Step 2.
-- Oracle 12c create a tablespace and datafile for all user data objects
-- tables, functions, procedures ..


create tablespace ti_user_data
datafile 'E:\APP\USER\ORADATA\ORCL\user-data-01.DBF' size 1M
autoextend on next 1M;

-- Create one more tablespace and datafile for storing table index data
create tablespace ti_user_indx
datafile 'E:\APP\USER\ORADATA\ORCL\user-indx-01.DBF' size 1M
autoextend on next 1M;
-- ```

-- ## drop table space
-- * Optional DONT run these
--  ``sql
drop tablespace ti_user_data including contents and datafiles;
drop tablespace ti_user_indx including contents and datafiles;
-- ```
