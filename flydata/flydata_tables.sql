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
  longitude FLOAT DEFAULT NULL,
  latitude FLOAT DEFAULT NULL,
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


CREATE TABLE ak_sumofus.new_core_mailing(
  "id" INTEGER NOT NULL,
  "created_at" DATETIME NOT NULL,
  "updated_at" DATETIME NOT NULL,
  "hidden" SMALLINT NOT NULL,
  "fromline_id" INTEGER,
  "custom_fromline" VARCHAR(765),
  "reply_to" VARCHAR(765),
  "notes" VARCHAR(765),
  "html" VARCHAR(MAX),
  "text" VARCHAR(MAX),
  "lang_id" INTEGER DEFAULT NULL,
  "emailwrapper_id" INTEGER,
  "web_viewable" SMALLINT,
  "landing_page_id" INTEGER DEFAULT NULL,
  "target_group_from_landing_page" SMALLINT,
  "winning_subject_id"  INTEGER,
  "requested_proofs"  INTEGER,
  "submitter_id"  INTEGER,
  "scheduled_for" DATETIME,
  "scheduled_by_id" INTEGER,
  "queue_task_id" VARCHAR(765),
  "queued_at" TIMESTAMP,
  "queued_by_id"  INTEGER,
  "expected_send_count" INTEGER DEFAULT NULL,
  "started_at" DATETIME DEFAULT NULL,
  "finished_at" TIMESTAMP,
  "query_queued_at" TIMESTAMP,
  "query_started_at"  TIMESTAMP,
  "query_completed_at"  TIMESTAMP,
  "query_previous_runtime"  INTEGER,
  "query_status"  VARCHAR(765),
  "query_task_id" VARCHAR(765),
  "targeting_version" INTEGER,
  "targeting_version_saved" INTEGER,
  "rate" FLOAT,
  "progress" INTEGER DEFAULT NULL,
  "status" VARCHAR(765) DEFAULT NULL,
  "includes_id" INTEGER,
  "excludes_id" INTEGER,
  "limit" INTEGER,
  "sort_by" VARCHAR(96) DEFAULT NULL,
  "pid" INTEGER,
  "sent_proofs" INTEGER,
  "rebuild_query_at_send" SMALLINT,
  "limit_percent" INTEGER,
  "mergefile_id"  INTEGER,
  "target_mergefile" SMALLINT,
  "mails_per_second" FLOAT,
  "recurring_schedule_id" INTEGER DEFAULT NULL,
  "recurring_source_mailing_id" INTEGER DEFAULT NULL,
  "requested_proof_date" DATETIME,
  "send_date" VARCHAR(765) NOT NULL,
  "exclude_ordering" INTEGER,
  "test_group_id" INTEGER DEFAULT NULL,
  "test_remainder"  INTEGER,
  "mergequery_report_id"  INTEGER,
  "target_mergequery" SMALLINT,
  "version" SMALLINT,
  PRIMARY KEY("id"),
  FOREIGN KEY ("landing_page_id") REFERENCES core_page("id"),
  FOREIGN KEY ("recurring_source_mailing_id") REFERENCES core_mailing("id") 
)
DISTKEY("id")
INTERLEAVED SORTKEY("id","started_at","recurring_schedule_id");

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


CREATE TABLE ak_sumofus.new_core_actionfield(
  id INTEGER NOT NULL,
  parent_id INTEGER NOT NULL,
  name VARCHAR(765) NOT NULL DEFAULT '',
  value VARCHAR(MAX) NOT NULL DEFAULT '',
  PRIMARY KEY(id),
  FOREIGN KEY(parent_id) REFERENCES core_action(id)
)
DISTKEY(parent_id)
COMPOUND SORTKEY(name, value, id);

ALTER TABLE core_actionfield RENAME TO old_core_actionfield;

INSERT INTO new_core_actionfield (SELECT * FROM old_core_actionfield);
ALTER TABLE new_core_actionfield RENAME TO core_actionfield;


-- ak_sumofus  core_actionfield  id  integer delta true  1 true
-- ak_sumofus  core_actionfield  parent_id integer delta false 0 false
-- ak_sumofus  core_actionfield  name  character varying(765)  lzo false 0 false
-- ak_sumofus  core_actionfield  value character varying(65535)  lzo false 0 false



