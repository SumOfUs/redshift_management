CREATE TABLE ak_sumofus.new_core_user(
  id integer NOT NULL,
  created_at datetime NOT NULL,
  updated_at datetime NOT NULL,
  email varchar(765) NOT NULL,
  prefix  varchar(765), 
  first_name varchar(765) NOT NULL,
  middle_name varchar(765) NOT NULL DEFAULT '',
  last_name varchar(765) NOT NULL,
  suffix varchar(765), 
  password varchar(765),
  subscription_status varchar(765) NOT NULL,
  address1 varchar(765) NOT NULL,
  address2 varchar(765) NOT NULL,
  city varchar(765) NOT NULL,
  state varchar(765) NOT NULL,
  region varchar(765) NOT NULL,
  postal varchar(765) NOT NULL,
  zip varchar(15) NOT NULL,
  plus4 varchar(12),
  country varchar(765) NOT NULL,
  source varchar(765) NOT NULL,
  lang_id integer DEFAULT NULL,
  rand_id integer NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(email)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id, email,created_at,country,lang_id,subscription_status);

INSERT INTO new_core_user (SELECT * FROM core_user);

ALTER TABLE core_user RENAME TO old_core_user;
ALTER TABLE new_core_user RENAME TO core_user;

###################

CREATE TABLE ak_sumofus.new_core_list(
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 hidden SMALLINT NOT NULL,
 name VARCHAR(765) NOT NULL,
 notes VARCHAR(765),
 is_default SMALLINT NOT NULL,
 PRIMARY KEY(id),
 UNIQUE (name)
)
DISTKEY(id)
SORTKEY(id);

INSERT INTO new_core_list (SELECT * FROM core_list);

ALTER TABLE core_list RENAME TO old_core_list;
ALTER TABLE new_core_list RENAME TO core_list;

-- schemaname  tablename column  type  encoding  distkey sortkey notnull
-- ak_sumofus  core_list id  integer none  true  1 true
-- ak_sumofus  core_list created_at  timestamp without time zone none  false 0 false
-- ak_sumofus  core_list updated_at  timestamp without time zone none  false 0 false
-- ak_sumofus  core_list hidden  smallint  none  false 0 false
-- ak_sumofus  core_list name  character varying(765)  none  false 0 false
-- ak_sumofus  core_list notes character varying(765)  none  false 0 false
-- ak_sumofus  core_list is_default  smallint  none  false 0 false


