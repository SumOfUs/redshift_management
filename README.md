# Redshift management files

This is a repository with files that I have used to set up and manage our Redshift instance and migrations. 

In the current setup, we're migrating data to a Redshift cluster (called flydata-cluster) which you can view [here](https://us-west-2.console.aws.amazon.com/redshift/home?region=us-west-2#cluster-list).
The instance includes the following tables under the schema `ak_sumofus`:

* core_user
* core_list
* core_page
* core_userfield
* core_location
* core_mailing
* core_action
* core_actionfield
* core_clickurl
* core_useragent
* core_click
* core_open
* share_type
* share_link
* share_action
* share_click
* core_order
* core_transaction
* core_orderrecurring
* core_tag
* core_mailing_tags
* core_page_tags
* core_subscriptionhistory
* core_subscription
* core_phone
* core_usermailing

## Replication

All but `core_usermailing` are replicated using FlyData. `core_usermailing` is replicated using a DMS task called [flydata-core-usermailing](https://us-west-2.console.aws.amazon.com/dms/home?region=us-west-2#tasks:ids=flydata-core-usermailing), which utilizes the medium [core-usermailing-replication](https://us-west-2.console.aws.amazon.com/dms/home?region=us-west-2#replication-instances:ids=core-usermailing-replication;dt=ov) as a replication instance. Alerts are set up so that if there is a load error on FlyData, an email is sent to tech@sumofus.org

As you know, I spent a good while trying to get all the migrations working using just DMS at first. You can find all files that are relevant to DMS migrations in the `/dms` folder. `create_tables.json` is a file that defines the statements for creating tables with the desired columns and data types for the tables we wanted to import. `transformations.json` is a file that defines which tables to migrate and what columns to drop or rename in a task for migrating all the listed tables and their desired columns. `task_settings.json` is a file that describes the DMS task for migrating (full load + replication) all the desired tables in a single task, with limited LOB mode and column preparation mode set to `truncate` (empty data but do not drop columns). You might need the file if you want to create a new DMS task through the AWS DMS command line utility, but it's also possible to just create tasks (here)[https://us-west-2.console.aws.amazon.com/dms/home?region=us-west-2#tasks:] through the AWS web console.

As you recall, we're no longer migrating all tables using DMS, so the files for full table migrations are _currently not in use_. I'm keeping them around in case we will some day return to migrations using DMS. The files that describe the `core_usermailing` migration task that _is_ currently running are in `/dms/core_usermailing`. The `task_settings.json` and `transformations.json` files, with similar purposes as the files with the same names in `/dms`.

All files that are relevant to FlyData replication can be found in the `/flydata` directory. Right now, there is only the `flydata_tables.sql` file, which describes the table creation statements for each of the tables we're replicating through FlyData. The tables follow the column widths and data types created by FlyData, but with added sortkeys, distribution keys, primary and foreign keys, and unique and non null constraints (these latter are just for the query optimizer).

## Modifying tables

There are very few modifications you can perform on existing tables on Redshift - if you want to make modification, you'll need to make a new one with the desired schema and insert the existing data. The files with the create table statements should be helpful to you in this case, but if you need to modify tables, please update the files or create new files with the modifications you have made so it's easier to keep count. 

There are only a few differences in making changes to the tables migrated with the two different services.

#### Modifying the core_usermailing table

If you're modifying a table that is synced by DMS, follow these steps:
1. Stop the replication task
2. Follow this pattern to modify your tables:
  - Rename the table you want to modify from `tablename` to `old_tablename`.
  - Create a new table called `new_tablename`
    - with the expected data types and widths for the columns
    - with unique and not null constraints
    - add primary and foreign keys (for the query optimizer)
    - add distribution and sortkeys
  - Select all data from `tablename` and insert it into `new_tablename`
  - Rename `new_tablename` to `tablename`
3. Continue the replication task
4. Check [the logs on cloudwatch](https://us-west-2.console.aws.amazon.com/cloudwatch/home?region=us-west-2#logEventViewer:group=dms-tasks-core-usermailing-replication;stream=dms-task-TGTKER44KIFBGQPTUGV6HZPGYY) to ensure that there are no replication errors
5. Drop `old_tablename`. 
6. Update the `core_usermailing.sql` file to reflect the changes you've made.

#### Modifying the tables with FlyData replication

FlyData-related table modification statements are in the `flydata_tables.sql` files in the `/flydata` folder. 
Statements to modify the tables should follow this pattern:

1. Rename the table you want to modify from `tablename` to `old_tablename`.
2. Create a new table called `new_tablename`
  - with the expected data types and widths for the columns
  - with unique and not null constraints
  - add primary and foreign keys (for the query optimizer)
  - add distribution and sortkeys
3. Select all data from `tablename` and insert it into `new_tablename`
4. Rename `new_tablename` to `tablename`
5. Check [FlyData error logs]() to make sure there are no replication errors.
6. Drop `old_tablename`. 
7. Update `flydata_tables.sql` to reflect the changes you made.

If you're modifying tables synced with FlyData, you can follow this pattern without stopping sync, and the changes that temporarily don't get inserted into `old_tablename` because of the rename step will be buffered and added afterwards. 

## Recreating a table in case there's an issue with replication and it doesn't recover properly (e.g. an outage that's longer than binary log retention)

## Setting up a brand new instance