CREATE TABLE ak_sumofus.new_core_clickurl (
  id INTEGER NOT NULL,
  url VARCHAR(765) NOT NULL,
  page_id INTEGER DEFAULT NULL,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (url),
  FOREIGN KEY (page_id) REFERENCES core_page(id)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,page_id,url);

ALTER TABLE core_clickurl RENAME TO old_core_clickurl;
INSERT INTO new_core_clickurl (SELECT * FROM old_core_clickurl);
ALTER TABLE new_core_clickurl RENAME TO core_clickurl;

-- ak_sumofus  core_clickurl id  integer delta true  1 true
-- ak_sumofus  core_clickurl url character varying(765)  lzo false 0 false
-- ak_sumofus  core_clickurl page_id integer delta false 0 false
-- ak_sumofus  core_clickurl created_at  timestamp without time zone lzo false 0 false


CREATE TABLE ak_sumofus.new_core_useragent(
  id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  useragent_string VARCHAR(MAX) NOT NULL DEFAULT '',
  hash VARCHAR(192) NOT NULL,
  browser VARCHAR(765) NOT NULL,
  browser_version VARCHAR(90),
  os VARCHAR(765) NOT NULL,
  os_version VARCHAR(90) NOT NULL,
  device VARCHAR(765) NOT NULL,
  is_mobile SMALLINT NOT NULL,
  is_phone SMALLINT NOT NULL,
  is_tablet SMALLINT NOT NULL,
  is_desktop SMALLINT NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(hash)
)
DISTKEY(id)
INTERLEAVED SORTKEY(is_mobile,is_phone,is_tablet,is_desktop,browser,device);

ALTER TABLE core_useragent RENAME TO old_core_useragent;

INSERT INTO new_core_useragent (SELECT * FROM old_core_useragent);

ALTER TABLE new_core_useragent RENAME TO core_useragent;

-- ak_sumofus  core_useragent  id  integer delta true  1 true
-- ak_sumofus  core_useragent  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_useragent  updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_useragent  useragent_string  character varying(65535)  lzo false 0 false
-- ak_sumofus  core_useragent  hash  character varying(192)  lzo false 0 false
-- ak_sumofus  core_useragent  browser character varying(765)  lzo false 0 false
-- ak_sumofus  core_useragent  browser_version character varying(90) lzo false 0 false
-- ak_sumofus  core_useragent  os  character varying(765)  lzo false 0 false
-- ak_sumofus  core_useragent  os_version  character varying(90) lzo false 0 false
-- ak_sumofus  core_useragent  device  character varying(765)  lzo false 0 false
-- ak_sumofus  core_useragent  is_mobile smallint  lzo false 0 false
-- ak_sumofus  core_useragent  is_phone  smallint  lzo false 0 false
-- ak_sumofus  core_useragent  is_tablet smallint  lzo false 0 false
-- ak_sumofus  core_useragent  is_desktop  smallint  lzo false 0 false


