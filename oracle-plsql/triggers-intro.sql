-- >---
-- >title: Oracle plsql Triggers
-- >metadata:
-- >    description: 'Oracle Triggers'
-- >    keywords: 'Oracle triggers, stored procedures example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: triggers
-- >slug: oracle/plsql/triggers
-- >---

-- ># Oracle Triggers
-- >* Triggers are oracle database objects that are implicitly executed when
-- >  a triggering event occurs, irrespective of the connected user or the 
-- >  running application.
-- >* A Trigger is comprised of THREE main parts
-- >  ** The Triggering Event or Statement
-- >  ** Trigger Restriction
-- >  ** Trigger Action


-- >## Oracle Triggers - Triggering Event
-- >* Triggers can be fired (or some code executed) for the following scenarios
-- > ** Any INSERT, UPDATE or DELETE statement on a specific table or view
-- > ** On any CREATE, ALTER or DROP statement on any schema object
-- > ** Database startup or instance shutdown
-- > ** For any Specific error message or any error message
-- > ** User logon or logoff


-- >## Oracle Triggers - Trigger Restriction
-- >* This is a CONDITION which when true executes the Trigger Action.
-- >* WHEN INSERTING THEN or IF any condition is true.


-- >## Oracle Triggers - Trigger Action
-- >* This is the code that executes when the Trigger Restriction is TRUE.
-- >* This could be SQL, PL/SQL or Java statements.


-- >## Oracle Triggers Types
-- >* Different types of triggers:
-- > ** Row Triggers and Statement Triggers
-- > ** BEFORE and AFTER Triggers
-- > ** Compound Triggers
-- > ** INSTEAD OF Triggers
-- > ** Triggers on System Events and User Events
