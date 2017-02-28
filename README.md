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

All but `core_usermailing` are replicated using FlyData. `core_usermailing` is replicated using a DMS task called [flydata-core-usermailing](https://us-west-2.console.aws.amazon.com/dms/home?region=us-west-2#tasks:ids=flydata-core-usermailing), which utilizes the medium [core-usermailing-replication](https://us-west-2.console.aws.amazon.com/dms/home?region=us-west-2#replication-instances:ids=core-usermailing-replication;dt=ov) as a replication instance. 

As you know, I spent a good while trying to get all the migrations working using just DMS at first. You can find all files that are relevant to DMS migrations in the `/dms` folder. `create_tables.json` is a file that defines the statements for creating tables with the desired columns and data types for the tables we wanted to import. `transformations.json` is a file that defines which tables to migrate and what columns to drop or rename in a task for migrating all the listed tables and their desired columns. `task_settings.json` is a file that describes the DMS task for migrating (full load + replication) all the desired tables in a single task, with limited LOB mode and column preparation mode set to `truncate` (empty data but do not drop columns). 

But as you recall, we're no longer migrating all tables using DMS, so the files for full table migrations are _currently not in use_. I'm keeping them around in case we will some day return to migrations using DMS. The files that describe the `core_usermailing` migration task that _is_ currently running are in `/dms/core_usermailing`. The `task_settings.json` and `transformations.json` files, with similar purposes as the files with the same names in `/dms`.