CREATE TABLE ak_sumofus.new_core_click (
  id BIGINT NOT NULL,
  clickurl_id INTEGER NOT NULL,
  user_id INTEGER DEFAULT NULL,
  mailing_id INTEGER DEFAULT NULL,
  link_number INTEGER DEFAULT NULL,
  source VARCHAR(765) DEFAULT NULL,
  referring_user_id INTEGER DEFAULT NULL,
  created_at timestamp NOT NULL,
  useragent_id INTEGER DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (clickurl_id) REFERENCES core_clickurl(id),
  FOREIGN KEY (user_id) REFERENCES core_user(id),
  FOREIGN KEY (mailing_id) REFERENCES core_mailing(id),
  FOREIGN KEY (useragent_id) REFERENCES core_useragent(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(clickurl_id, user_id, mailing_id);

ALTER TABLE core_click RENAME TO old_core_click;

INSERT INTO new_core_click (SELECT * FROM old_core_click);

ALTER TABLE new_core_click RENAME TO core_click;


-- ak_sumofus  core_click  id  bigint  delta true  1 true
-- ak_sumofus  core_click  clickurl_id integer lzo false 0 false
-- ak_sumofus  core_click  user_id integer lzo false 0 false
-- ak_sumofus  core_click  mailing_id  integer lzo false 0 false
-- ak_sumofus  core_click  link_number integer lzo false 0 false
-- ak_sumofus  core_click  source  character varying(765)  lzo false 0 false
-- ak_sumofus  core_click  referring_user_id integer lzo false 0 false
-- ak_sumofus  core_click  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_click  useragent_id  integer lzo false 0 false


CREATE TABLE ak_sumofus.new_core_open(
 id BIGINT NOT NULL,
 user_id INTEGER DEFAULT NULL,
 mailing_id INTEGER DEFAULT NULL,
 created_at TIMESTAMP NOT NULL,
 useragent_id INTEGER DEFAULT NULL,
 PRIMARY KEY (id),
 FOREIGN KEY (user_id) REFERENCES core_user(id),
 FOREIGN KEY (mailing_id) REFERENCES core_mailing(id),
 FOREIGN KEY (useragent_id) REFERENCES core_useragent(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(user_id, mailing_id);


ALTER TABLE core_open RENAME TO old_core_open;

INSERT INTO new_core_open (SELECT * FROM old_core_open);

ALTER TABLE new_core_open RENAME TO core_open;


-- ak_sumofus  core_open id  bigint  delta true  1 true
-- ak_sumofus  core_open user_id integer lzo false 0 false
-- ak_sumofus  core_open mailing_id  integer lzo false 0 false
-- ak_sumofus  core_open created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_open useragent_id  integer lzo false 0 false


CREATE TABLE ak_sumofus.new_share_type(
 id INTEGER NOT NULL, 
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 type VARCHAR(6) NOT NULL,
 name VARCHAR(765) NOT NULL,
PRIMARY KEY(id)
)
DISTKEY(id)
SORTKEY(id);

ALTER TABLE share_type RENAME TO old_share_type;

INSERT INTO new_share_type (SELECT * FROM old_share_type);

ALTER TABLE new_share_type RENAME TO share_type;



-- ak_sumofus  share_type  id  integer none  true  1 true
-- ak_sumofus  share_type  created_at  timestamp without time zone none  false 0 false
-- ak_sumofus  share_type  updated_at  timestamp without time zone none  false 0 false
-- ak_sumofus  share_type  type  character varying(6)  none  false 0 false
-- ak_sumofus  share_type  name  character varying(765)  none  false 0 false


CREATE TABLE ak_sumofus.new_share_link(
 id INTEGER NOT NULL,
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 page_id INTEGER NOT NULL,
 type VARCHAR(6) NOT NULL,
 user_id INTEGER DEFAULT NULL,
 action_id INTEGER DEFAULT NULL,
 referring_share_id INTEGER DEFAULT NULL,
 generation INTEGER NOT NULL,
 source VARCHAR(765) DEFAULT NULL,
PRIMARY KEY(id),
FOREIGN KEY(action_id) REFERENCES core_action(id),
FOREIGN KEY(page_id) REFERENCES core_page(id),
FOREIGN KEY(referring_share_id) REFERENCES share_link(id),
FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(action_id,created_at, page_id, user_id,referring_share_id ); 

ALTER TABLE share_link RENAME TO old_share_link;

INSERT INTO new_share_link (SELECT * FROM old_share_link);

ALTER TABLE new_share_link RENAME TO share_link;


-- ak_sumofus  share_link  id  integer delta true  1 true
-- ak_sumofus  share_link  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  share_link  updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  share_link  page_id integer lzo false 0 false
-- ak_sumofus  share_link  type  character varying(6)  lzo false 0 false
-- ak_sumofus  share_link  user_id integer lzo false 0 false
-- ak_sumofus  share_link  action_id integer delta32k  false 0 false
-- ak_sumofus  share_link  referring_share_id  integer lzo false 0 false
-- ak_sumofus  share_link  generation  integer lzo false 0 false
-- ak_sumofus  share_link  source  character varying(765)  lzo false 0 false


CREATE TABLE ak_sumofus.new_share_action(
 id INTEGER NOT NULL,
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 share_id INTEGER NOT NULL,
 action_id INTEGER NOT NULL,
PRIMARY KEY(id),
UNIQUE (action_id),
FOREIGN KEY(action_id) REFERENCES core_action(id),
FOREIGN KEY(share_id) REFERENCES share_link(id)
)
DISTKEY(action_id)
INTERLEAVED SORTKEY(id,action_id, share_id,created_at);


ALTER TABLE share_action RENAME TO old_share_action;

INSERT INTO new_share_action (SELECT * FROM old_share_action);

ALTER TABLE new_share_action RENAME TO share_action;

-- ak_sumofus  share_action  id  integer delta true  1 true
-- ak_sumofus  share_action  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  share_action  updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  share_action  share_id  integer delta32k  false 0 false
-- ak_sumofus  share_action  action_id integer delta32k  false 0 false


CREATE TABLE ak_sumofus.new_share_click(
 id INTEGER NOT NULL,
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 share_id INTEGER NOT NULL,
 page_id INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(page_id) REFERENCES core_page(id),
FOREIGN KEY(share_id) REFERENCES share_link(id)
)
DISTKEY(share_id)
INTERLEAVED SORTKEY(id,share_id,page_id, created_at);

ALTER TABLE share_click RENAME TO old_share_click;

INSERT INTO new_share_click (SELECT * FROM old_share_click);

ALTER TABLE new_share_click RENAME TO share_click;

-- ak_sumofus  share_click id  integer delta true  1 true
-- ak_sumofus  share_click created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  share_click updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  share_click share_id  integer delta32k  false 0 false
-- ak_sumofus  share_click page_id integer lzo false 0 false


CREATE TABLE ak_sumofus.new_core_order (
  id INTEGER NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL,
  action_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  user_detail_id INTEGER,
  card_num_last_four VARCHAR(12) NOT NULL,
  shipping_address_id INTEGER,
  total NUMERIC(10,2) NOT NULL,
  currency VARCHAR(9) NOT NULL DEFAULT 'USD',
  total_converted NUMERIC(10,2) NOT NULL DEFAULT '0.00',
  status VARCHAR(765) NOT NULL,
  import_id VARCHAR(96) DEFAULT NULL,
  account VARCHAR(765) DEFAULT NULL,
  payment_method VARCHAR(765),
  PRIMARY KEY(id),
  UNIQUE(action_id),
  FOREIGN KEY(action_id) REFERENCES core_action(id),
  FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(id)
SORTKEY(id,action_id, user_id, total_converted, status, account);

ALTER TABLE core_order RENAME TO old_core_order;

INSERT INTO new_core_order (SELECT * FROM old_core_order);

ALTER TABLE new_core_order RENAME TO core_order;



-- ak_sumofus  core_order  id  integer delta true  1 true
-- ak_sumofus  core_order  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_order  updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_order  action_id integer delta false 0 false
-- ak_sumofus  core_order  user_id integer lzo false 0 false
-- ak_sumofus  core_order  user_detail_id  integer delta false 0 false
-- ak_sumofus  core_order  card_num_last_four  character varying(12) lzo false 0 false
-- ak_sumofus  core_order  shipping_address_id integer none  false 0 false
-- ak_sumofus  core_order  total numeric(10,2) bytedict  false 0 false
-- ak_sumofus  core_order  currency  character varying(9)  bytedict  false 0 false
-- ak_sumofus  core_order  total_converted numeric(10,2) lzo false 0 false
-- ak_sumofus  core_order  status  character varying(765)  lzo false 0 false
-- ak_sumofus  core_order  import_id character varying(96) lzo false 0 false
-- ak_sumofus  core_order  account character varying(765)  lzo false 0 false
-- ak_sumofus  core_order  payment_method  character varying(765)  lzo false 0 false


CREATE TABLE ak_sumofus.new_core_transaction (
 id INTEGER NOT NULL,
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 type VARCHAR(765) NOT NULL,
 order_id INTEGER NOT NULL,
 account VARCHAR(765) NOT NULL,
 test_mode SMALLINT,
 amount NUMERIC(10,2) NOT NULL ,
 amount_converted NUMERIC(10,2) NOT NULL DEFAULT '0.00',
 success SMALLINT NOT NULL,
 status VARCHAR(765) NOT NULL,
 trans_id VARCHAR(765) DEFAULT NULL,
 failure_description VARCHAR(MAX),
 failure_code VARCHAR(765) DEFAULT NULL,
 failure_message VARCHAR(MAX),
 currency VARCHAR(9) NOT NULL DEFAULT 'USD',
PRIMARY KEY(id),
FOREIGN KEY(order_id) REFERENCES core_order(id)
)
DISTKEY(order_id)
INTERLEAVED SORTKEY(id,created_at, order_id, type,account, amount_converted,status);

ALTER TABLE core_transaction RENAME TO old_core_transaction;

INSERT INTO new_core_transaction (SELECT * FROM old_core_transaction);

ALTER TABLE new_core_transaction RENAME TO core_transaction;



-- ak_sumofus  core_transaction  id  integer delta true  1 true
-- ak_sumofus  core_transaction  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_transaction  updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_transaction  type  character varying(765)  lzo false 0 false
-- ak_sumofus  core_transaction  order_id  integer delta false 0 false
-- ak_sumofus  core_transaction  account character varying(765)  lzo false 0 false
-- ak_sumofus  core_transaction  test_mode smallint  lzo false 0 false
-- ak_sumofus  core_transaction  amount  numeric(10,2) bytedict  false 0 false
-- ak_sumofus  core_transaction  amount_converted  numeric(10,2) lzo false 0 false
-- ak_sumofus  core_transaction  success smallint  lzo false 0 false
-- ak_sumofus  core_transaction  status  character varying(765)  lzo false 0 false
-- ak_sumofus  core_transaction  trans_id  character varying(765)  lzo false 0 false
-- ak_sumofus  core_transaction  failure_description character varying(65535)  lzo false 0 false
-- ak_sumofus  core_transaction  failure_code  character varying(765)  lzo false 0 false
-- ak_sumofus  core_transaction  failure_message character varying(65535)  lzo false 0 false
-- ak_sumofus  core_transaction  currency  character varying(9)  lzo false 0 false


CREATE TABLE ak_sumofus.new_core_orderrecurring (
 id INTEGER NOT NULL,
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 order_id INTEGER NOT NULL,
 action_id INTEGER NOT NULL,
 exp_date VARCHAR(18) NOT NULL,
 card_num VARCHAR(12) NOT NULL,
 recurring_id VARCHAR(765) DEFAULT NULL,
 account VARCHAR(765) DEFAULT NULL,
 user_id INTEGER NOT NULL,
 start DATE NOT NULL,
 occurrences INTEGER,
 period VARCHAR(765),
 amount NUMERIC(10,2) NOT NULL,
 currency VARCHAR(9) NOT NULL DEFAULT 'USD',
 amount_converted NUMERIC(10,2) NOT NULL DEFAULT '0.00',
 status VARCHAR(765) NOT NULL,
PRIMARY KEY (id),
UNIQUE (action_id),
FOREIGN KEY(action_id) REFERENCES core_action(id),
FOREIGN KEY(order_id) REFERENCES core_order(id),
FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(order_id)
INTERLEAVED SORTKEY(id,order_id, action_id, user_id, created_at, amount_converted, status, account);

ALTER TABLE core_orderrecurring RENAME TO old_core_orderrecurring;

INSERT INTO new_core_orderrecurring (SELECT * FROM old_core_orderrecurring);

ALTER TABLE new_core_orderrecurring RENAME TO core_orderrecurring;

-- ak_sumofus  core_orderrecurring id  integer delta true  1 true
-- ak_sumofus  core_orderrecurring created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_orderrecurring updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_orderrecurring order_id  integer delta false 0 false
-- ak_sumofus  core_orderrecurring action_id integer delta32k  false 0 false
-- ak_sumofus  core_orderrecurring exp_date  character varying(18) bytedict  false 0 false
-- ak_sumofus  core_orderrecurring card_num  character varying(12) lzo false 0 false
-- ak_sumofus  core_orderrecurring recurring_id  character varying(765)  lzo false 0 false
-- ak_sumofus  core_orderrecurring account character varying(765)  lzo false 0 false
-- ak_sumofus  core_orderrecurring user_id integer lzo false 0 false
-- ak_sumofus  core_orderrecurring start date  runlength false 0 false
-- ak_sumofus  core_orderrecurring occurrences integer lzo false 0 false
-- ak_sumofus  core_orderrecurring period  character varying(765)  lzo false 0 false
-- ak_sumofus  core_orderrecurring amount  numeric(10,2) bytedict  false 0 false
-- ak_sumofus  core_orderrecurring currency  character varying(9)  bytedict  false 0 false
-- ak_sumofus  core_orderrecurring amount_converted  numeric(10,2) mostly32  false 0 false
-- ak_sumofus  core_orderrecurring status  character varying(765)  lzo false 0 false

CREATE TABLE ak_sumofus.new_core_tag (
 id INTEGER NOT NULL,
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 hidden SMALLINT NOT NULL,
 name VARCHAR(765) NOT NULL,
 times_used INTEGER DEFAULT NULL,
 order_index INTEGER NOT NULL,
PRIMARY KEY(id),
UNIQUE(name)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,name);

ALTER TABLE core_tag RENAME TO old_core_tag;

INSERT INTO new_core_tag (SELECT * FROM old_core_tag);

ALTER TABLE new_core_tag RENAME TO core_tag;


-- ak_sumofus  core_tag  id  integer none  true  1 true
-- ak_sumofus  core_tag  created_at  timestamp without time zone none  false 0 false
-- ak_sumofus  core_tag  updated_at  timestamp without time zone none  false 0 false
-- ak_sumofus  core_tag  hidden  smallint  none  false 0 false
-- ak_sumofus  core_tag  name  character varying(765)  none  false 0 false
-- ak_sumofus  core_tag  times_used  integer none  false 0 false
-- ak_sumofus  core_tag  order_index integer none  false 0 false


CREATE TABLE ak_sumofus.new_core_mailing_tags (
 id INTEGER NOT NULL,
 mailing_id INTEGER NOT NULL,
 tag_id INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(mailing_id) REFERENCES core_mailing(id),
FOREIGN KEY(tag_id) REFERENCES core_tag(id)
)
DISTKEY(mailing_id)
INTERLEAVED SORTKEY(id, mailing_id, tag_id);

ALTER TABLE core_mailing_tags RENAME TO old_core_mailing_tags;

INSERT INTO new_core_mailing_tags (SELECT * FROM old_core_mailing_tags);

ALTER TABLE new_core_mailing_tags RENAME TO core_mailing_tags;


-- ak_sumofus  core_mailing_tags id  integer delta true  1 true
-- ak_sumofus  core_mailing_tags mailing_id  integer delta false 0 false
-- ak_sumofus  core_mailing_tags tag_id  integer lzo false 0 false

CREATE TABLE ak_sumofus.new_core_page_tags (
 id INTEGER NOT NULL,
 page_id INTEGER NOT NULL,
 tag_id INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(page_id) REFERENCES core_page(id),
FOREIGN KEY(tag_id) REFERENCES core_tag(id)
)
DISTKEY(page_id)
INTERLEAVED SORTKEY(id, page_id, tag_id);

ALTER TABLE core_page_tags RENAME TO old_core_page_tags;

INSERT INTO new_core_page_tags (SELECT * FROM old_core_page_tags);

ALTER TABLE new_core_page_tags RENAME TO core_page_tags;

-- ak_sumofus  core_page_tags  id  integer delta true  1 true
-- ak_sumofus  core_page_tags  page_id integer delta false 0 false
-- ak_sumofus  core_page_tags  tag_id  integer lzo false 0 false


CREATE TABLE ak_sumofus.new_core_subscriptionhistory (
 id INTEGER NOT NULL,
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 user_id INTEGER NOT NULL,
 list_id INTEGER NOT NULL,
 change_id INTEGER NOT NULL,
 action_id INTEGER DEFAULT NULL,
PRIMARY KEY(id),
FOREIGN KEY(action_id) REFERENCES core_action(id),
FOREIGN KEY(list_id) REFERENCES core_list(id),
FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(id, user_id, created_at, list_id, change_id,action_id);

ALTER TABLE core_subscriptionhistory RENAME TO old_core_subscriptionhistory;

INSERT INTO new_core_subscriptionhistory (SELECT * FROM old_core_subscriptionhistory);

ALTER TABLE new_core_subscriptionhistory RENAME TO core_subscriptionhistory;


-- ak_sumofus  core_subscriptionhistory  id  integer delta true  1 true
-- ak_sumofus  core_subscriptionhistory  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_subscriptionhistory  updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_subscriptionhistory  user_id integer delta false 0 false
-- ak_sumofus  core_subscriptionhistory  list_id integer lzo false 0 false
-- ak_sumofus  core_subscriptionhistory  change_id integer lzo false 0 false
-- ak_sumofus  core_subscriptionhistory  action_id integer delta false 0 false



CREATE TABLE ak_sumofus.new_core_subscription (
 id INTEGER NOT NULL,
 created_at TIMESTAMP NOT NULL,
 updated_at TIMESTAMP NOT NULL,
 user_id INTEGER NOT NULL,
 list_id INTEGER NOT NULL,
 PRIMARY KEY (id),
 FOREIGN KEY(list_id) REFERENCES core_list(id),
 FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(id, user_id, list_id, created_at);

ALTER TABLE core_subscription RENAME TO old_core_subscription;

INSERT INTO new_core_subscription (SELECT * FROM old_core_subscription);

ALTER TABLE new_core_subscription RENAME TO core_subscription;


-- ak_sumofus  core_subscription id  integer delta true  1 true
-- ak_sumofus  core_subscription created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_subscription updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_subscription user_id integer delta false 0 false
-- ak_sumofus  core_subscription list_id integer lzo false 0 false


CREATE TABLE ak_sumofus.new_core_phone (
 id INTEGER NOT NULL,
 created_at TIMESTAMP NULL,
 updated_at TIMESTAMPT NULL,
 user_id INTEGER NOT NULL,
 type VARCHAR(75),
 phone VARCHAR(75) NOT NULL,
 source VARCHAR(75) NOT NULL,
 normalized_phone VARCHAR(75) NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(id,user_id);

ALTER TABLE core_phone RENAME TO old_core_phone;

INSERT INTO new_core_phone (SELECT * FROM old_core_phone);

ALTER TABLE new_core_phone RENAME TO core_phone;

-- ak_sumofus  core_phone  id  integer delta true  1 true
-- ak_sumofus  core_phone  created_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_phone  updated_at  timestamp without time zone lzo false 0 false
-- ak_sumofus  core_phone  user_id integer lzo false 0 false
-- ak_sumofus  core_phone  type  character varying(75) lzo false 0 false
-- ak_sumofus  core_phone  phone character varying(75) lzo false 0 false
-- ak_sumofus  core_phone  source  character varying(75) lzo false 0 false
-- ak_sumofus  core_phone  normalized_phone  character varying(75) lzo false 0 false

####################


# DROP RENAMED OLD TABLES
DROP TABLE old_core_user;
DROP TABLE old_core_list;
DROP TABLE old_core_page;
DROP TABLE old_core_userfield;
DROP TABLE old_core_location;
DROP TABLE old_core_mailing;
DROP TABLE old_core_action;
DROP TABLE old_core_actionfield;
DROP TABLE old_core_clickurl;
DROP TABLE old_core_useragent;
DROP TABLE old_core_click;
DROP TABLE old_core_open;
DROP TABLE old_share_type;
DROP TABLE old_share_link;
DROP TABLE old_share_action;
DROP TABLE old_share_click;
DROP TABLE old_core_order;
DROP TABLE old_core_transaction;
DROP TABLE old_core_orderrecurring;
DROP TABLE old_core_tag;
DROP TABLE old_core_mailing_tags;
DROP TABLE old_core_page_tags;
DROP TABLE old_core_subscriptionhistory;
DROP TABLE old_core_subscription;
DROP TABLE old_core_phone;