CREATE TABLE ak_sumofus.new_core_page (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 hidden SMALLINT NOT NULL,
 title VARCHAR(765) NOT NULL,
 name VARCHAR(765) NOT NULL,
 notes VARCHAR(765) DEFAULT '''',
 hosted_with_id INTEGER NOT NULL,
 url VARCHAR(765) NOT NULL,
 type VARCHAR(765) NOT NULL,
 lang_id INTEGER DEFAULT NULL,
 multilingual_campaign_id INTEGER DEFAULT NULL,
 goal INTEGER,
 goal_type VARCHAR(765),
 status VARCHAR(765) NOT NULL,
 list_id INTEGER NOT NULL,
 allow_multiple_responses SMALLINT NOT NULL,
 recognize VARCHAR(765) NOT NULL,
 never_spam_check SMALLINT,
 real_actions SMALLINT NOT NULL,
PRIMARY KEY (id),
UNIQUE(name),
FOREIGN KEY(list_id) REFERENCES core_list(id)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,created_at, lang_id, type, title);

INSERT INTO new_core_page (SELECT * FROM core_page);

ALTER TABLE core_page RENAME TO old_core_page;
ALTER TABLE new_core_page RENAME TO core_page;

-- schemaname  tablename column  type  encoding  distkey sortkey notnull
-- ak_sumofus  core_page id  integer delta true  1 true
-- ak_sumofus  core_page created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_page updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_page hidden  smallint  none  false 0 false
-- ak_sumofus  core_page title character varying(765)  lzo false 0 false
-- ak_sumofus  core_page name  character varying(765)  lzo false 0 false
-- ak_sumofus  core_page notes character varying(765)  lzo false 0 false
-- ak_sumofus  core_page hosted_with_id  integer lzo false 0 false
-- ak_sumofus  core_page url character varying(765)  lzo false 0 false
-- ak_sumofus  core_page type  character varying(765)  lzo false 0 false
-- ak_sumofus  core_page lang_id integer lzo false 0 false
-- ak_sumofus  core_page multilingual_campaign_id  integer none  false 0 false
-- ak_sumofus  core_page goal  integer none  false 0 false
-- ak_sumofus  core_page goal_type character varying(765)  lzo false 0 false
-- ak_sumofus  core_page status  character varying(765)  lzo false 0 false
-- ak_sumofus  core_page list_id integer lzo false 0 false
-- ak_sumofus  core_page allow_multiple_responses  smallint  none  false 0 false
-- ak_sumofus  core_page recognize character varying(765)  lzo false 0 false
-- ak_sumofus  core_page never_spam_check  smallint  none  false 0 false
-- ak_sumofus  core_page real_actions  smallint  none  false 0 false


CREATE TABLE ak_sumofus.new_core_userfield(
  id INTEGER NOT NULL,
  parent_id INTEGER NOT NULL,
  name VARCHAR(765) NOT NULL DEFAULT '',
  value VARCHAR(MAX) NOT NULL DEFAULT '',
  PRIMARY KEY(id),
  FOREIGN KEY(parent_id) REFERENCES core_user(id)
)
DISTKEY(parent_id)
COMPOUND SORTKEY(name, value, parent_id, id);

INSERT INTO new_core_userfield (SELECT * FROM core_userfield);

ALTER TABLE core_userfield RENAME TO old_core_userfield;
ALTER TABLE new_core_userfield RENAME TO core_userfield;


-- schemaname  tablename column  type  encoding  distkey sortkey notnull
-- ak_sumofus  core_userfield  id  integer delta true  1 true
-- ak_sumofus  core_userfield  parent_id integer delta false 0 false
-- ak_sumofus  core_userfield  name  character varying(765)  lzo false 0 false
-- ak_sumofus  core_userfield  value character varying(65535)  lzo false 0 false


CREATE TABLE ak_sumofus.new_core_location(
  Created_at TIMESTAMP NOT NULL,
  Updated_at TIMESTAMP NOT NULL,
  User_id INTEGER NOT NULL,
  Us_district VARCHAR(15) NOT NULL,
  Us_state_senate VARCHAR(18) NOT NULL,
  us_state_district varchar(18) NOT NULL,
  us_county varchar(765) NOT NULL,
  loc_code varchar(90) NOT NULL,
  country_code varchar(6) NOT NULL,
  region_code varchar(60) NOT NULL,
  longitude FLOAT DEFAULT NULL, # double precision bytedict
  latitude FLOAT DEFAULT NULL, # double precision bytedict
  lat_lon_precision varchar(96) NOT NULL,
 PRIMARY KEY(user_id),
 FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(user_id,us_district,loc_code);

INSERT INTO new_core_location (SELECT * FROM core_location);

ALTER TABLE core_location RENAME TO old_core_location;
ALTER TABLE new_core_location RENAME TO core_location;

-- schemaname  tablename column  type  encoding  distkey sortkey notnull
-- ak_sumofus  core_location created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_location updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_location user_id integer delta true  1 true
-- ak_sumofus  core_location us_district character varying(15) lzo false 0 false
-- ak_sumofus  core_location us_state_senate character varying(18) lzo false 0 false
-- ak_sumofus  core_location us_state_district character varying(18) lzo false 0 false
-- ak_sumofus  core_location us_county character varying(765)  lzo false 0 false
-- ak_sumofus  core_location loc_code  character varying(90) lzo false 0 false
-- ak_sumofus  core_location country_code  character varying(6)  lzo false 0 false
-- ak_sumofus  core_location region_code character varying(60) lzo false 0 false
-- ak_sumofus  core_location longitude double precision  bytedict  false 0 false
-- ak_sumofus  core_location latitude  double precision  bytedict  false 0 false
-- ak_sumofus  core_location lat_lon_precision character varying(96) lzo false 0 false


# SKIP THIS MONSTER? - ton of columns with weird data types, two columns names are reserved words...

CREATE TABLE ak_sumofus.new_core_mailing (
  id INTEGER NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  hidden SMALLINT NOT NULL,
  fromline_id INTEGER,
  custom_fromline VARCHAR(765),
  reply_to VARCHAR(765),
  notes VARCHAR(765),
  html VARCHAR(MAX),
  text VARCHAR(MAX), # RESERVED WORD
  lang_id INTEGER DEFAULT NULL,
  emailwrapper_id INTEGER,
  web_viewable SMALLINT,
  landing_page_id INTEGER DEFAULT NULL,
  target_group_from_landing_page SMALLINT,
  winning_subject_id  INTEGER,
  requested_proofs  INTEGER,
  submitter_id  INTEGER,
  scheduled_for DATETIME,
  scheduled_by_id INTEGER,
  queue_task_id VARCHAR(765),
  queued_at TIMESTAMP,
  queued_by_id  INTEGER,
  expected_send_count INTEGER DEFAULT NULL,
  started_at DATETIME DEFAULT NULL,
  finished_at TIMESTAMP,
  query_queued_at TIMESTAMP,
  query_started_at  TIMESTAMP,
  query_completed_at  TIMESTAMP,
  query_previous_runtime  INTEGER, #integer bytedict  false 0 false
  query_status  VARCHAR(765),
  query_task_id VARCHAR(765),
  targeting_version INTEGER,
  targeting_version_saved INTEGER,
  rate DOUBLE PRECISION,# double precision  none  false 0 false
  progress INTEGER DEFAULT NULL,
  status VARCHAR(765) DEFAULT NULL,
  includes_id INTEGER,
  excludes_id INTEGER,
  limit INTEGER, # RESERVED WORD
  sort_by VARCHAR(96) DEFAULT NULL,
  pid INTEGER,
  sent_proofs INTEGER,
  rebuild_query_at_send SMALLINT,
  limit_percent INTEGER,
  mergefile_id  INTEGER,
  target_mergefile  SMALLINT,
  mails_per_second  DOUBLE PRECISION,
  recurring_schedule_id INTEGER DEFAULT NULL,
  recurring_source_mailing_id INTEGER DEFAULT NULL,
  requested_proof_date DATETIME,
  send_date VARCHAR(765) NOT NULL,
  exclude_ordering INTEGER,
  test_group_id INTEGER DEFAULT NULL,
  test_remainder  INTEGER,
  mergequery_report_id  INTEGER,
  target_mergequery SMALLINT,
  version SMALLINT,
  PRIMARY KEY(id),
  FOREIGN KEY (landing_page_id) REFERENCES core_page(id),
  FOREIGN KEY (recurring_source_mailing_id) REFERENCES core_mailing(id) 
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,started_at,recurring_schedule_id);


INSERT INTO new_core_mailing (SELECT * FROM core_mailing);

ALTER TABLE core_mailing RENAME TO old_core_mailing;
ALTER TABLE new_core_mailing RENAME TO core_mailing;

-- schemaname  tablename column  type  encoding  distkey sortkey notnull
-- ak_sumofus  core_mailing  id  integer delta true  1 true
-- ak_sumofus  core_mailing  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  hidden  smallint  none  false 0 false
-- ak_sumofus  core_mailing  fromline_id integer delta false 0 false
-- ak_sumofus  core_mailing  custom_fromline character varying(765)  lzo false 0 false
-- ak_sumofus  core_mailing  reply_to  character varying(765)  lzo false 0 false
-- ak_sumofus  core_mailing  notes character varying(765)  lzo false 0 false
-- ak_sumofus  core_mailing  html  character varying(65535)  lzo false 0 false
-- ak_sumofus  core_mailing  text  character varying(65535)  lzo false 0 false
-- ak_sumofus  core_mailing  lang_id integer lzo false 0 false
-- ak_sumofus  core_mailing  emailwrapper_id integer delta false 0 false
-- ak_sumofus  core_mailing  web_viewable  smallint  none  false 0 false
-- ak_sumofus  core_mailing  landing_page_id integer none  false 0 false
-- ak_sumofus  core_mailing  target_group_from_landing_page  smallint  none  false 0 false
-- ak_sumofus  core_mailing  winning_subject_id  integer none  false 0 false
-- ak_sumofus  core_mailing  requested_proofs  integer lzo false 0 false
-- ak_sumofus  core_mailing  submitter_id  integer none  false 0 false
-- ak_sumofus  core_mailing  scheduled_for timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  scheduled_by_id integer delta false 0 false
-- ak_sumofus  core_mailing  queue_task_id character varying(765)  lzo false 0 false
-- ak_sumofus  core_mailing  queued_at timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  queued_by_id  integer delta false 0 false
-- ak_sumofus  core_mailing  expected_send_count integer lzo false 0 false
-- ak_sumofus  core_mailing  started_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  finished_at timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  query_queued_at timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  query_started_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  query_completed_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_mailing  query_previous_runtime  integer bytedict  false 0 false
-- ak_sumofus  core_mailing  query_status  character varying(765)  lzo false 0 false
-- ak_sumofus  core_mailing  query_task_id character varying(765)  lzo false 0 false
-- ak_sumofus  core_mailing  targeting_version integer delta false 0 false
-- ak_sumofus  core_mailing  targeting_version_saved integer delta false 0 false
-- ak_sumofus  core_mailing  rate  double precision  none  false 0 false
-- ak_sumofus  core_mailing  progress  integer mostly16  false 0 false
-- ak_sumofus  core_mailing  status  character varying(765)  lzo false 0 false
-- ak_sumofus  core_mailing  includes_id integer delta false 0 false
-- ak_sumofus  core_mailing  excludes_id integer delta false 0 false
-- ak_sumofus  core_mailing  limit integer none  false 0 false
-- ak_sumofus  core_mailing  sort_by character varying(96) lzo false 0 false
-- ak_sumofus  core_mailing  pid integer none  false 0 false
-- ak_sumofus  core_mailing  sent_proofs integer lzo false 0 false
-- ak_sumofus  core_mailing  rebuild_query_at_send smallint  none  false 0 false
-- ak_sumofus  core_mailing  limit_percent integer none  false 0 false
-- ak_sumofus  core_mailing  mergefile_id  integer none  false 0 false
-- ak_sumofus  core_mailing  target_mergefile  smallint  none  false 0 false
-- ak_sumofus  core_mailing  mails_per_second  double precision  none  false 0 false
-- ak_sumofus  core_mailing  recurring_schedule_id integer none  false 0 false
-- ak_sumofus  core_mailing  recurring_source_mailing_id integer none  false 0 false
-- ak_sumofus  core_mailing  requested_proof_date  timestamp without time zone none  false 0 false
-- ak_sumofus  core_mailing  send_date character varying(765)  lzo false 0 false
-- ak_sumofus  core_mailing  exclude_ordering  integer none  false 0 false
-- ak_sumofus  core_mailing  test_group_id integer none  false 0 false
-- ak_sumofus  core_mailing  test_remainder  integer none  false 0 false
-- ak_sumofus  core_mailing  mergequery_report_id  integer none  false 0 false
-- ak_sumofus  core_mailing  target_mergequery smallint  none  false 0 false
-- ak_sumofus  core_mailing  version smallint  none  false 0 false


####################




CREATE TABLE ak_sumofus.new_core_action(
  id INTEGER NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  user_id INTEGER NOT NULL,
  mailing_id INTEGER DEFAULT NULL,
  page_id INTEGER NOT NULL,
  link INTEGER,
  source VARCHAR(765) NOT NULL,
  opq_id VARCHAR(765) NOT NULL,
  created_user SMALLINT NOT NULL,
  subscribed_user SMALLINT NOT NULL,
  referring_user_id INTEGER DEFAULT NULL,
  referring_mailing_id INTEGER DEFAULT NULL,
  taf_emails_sent INTEGER DEFAULT NULL,
  status VARCHAR(765) NOT NULL,
  is_forwarded SMALLINT NOT NULL DEFAULT 0,
  ip_address VARCHAR(45),
  PRIMARY KEY(id),
  FOREIGN KEY(mailing_id) REFERENCES core_mailing(id),
  FOREIGN KEY(page_id) REFERENCES core_page(id),
  FOREIGN KEY(referring_mailing_id) REFERENCES core_mailing(id),
  FOREIGN KEY(referring_user_id) REFERENCES core_user(id),
  FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,created_at,user_id,page_id,mailing_id, created_user,source);

INSERT INTO new_core_action (SELECT * FROM core_action);

ALTER TABLE core_action RENAME TO old_core_action;
ALTER TABLE new_core_action RENAME TO core_action;



# DROP RENAMED OLD TABLES
DROP TABLE old_core_user;
DROP TABLE old_core_list;
DROP TABLE old_core_page;
DROP TABLE old_core_userfield;
DROP TABLE old_core_location;
DROP TABLE old_core_mailing;



DROP TABLE old_core_action;
