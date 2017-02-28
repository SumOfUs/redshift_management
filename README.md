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

All but `core_usermailing` are replicated using FlyData. `core_usermailing` is replicated using a DMS task called [flydata-core-usermailing](https://us-west-2.console.aws.amazon.com/dms/home?region=us-west-2#tasks:ids=flydata-core-usermailing).
