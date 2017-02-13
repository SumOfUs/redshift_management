CREATE TABLE 'core_userfield' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'parent_id' int(11) NOT NULL,
  'name' varchar(255) NOT NULL,
  'value' longtext NOT NULL,
  PRIMARY KEY ('id'),
  KEY 'name_value' ('name','value'(255)),
  KEY 'parent_name_value' ('parent_id','name','value'(255)),
  KEY 'core_userfield_parent_id' ('paent_id'),
  KEY 'core_userfield_name' ('name'),
  CONSTRAINT 'name_refs_name_a510f768' FOREIGN KEY ('name') REFERENCES 'core_alloweduserfield' ('name'),
  CONSTRAINT 'parent_id_refs_id_e43744de' FOREIGN KEY ('parent_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=55615177 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_user' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'email' varchar(255) NOT NULL,
  'prefix' varchar(255) NOT NULL,
  'first_name' varchar(255) NOT NULL,
  'middle_name' varchar(255) NOT NULL,
  'last_name' varchar(255) NOT NULL,
  'suffix' varchar(255) NOT NULL,
  'password' varchar(255) NOT NULL,
  'subscription_status' varchar(255) NOT NULL,
  'address1' varchar(255) NOT NULL,
  'address2' varchar(255) NOT NULL,
  'city' varchar(255) NOT NULL,
  'state' varchar(255) NOT NULL,
  'region' varchar(255) NOT NULL,
  'postal' varchar(255) NOT NULL,
  'zip' varchar(5) NOT NULL,
  'plus4' varchar(4) NOT NULL,
  'country' varchar(255) NOT NULL,
  'source' varchar(255) NOT NULL,
  'lang_id' int(11) DEFAULT NULL,
  'rand_id' int(11) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'email' ('email'),
  KEY 'name' ('last_name','first_name'),
  KEY 'rand_sort_index' ('rand_id','id'),
  KEY 'core_user_created_at' ('created_at'),
  KEY 'core_user_subscription_status' ('subscription_status'),
  KEY 'core_user_state' ('state'),
  KEY 'core_user_zip' ('zip'),
  KEY 'core_user_country' ('country'),
  KEY 'core_user_source' ('source'),
  KEY 'core_user_lang_id' ('lang_id'),
  CONSTRAINT 'lang_id_refs_id_9f93c26e' FOREIGN KEY ('lang_id') REFERENCES 'core_language' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=12654406 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_location' (
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'user_id' int(11) NOT NULL,
  'us_district' varchar(5) NOT NULL,
  'us_state_senate' varchar(6) NOT NULL,
  'us_state_district' varchar(6) NOT NULL,
  'us_county' varchar(255) NOT NULL,
  'loc_code' varchar(30) NOT NULL,
  'country_code' varchar(2) NOT NULL,
  'region_code' varchar(20) NOT NULL,
  'longitude' double DEFAULT NULL,
  'latitude' double DEFAULT NULL,
  'lat_lon_precision' varchar(32) NOT NULL,
  PRIMARY KEY ('user_id'),
  KEY 'core_location_created_at' ('created_at'),
  KEY 'core_location_us_district' ('us_district'),
  KEY 'core_location_us_state_senate' ('us_state_senate'),
  KEY 'core_location_us_state_district' ('us_state_district'),
  KEY 'core_location_loc_code' ('loc_code'),
  KEY 'core_location_country_code' ('country_code'),
  KEY 'core_location_longitude' ('longitude'),
  KEY 'core_location_latitude' ('latitude'),
  CONSTRAINT 'user_id_refs_id_35138c05' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_actionfield' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'parent_id' int(11) NOT NULL,
  'name' varchar(255) NOT NULL,
  'value' longtext NOT NULL,
  PRIMARY KEY ('id'),
  KEY 'name_value' ('name','value'(255)),
  KEY 'parent_name_value' ('parent_id','name','value'(255)),
  KEY 'core_actionfield_parent_id' ('parent_id'),
  CONSTRAINT 'parent_id_refs_id_34ddada2' FOREIGN KEY ('parent_id') REFERENCES 'core_action' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=305067105 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_action' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'user_id' int(11) NOT NULL,
  'mailing_id' int(11) DEFAULT NULL,
  'page_id' int(11) NOT NULL,
  'link' int(11) DEFAULT NULL,
  'source' varchar(255) NOT NULL,
  'opq_id' varchar(255) NOT NULL,
  'created_user' tinyint(1) NOT NULL,
  'subscribed_user' tinyint(1) NOT NULL,
  'referring_user_id' int(11) DEFAULT NULL,
  'referring_mailing_id' int(11) DEFAULT NULL,
  'taf_emails_sent' int(11) DEFAULT NULL,
  'status' varchar(255) NOT NULL,
  'is_forwarded' tinyint(1) NOT NULL DEFAULT ''0'',
  'ip_address' varchar(15) DEFAULT NULL,
  PRIMARY KEY ('id'),
  KEY 'core_action_created_at' ('created_at'),
  KEY 'core_action_user_id' ('user_id'),
  KEY 'core_action_mailing_id' ('mailing_id'),
  KEY 'core_action_page_id' ('page_id'),
  KEY 'core_action_referring_user_id' ('referring_user_id'),
  KEY 'core_action_referring_mailing_id' ('referring_mailing_id'),
  KEY 'source' ('source'),
  CONSTRAINT '__mailing_id_refs_id_ff705055' FOREIGN KEY ('mailing_id') REFERENCES 'core_mailing' ('id'),
  CONSTRAINT '__page_id_refs_id_dcc2b636' FOREIGN KEY ('page_id') REFERENCES 'core_page' ('id'),
  CONSTRAINT '__referring_mailing_id_refs_id_ff705055' FOREIGN KEY ('referring_mailing_id') REFERENCES 'core_mailing' ('id'),
  CONSTRAINT '__referring_user_id_refs_id_f82f6502' FOREIGN KEY ('referring_user_id') REFERENCES 'core_user' ('id'),
  CONSTRAINT '__user_id_refs_id_f82f6502' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=80897891 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_mailing' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'hidden' tinyint(1) NOT NULL,
  'fromline_id' int(11) DEFAULT NULL,
  'custom_fromline' varchar(255) NOT NULL,
  'reply_to' varchar(255) DEFAULT NULL,
  'notes' varchar(255) DEFAULT NULL,
  'html' longtext,
  'text' longtext,
  'lang_id' int(11) DEFAULT NULL,
  'emailwrapper_id' int(11) DEFAULT NULL,
  'web_viewable' tinyint(1) DEFAULT ''0'',
  'landing_page_id' int(11) DEFAULT NULL,
  'target_group_from_landing_page' tinyint(1) NOT NULL,
  'winning_subject_id' int(11) DEFAULT NULL,
  'requested_proofs' int(11) DEFAULT NULL,
  'submitter_id' int(11) DEFAULT NULL,
  'scheduled_for' datetime DEFAULT NULL,
  'scheduled_by_id' int(11) DEFAULT NULL,
  'queue_task_id' varchar(255) DEFAULT NULL,
  'queued_at' datetime DEFAULT NULL,
  'queued_by_id' int(11) DEFAULT NULL,
  'expected_send_count' int(11) DEFAULT NULL,
  'started_at' datetime DEFAULT NULL,
  'finished_at' datetime DEFAULT NULL,
  'query_queued_at' datetime DEFAULT NULL,
  'query_started_at' datetime DEFAULT NULL,
  'query_completed_at' datetime DEFAULT NULL,
  'query_previous_runtime' int(11) DEFAULT NULL,
  'query_status' varchar(255) DEFAULT NULL,
  'query_task_id' varchar(255) DEFAULT NULL,
  'targeting_version' int(11) DEFAULT ''0'',
  'targeting_version_saved' int(11) DEFAULT NULL,
  'rate' double DEFAULT NULL,
  'progress' int(11) DEFAULT NULL,
  'status' varchar(255) DEFAULT NULL,
  'includes_id' int(11) DEFAULT NULL,
  'excludes_id' int(11) DEFAULT NULL,
  'limit' int(11) DEFAULT NULL,
  'sort_by' varchar(32) DEFAULT NULL,
  'pid' int(11) DEFAULT NULL,
  'sent_proofs' int(11) NOT NULL,
  'rebuild_query_at_send' tinyint(1) NOT NULL DEFAULT ''0'',
  'limit_percent' int(11) DEFAULT NULL,
  'mergefile_id' int(11) DEFAULT NULL,
  'target_mergefile' tinyint(1) NOT NULL DEFAULT ''0'',
  'mails_per_second' double DEFAULT NULL,
  'recurring_schedule_id' int(11) DEFAULT NULL,
  'recurring_source_mailing_id' int(11) DEFAULT NULL,
  'requested_proof_date' datetime DEFAULT NULL,
  'send_date' varchar(255) NOT NULL DEFAULT '''',
  'exclude_ordering' int(11) DEFAULT NULL,
  'test_group_id' int(11) DEFAULT NULL,
  'test_remainder' int(11) DEFAULT NULL,
  'mergequery_report_id' int(11) DEFAULT NULL,
  'target_mergequery' tinyint(1) NOT NULL,
  'version' smallint(6) NOT NULL,
  PRIMARY KEY ('id'),
  KEY 'core_mailing_created_at' ('created_at'),
  KEY 'core_mailing_hidden' ('hidden'),
  KEY 'core_mailing_fromline_id' ('fromline_id'),
  KEY 'core_mailing_lang_id' ('lang_id'),
  KEY 'core_mailing_emailwrapper_id' ('emailwrapper_id'),
  KEY 'core_mailing_landing_page_id' ('landing_page_id'),
  KEY 'core_mailing_winning_subject_id' ('winning_subject_id'),
  KEY 'core_mailing_submitter_id' ('submitter_id'),
  KEY 'core_mailing_scheduled_by_id' ('scheduled_by_id'),
  KEY 'core_mailing_queued_by_id' ('queued_by_id'),
  KEY 'core_mailing_includes_id' ('includes_id'),
  KEY 'core_mailing_excludes_id' ('excludes_id'),
  KEY 'core_mailing_started_at' ('started_at'),
  KEY 'core_mailing_finished_at' ('finished_at'),
  KEY 'core_mailing_status' ('status'),
  KEY 'mergefile_id_refs_id_10571ff4' ('mergefile_id'),
  KEY 'core_mailing_recurring_schedule_id' ('recurring_schedule_id'),
  KEY 'core_mailing_recurring_source_mailing_id' ('recurring_source_mailing_id'),
  KEY 'core_mailing_send_date' ('send_date'),
  KEY 'core_mailing_test_group_id' ('test_group_id'),
  KEY 'mergequery_report_id' ('mergequery_report_id'),
  CONSTRAINT 'core_mailing_ibfk_1' FOREIGN KEY ('mergequery_report_id') REFERENCES 'reports_queryreport' ('report_ptr_id'),
  CONSTRAINT 'emailwrapper_id_refs_id_12d06e0c' FOREIGN KEY ('emailwrapper_id') REFERENCES 'core_emailwrapper' ('id'),
  CONSTRAINT 'excludes_id_refs_id_e66c82d1' FOREIGN KEY ('excludes_id') REFERENCES 'core_mailingtargeting' ('id'),
  CONSTRAINT 'fromline_id_refs_id_b519a07f' FOREIGN KEY ('fromline_id') REFERENCES 'core_fromline' ('id'),
  CONSTRAINT 'includes_id_refs_id_e66c82d1' FOREIGN KEY ('includes_id') REFERENCES 'core_mailingtargeting' ('id'),
  CONSTRAINT 'landing_page_id_refs_id_e355a09c' FOREIGN KEY ('landing_page_id') REFERENCES 'core_page' ('id'),
  CONSTRAINT 'lang_id_refs_id_33dfe011' FOREIGN KEY ('lang_id') REFERENCES 'core_language' ('id'),
  CONSTRAINT 'mergefile_id_refs_id_10571ff4' FOREIGN KEY ('mergefile_id') REFERENCES 'core_mergefile' ('id'),
  CONSTRAINT 'queued_by_id_refs_id_84339c71' FOREIGN KEY ('queued_by_id') REFERENCES 'auth_user' ('id'),
  CONSTRAINT 'recurring_schedule_id_refs_id_175b7972' FOREIGN KEY ('recurring_schedule_id') REFERENCES 'core_recurringmailingschedule' ('id'),
  CONSTRAINT 'recurring_source_mailing_id_refs_id_169bdfb3' FOREIGN KEY ('recurring_source_mailing_id') REFERENCES 'core_mailing' ('id'),
  CONSTRAINT 'scheduled_by_id_refs_id_84339c71' FOREIGN KEY ('scheduled_by_id') REFERENCES 'auth_user' ('id'),
  CONSTRAINT 'submitter_id_refs_id_84339c71' FOREIGN KEY ('submitter_id') REFERENCES 'auth_user' ('id'),
  CONSTRAINT 'test_group_id_refs_id_2b036ded' FOREIGN KEY ('test_group_id') REFERENCES 'core_mailingtestgroup' ('id'),
  CONSTRAINT 'winning_subject_id_refs_id_3f2db1b6' FOREIGN KEY ('winning_subject_id') REFERENCES 'core_mailingsubject' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=27185 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_usermailing' (
  'id' bigint(20) NOT NULL AUTO_INCREMENT,
  'mailing_id' int(11) NOT NULL,
  'user_id' int(11) NOT NULL,
  'subject_id' int(11) DEFAULT NULL,
  'created_at' datetime NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'mailing_id' ('mailing_id','user_id'),
  KEY 'core_usermailing_new_mailing_id' ('mailing_id'),
  KEY 'core_usermailing_new_user_id' ('user_id'),
  KEY 'core_usermailing_new_subject_id' ('subject_id'),
  KEY 'core_usermailing_new_created_at' ('created_at'),
  CONSTRAINT 'core_usermailing_ibfk_1' FOREIGN KEY ('mailing_id') REFERENCES 'core_mailing' ('id'),
  CONSTRAINT 'core_usermailing_ibfk_2' FOREIGN KEY ('subject_id') REFERENCES 'core_mailingsubject' ('id'),
  CONSTRAINT 'core_usermailing_ibfk_3' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=1756791270 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_clickurl' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'url' varchar(255) NOT NULL,
  'page_id' int(11) DEFAULT NULL,
  'created_at' datetime NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'url' ('url'),
  KEY 'core_clickurl_page_id' ('page_id'),
  KEY 'core_clickurl_created_at' ('created_at'),
  CONSTRAINT 'page_id_refs_id_b0bad55b' FOREIGN KEY ('page_id') REFERENCES 'core_page' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=40587 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_click' (
  'id' bigint(20) NOT NULL AUTO_INCREMENT,
  'clickurl_id' int(11) NOT NULL,
  'user_id' int(11) DEFAULT NULL,
  'mailing_id' int(11) DEFAULT NULL,
  'link_number' int(11) DEFAULT NULL,
  'source' varchar(255) DEFAULT NULL,
  'referring_user_id' int(11) DEFAULT NULL,
  'created_at' timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  'useragent_id' int(11) DEFAULT NULL,
  PRIMARY KEY ('id'),
  KEY 'user_id' ('user_id'),
  KEY 'source' ('source'),
  KEY 'clickurl_id' ('clickurl_id'),
  KEY 'mailing_id' ('mailing_id','user_id')
) ENGINE=InnoDB AUTO_INCREMENT=171299139 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_open' (
  'id' bigint(20) NOT NULL AUTO_INCREMENT,
  'user_id' int(11) DEFAULT NULL,
  'mailing_id' int(11) DEFAULT NULL,
  'created_at' timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  'useragent_id' int(11) DEFAULT NULL,
  PRIMARY KEY ('id'),
  KEY 'user_id' ('user_id'),
  KEY 'mailing_id' ('mailing_id','user_id')
) ENGINE=InnoDB AUTO_INCREMENT=395498632 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'share_type' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'type' varchar(2) NOT NULL,
  'name' varchar(255) NOT NULL,
  PRIMARY KEY ('id')
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'share_link' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'page_id' int(11) NOT NULL,
  'type' varchar(2) NOT NULL,
  'user_id' int(11) DEFAULT NULL,
  'action_id' int(11) DEFAULT NULL,
  'referring_share_id' int(11) DEFAULT NULL,
  'generation' smallint(5) unsigned NOT NULL,
  'source' varchar(255) DEFAULT NULL,
  PRIMARY KEY ('id'),
  KEY 'user_id_refs_id_352dbc71' ('user_id'),
  KEY 'action_id_refs_id_88e44a67' ('action_id'),
  KEY 'page_id_refs_id_351f874c' ('page_id'),
  KEY 'referring_share_id_refs_id_b0324051' ('referring_share_id'),
  KEY 'share_link_a34b03a6' ('source'),
  CONSTRAINT 'action_id_refs_id_88e44a67' FOREIGN KEY ('action_id') REFERENCES 'core_action' ('id'),
  CONSTRAINT 'page_id_refs_id_351f874c' FOREIGN KEY ('page_id') REFERENCES 'core_page' ('id'),
  CONSTRAINT 'referring_share_id_refs_id_b0324051' FOREIGN KEY ('referring_share_id') REFERENCES 'share_link' ('id'),
  CONSTRAINT 'user_id_refs_id_352dbc71' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=296003 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'share_action' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'share_id' int(11) NOT NULL,
  'action_id' int(11) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'action_id' ('action_id'),
  KEY 'share_id_refs_id_d20fca85' ('share_id'),
  CONSTRAINT 'action_id_refs_id_af3be0a3' FOREIGN KEY ('action_id') REFERENCES 'core_action' ('id'),
  CONSTRAINT 'share_id_refs_id_d20fca85' FOREIGN KEY ('share_id') REFERENCES 'share_link' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=108852 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4'
'CREATE TABLE 'share_click' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'share_id' int(11) NOT NULL,
  'page_id' int(11) NOT NULL,
  PRIMARY KEY ('id'),
  KEY 'page_id_refs_id_115a3143' ('page_id'),
  KEY 'share_id_refs_id_8424b28c' ('share_id'),
  CONSTRAINT 'page_id_refs_id_115a3143' FOREIGN KEY ('page_id') REFERENCES 'core_page' ('id'),
  CONSTRAINT 'share_id_refs_id_8424b28c' FOREIGN KEY ('share_id') REFERENCES 'share_link' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=521097 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_transaction' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'type' varchar(255) NOT NULL,
  'order_id' int(11) NOT NULL,
  'account' varchar(255) NOT NULL,
  'test_mode' tinyint(1) NOT NULL,
  'amount' decimal(10,2) NOT NULL,
  'amount_converted' decimal(10,2) NOT NULL DEFAULT ''0.00'',
  'success' tinyint(1) NOT NULL,
  'status' varchar(255) NOT NULL,
  'trans_id' varchar(255) DEFAULT NULL,
  'failure_description' text,
  'failure_code' varchar(255) DEFAULT NULL,
  'failure_message' text,
  'currency' varchar(3) NOT NULL DEFAULT ''USD'',
  PRIMARY KEY ('id'),
  KEY 'core_transaction_created_at' ('created_at'),
  KEY 'core_transaction_type' ('type'),
  KEY 'core_transaction_order_id' ('order_id'),
  KEY 'trans_id' ('trans_id'),
  CONSTRAINT '_order_id_refs_id_608f85db' FOREIGN KEY ('order_id') REFERENCES 'core_order' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=1393604 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_orderrecurring' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'order_id' int(11) NOT NULL,
  'action_id' int(11) NOT NULL,
  'exp_date' varchar(6) NOT NULL,
  'card_num' varchar(4) NOT NULL,
  'recurring_id' varchar(255) DEFAULT NULL,
  'account' varchar(255) DEFAULT NULL,
  'user_id' int(11) NOT NULL,
  'start' date NOT NULL,
  'occurrences' int(11) DEFAULT NULL,
  'period' varchar(255) NOT NULL,
  'amount' decimal(10,2) NOT NULL,
  'currency' varchar(3) NOT NULL DEFAULT ''USD'',
  'amount_converted' decimal(10,2) NOT NULL DEFAULT ''0.00'',
  'status' varchar(255) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'action_id' ('action_id'),
  KEY 'core_orderrecurring_created_at' ('created_at'),
  KEY 'core_orderrecurring_order_id' ('order_id'),
  KEY 'core_orderrecurring_action_id' ('action_id'),
  KEY 'core_orderrecurring_user_id' ('user_id'),
  CONSTRAINT '_action_id_refs_id_6db2c7d6' FOREIGN KEY ('action_id') REFERENCES 'core_action' ('id'),
  CONSTRAINT '_order_id_refs_id_224a8d75' FOREIGN KEY ('order_id') REFERENCES 'core_order' ('id'),
  CONSTRAINT '_user_id_refs_id_d3407ff3' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=21656 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_order' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'action_id' int(11) NOT NULL,
  'user_id' int(11) NOT NULL,
  'user_detail_id' int(11) NOT NULL,
  'card_num_last_four' varchar(4) NOT NULL,
  'shipping_address_id' int(11) DEFAULT NULL,
  'total' decimal(10,2) NOT NULL,
  'currency' varchar(3) NOT NULL DEFAULT ''USD'',
  'total_converted' decimal(10,2) NOT NULL DEFAULT ''0.00'',
  'status' varchar(255) NOT NULL,
  'import_id' varchar(32) DEFAULT NULL,
  'account' varchar(255) DEFAULT NULL,
  'payment_method' varchar(255) NOT NULL DEFAULT ''cc'',
  PRIMARY KEY ('id'),
  UNIQUE KEY 'action_id' ('action_id'),
  KEY 'core_order_created_at' ('created_at'),
  KEY 'core_order_action_id' ('action_id'),
  KEY 'core_order_user_id' ('user_id'),
  KEY 'core_order_user_detail_id' ('user_detail_id'),
  KEY 'core_order_shipping_address_id' ('shipping_address_id'),
  KEY 'core_order_import_id' ('import_id'),
  CONSTRAINT '__action_id_refs_id_e0e2ebda' FOREIGN KEY ('action_id') REFERENCES 'core_action' ('id'),
  CONSTRAINT '__shipping_address_id_refs_id_317e5300' FOREIGN KEY ('shipping_address_id') REFERENCES 'core_order_shipping_address' ('id'),
  CONSTRAINT '__user_detail_id_refs_id_4544afd3' FOREIGN KEY ('user_detail_id') REFERENCES 'core_order_user_detail' ('id'),
  CONSTRAINT '__user_id_refs_id_1f20a669' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=1117315 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4'
'CREATE TABLE 'core_mailing_tags' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'mailing_id' int(11) NOT NULL,
  'tag_id' int(11) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'mailing_id' ('mailing_id','tag_id'),
  KEY 'tag_id_refs_id_ed55dd35' ('tag_id'),
  CONSTRAINT 'mailing_id_refs_id_adcf60c2' FOREIGN KEY ('mailing_id') REFERENCES 'core_mailing' ('id'),
  CONSTRAINT 'tag_id_refs_id_ed55dd35' FOREIGN KEY ('tag_id') REFERENCES 'core_tag' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=609808 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_tag' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'hidden' tinyint(1) NOT NULL,
  'name' varchar(255) NOT NULL,
  'times_used' int(11) DEFAULT NULL,
  'order_index' int(11) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'name' ('name'),
  KEY 'core_tag_created_at' ('created_at'),
  KEY 'core_tag_hidden' ('hidden')
) ENGINE=InnoDB AUTO_INCREMENT=1880 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_page_tags' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'page_id' int(11) NOT NULL,
  'tag_id' int(11) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'page_id' ('page_id','tag_id'),
  KEY 'tag_id_refs_id_2035a68a' ('tag_id'),
  CONSTRAINT 'page_id_refs_id_9f0ba122' FOREIGN KEY ('page_id') REFERENCES 'core_page' ('id'),
  CONSTRAINT 'tag_id_refs_id_2035a68a' FOREIGN KEY ('tag_id') REFERENCES 'core_tag' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=89573 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_page' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'hidden' tinyint(1) NOT NULL,
  'title' varchar(255) NOT NULL,
  'name' varchar(255) NOT NULL,
  'notes' varchar(255) DEFAULT '''',
  'hosted_with_id' int(11) NOT NULL,
  'url' varchar(255) NOT NULL,
  'type' varchar(255) NOT NULL,
  'lang_id' int(11) DEFAULT NULL,
  'multilingual_campaign_id' int(11) DEFAULT NULL,
  'goal' int(11) DEFAULT NULL,
  'goal_type' varchar(255) NOT NULL,
  'status' varchar(255) NOT NULL,
  'list_id' int(11) NOT NULL,
  'allow_multiple_responses' tinyint(1) NOT NULL DEFAULT ''1'',
  'recognize' varchar(255) NOT NULL DEFAULT ''once'',
  'never_spam_check' tinyint(1) NOT NULL DEFAULT ''0'',
  'real_actions' tinyint(1) NOT NULL DEFAULT ''1'',
  PRIMARY KEY ('id'),
  UNIQUE KEY 'name' ('name'),
  KEY 'core_page_created_at' ('created_at'),
  KEY 'core_page_hidden' ('hidden'),
  KEY 'core_page_title' ('title'),
  KEY 'core_page_hosted_with_id' ('hosted_with_id'),
  KEY 'core_page_type' ('type'),
  KEY 'core_page_lang_id' ('lang_id'),
  KEY 'core_page_multilingual_campaign_id' ('multilingual_campaign_id'),
  KEY 'core_page_status' ('status'),
  KEY 'core_page_list_id' ('list_id'),
  CONSTRAINT 'hosted_with_id_refs_id_8224ab4e' FOREIGN KEY ('hosted_with_id') REFERENCES 'core_hostingplatform' ('id'),
  CONSTRAINT 'lang_id_refs_id_aa0dd4f6' FOREIGN KEY ('lang_id') REFERENCES 'core_language' ('id'),
  CONSTRAINT 'list_id_refs_id_e086b270' FOREIGN KEY ('list_id') REFERENCES 'core_list' ('id'),
  CONSTRAINT 'multilingual_campaign_id_refs_id_25ce6765' FOREIGN KEY ('multilingual_campaign_id') REFERENCES 'core_multilingualcampaign' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=17607 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4'
'CREATE TABLE 'core_subscriptionhistory' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'user_id' int(11) NOT NULL,
  'list_id' int(11) NOT NULL,
  'change_id' int(11) NOT NULL,
  'action_id' int(11) DEFAULT NULL,
  PRIMARY KEY ('id'),
  KEY 'core_subscriptionhistory_created_at' ('created_at'),
  KEY 'core_subscriptionhistory_user_id' ('user_id'),
  KEY 'core_subscriptionhistory_list_id' ('list_id'),
  KEY 'core_subscriptionhistory_change_id' ('change_id'),
  KEY 'core_subscriptionhistory_action_id' ('action_id'),
  CONSTRAINT 'action_id_refs_id_b4f5a5bf' FOREIGN KEY ('action_id') REFERENCES 'core_action' ('id'),
  CONSTRAINT 'change_id_refs_id_f742e336' FOREIGN KEY ('change_id') REFERENCES 'core_subscriptionchangetype' ('id'),
  CONSTRAINT 'list_id_refs_id_2faa94bd' FOREIGN KEY ('list_id') REFERENCES 'core_list' ('id'),
  CONSTRAINT 'user_id_refs_id_ca8ad15e' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=30086617 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4


CREATE TABLE 'core_list' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'hidden' tinyint(1) NOT NULL,
  'name' varchar(255) NOT NULL,
  'notes' varchar(255) DEFAULT '''',
  'is_default' tinyint(1) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'name' ('name'),
  KEY 'core_list_created_at' ('created_at'),
  KEY 'core_list_hidden' ('hidden')
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4'
'CREATE TABLE 'core_subscription' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'user_id' int(11) NOT NULL,
  'list_id' int(11) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'user_id' ('user_id','list_id'),
  KEY 'core_subscription_created_at' ('created_at'),
  KEY 'core_subscription_user_id' ('user_id'),
  KEY 'core_subscription_list_id' ('list_id'),
  CONSTRAINT 'list_id_refs_id_b43b380e' FOREIGN KEY ('list_id') REFERENCES 'core_list' ('id'),
  CONSTRAINT 'user_id_refs_id_f56a2747' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=17017325 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4



CREATE TABLE 'core_phone' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'user_id' int(11) NOT NULL,
  'type' varchar(25) NOT NULL,
  'phone' varchar(25) NOT NULL,
  'source' varchar(25) NOT NULL,
  'normalized_phone' varchar(25) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'user_id' ('user_id','type','source'),
  KEY 'core_phone_created_at' ('created_at'),
  KEY 'core_phone_user_id' ('user_id'),
  KEY 'i_normalized' ('normalized_phone'),
  CONSTRAINT 'user_id_refs_id_1504b023' FOREIGN KEY ('user_id') REFERENCES 'core_user' ('id')
) ENGINE=InnoDB AUTO_INCREMENT=36149 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPRESSED KEY_BLOCK_SIZE=4



CREATE TABLE 'core_useragent' (
  'id' int(11) NOT NULL AUTO_INCREMENT,
  'created_at' datetime NOT NULL,
  'updated_at' datetime NOT NULL,
  'useragent_string' longtext NOT NULL,
  'hash' varchar(64) NOT NULL,
  'browser' varchar(255) NOT NULL,
  'browser_version' varchar(30) NOT NULL,
  'os' varchar(255) NOT NULL,
  'os_version' varchar(30) NOT NULL,
  'device' varchar(255) NOT NULL,
  'is_mobile' tinyint(1) NOT NULL,
  'is_phone' tinyint(1) NOT NULL,
  'is_tablet' tinyint(1) NOT NULL,
  'is_desktop' tinyint(1) NOT NULL,
  PRIMARY KEY ('id'),
  UNIQUE KEY 'core_useragent_a48079cd' ('hash'),
  KEY 'core_useragent_96511a37' ('created_at'),
  KEY 'core_useragent_8426a026' ('is_mobile'),
  KEY 'core_useragent_c5e431e7' ('is_phone'),
  KEY 'core_useragent_f33ac720' ('is_tablet'),
  KEY 'core_useragent_e54eac1c' ('is_desktop')
) ENGINE=InnoDB AUTO_INCREMENT=95071 DEFAULT CHARSET=utf8