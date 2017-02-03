CREATE TABLE ak_sumofus.core_user(
  id integer NOT NULL,
  created_at datetime NOT NULL,
  updated_at datetime NOT NULL,
  email varchar(765) NOT NULL,
  first_name varchar(765) NOT NULL,
  middle_name varchar(765) NOT NULL,
  last_name varchar(765) NOT NULL,
  subscription_status varchar(765) NOT NULL,
  address1 varchar(765) NOT NULL,
  address2 varchar(765) NOT NULL,
  city varchar(765) NOT NULL,
  state varchar(765) NOT NULL,
  region varchar(765) NOT NULL,
  postal varchar(765) NOT NULL,
  zip varchar(15) NOT NULL,
  country varchar(765) NOT NULL,
  source varchar(765) NOT NULL,
  lang_id integer DEFAULT NULL,
  rand_id integer NOT NULL,
  PRIMARY KEY(id),
  UNIQUE(email)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id, email,created_at,country,lang_id,subscription_status);


CREATE TABLE ak_sumofus.core_list (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 hidden SMALLINT NOT NULL,
 name VARCHAR(765) NOT NULL,
 is_default SMALLINT NOT NULL,
 PRIMARY KEY(id),
 UNIQUE (name)
)
DISTKEY(id)
SORTKEY(id);


CREATE TABLE ak_sumofus.core_page (
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
 status VARCHAR(765) NOT NULL,
 list_id INTEGER NOT NULL,
 allow_multiple_responses SMALLINT NOT NULL,
 recognize VARCHAR(765) NOT NULL,
 real_actions SMALLINT NOT NULL,
PRIMARY KEY (id),
UNIQUE(name),
FOREIGN KEY(list_id) REFERENCES core_list(id)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,created_at, lang_id, type, title);


CREATE TABLE ak_sumofus.new_core_userfield(
  id INTEGER NOT NULL,
  parent_id INTEGER NOT NULL,
  name VARCHAR(765) NOT NULL DEFAULT '',
  value VARCHAR(765) NOT NULL DEFAULT '',
  PRIMARY KEY(id),
  FOREIGN KEY(parent_id) REFERENCES core_user(id)
)
DISTKEY(parent_id)
COMPOUND SORTKEY(name, value, parent_id);


CREATE TABLE ak_sumofus.core_location(
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


CREATE TABLE ak_sumofus.core_mailing (
  id INTEGER NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  hidden SMALLINT NOT NULL,
  reply_to VARCHAR(765),
  notes VARCHAR(765),
  lang_id INTEGER DEFAULT NULL,
  landing_page_id INTEGER DEFAULT NULL,
  scheduled_for DATETIME,
  expected_send_count INTEGER DEFAULT NULL,
  started_at DATETIME DEFAULT NULL,
  progress INTEGER DEFAULT NULL,
  status VARCHAR(765) DEFAULT NULL,
  mailing_limit INTEGER DEFAULT NULL,
  sort_by VARCHAR(96) DEFAULT NULL,
  recurring_schedule_id INTEGER DEFAULT NULL,
  recurring_source_mailing_id INTEGER DEFAULT NULL,
  requested_proof_date DATETIME,
  send_date VARCHAR(765) NOT NULL,
  exclude_ordering INTEGER,
  test_group_id INTEGER DEFAULT NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (landing_page_id) REFERENCES core_page(id),
  FOREIGN KEY (recurring_source_mailing_id) REFERENCES core_mailing(id) 
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,started_at,recurring_schedule_id);


CREATE TABLE ak_sumofus.core_action(
  id INTEGER NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  user_id INTEGER NOT NULL,
  mailing_id INTEGER DEFAULT NULL,
  page_id INTEGER NOT NULL,
  source VARCHAR(765) NOT NULL,
  created_user SMALLINT NOT NULL,
  subscribed_user SMALLINT NOT NULL,
  referring_user_id INTEGER DEFAULT NULL,
  referring_mailing_id INTEGER DEFAULT NULL,
  taf_emails_sent INTEGER DEFAULT NULL,
  status VARCHAR(765) NOT NULL,
  is_forwarded SMALLINT NOT NULL DEFAULT '0',
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

CREATE TABLE ak_sumofus.core_actionfield(
  id INTEGER NOT NULL,
  parent_id INTEGER NOT NULL,
  name VARCHAR(765) NOT NULL DEFAULT '',
  value VARCHAR(5000) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  FOREIGN KEY(parent_id) REFERENCES core_action(id)
)
DISTKEY(parent_id)
COMPOUND SORTKEY(name,value, id);


CREATE TABLE ak_sumofus.core_usermailing(
  id BIGINT NOT NULL,
  mailing_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  subject_id INTEGER DEFAULT NULL,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (mailing_id) REFERENCES core_mailing(id),
  FOREIGN KEY (user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(user_id,mailing_id,created_at);


CREATE TABLE ak_sumofus.core_clickurl (
  id INTEGER NOT NULL,
  url VARCHAR(765) NOT NULL,
  page_id INTEGER DEFAULT NULL,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (url),
  FOREIGN KEY (page_id) REFERENCES core_page(id)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,page_id,url);

CREATE TABLE ak_sumofus.core_useragent (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 useragent_string VARCHAR(5000) NOT NULL DEFAULT '',
 hash VARCHAR(192) NOT NULL,
 browser VARCHAR(765) NOT NULL,
 os VARCHAR(765) NOT NULL,
 os_version VARCHAR(90) NOT NULL,
 device VARCHAR(265) NOT NULL,
 is_mobile SMALLINT NOT NULL,
 is_phone SMALLINT NOT NULL,
 is_tablet SMALLINT NOT NULL,
 is_desktop SMALLINT NOT NULL,
PRIMARY KEY(id),
UNIQUE(hash)
)
DISTKEY(id)
INTERLEAVED SORTKEY(is_mobile,is_phone,is_tablet,is_desktop,browser,device);

CREATE TABLE ak_sumofus.core_click (
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


CREATE TABLE ak_sumofus.core_open(
 id BIGINT NOT NULL,
 user_id INTEGER DEFAULT NULL,
 mailing_id INTEGER DEFAULT NULL,
 created_at timestamp NOT NULL,
 useragent_id INTEGER DEFAULT NULL,
 PRIMARY KEY (id),
 FOREIGN KEY (user_id) REFERENCES core_user(id),
 FOREIGN KEY (mailing_id) REFERENCES core_mailing(id),
 FOREIGN KEY (useragent_id) REFERENCES core_useragent(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(user_id, mailing_id);


CREATE TABLE ak_sumofus.share_type(
 id INTEGER NOT NULL, 
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 type VARCHAR(6) NOT NULL,
 name VARCHAR(765) NOT NULL,
PRIMARY KEY(id)
)
DISTKEY(id)
SORTKEY(id);


CREATE TABLE ak_sumofus.share_link(
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 page_id INTEGER NOT NULL,
 type VARCHAR(6) NOT NULL,
 user_id INTEGER DEFAULT NULL,
 action_id INTEGER DEFAULT NULL,
 referring_share_id INTEGER DEFAULT NULL,
 generation SMALLINT NOT NULL,
 source VARCHAR(765) DEFAULT NULL,
PRIMARY KEY(id),
FOREIGN KEY(action_id) REFERENCES core_action(id),
FOREIGN KEY(page_id) REFERENCES core_page(id),
FOREIGN KEY(referring_share_id) REFERENCES share_link(id),
FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(action_id,created_at, page_id, user_id,referring_share_id ); 


CREATE TABLE ak_sumofus.share_action(
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 share_id INTEGER NOT NULL,
 action_id INTEGER NOT NULL,
PRIMARY KEY(id),
UNIQUE (action_id),
FOREIGN KEY(action_id) REFERENCES core_action(id),
FOREIGN KEY(share_id) REFERENCES share_link(id)
)
DISTKEY(action_id)
INTERLEAVED SORTKEY(id,action_id, share_id,created_at);


CREATE TABLE ak_sumofus.share_click(
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 share_id INTEGER NOT NULL,
 page_id INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(page_id) REFERENCES core_page(id),
FOREIGN KEY(share_id) REFERENCES share_link(id)
)
DISTKEY(share_id)
INTERLEAVED SORTKEY(id,share_id,page_id, created_at);

CREATE TABLE ak_sumofus.core_order (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 action_id INTEGER NOT NULL,
 user_id INTEGER NOT NULL,
 card_num_last_four VARCHAR(12) NOT NULL,
 total NUMERIC(10,2) NOT NULL,
 currency VARCHAR(15) NOT NULL DEFAULT 'USD',
 total_converted NUMERIC(10,2) NOT NULL DEFAULT '0.00',
 status VARCHAR(765) NOT NULL,
 import_id VARCHAR(96) DEFAULT NULL,
 account VARCHAR(765) DEFAULT NULL,
PRIMARY KEY(id),
UNIQUE(action_id),
FOREIGN KEY(action_id) REFERENCES core_action(id),
FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(id)
SORTKEY(id,action_id, user_id, total_converted, status, account);


CREATE TABLE ak_sumofus.core_transaction (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 type VARCHAR(765) NOT NULL,
 order_id INTEGER NOT NULL,
 account VARCHAR(765) NOT NULL,
 amount NUMERIC(10,2) NOT NULL ,
 amount_converted NUMERIC(10,2) NOT NULL DEFAULT '0.00',
 success SMALLINT NOT NULL,
 status VARCHAR(765) NOT NULL,
 trans_id VARCHAR(765) DEFAULT NULL,
 failure_description text,
 failure_code VARCHAR(765) DEFAULT NULL,
 failure_message text,
 currency VARCHAR(15) NOT NULL DEFAULT 'USD',
PRIMARY KEY(id),
FOREIGN KEY(order_id) REFERENCES core_order(id)
)
DISTKEY(order_id)
INTERLEAVED SORTKEY(id,created_at, order_id, type,account, amount_converted,status);


CREATE TABLE ak_sumofus.core_orderrecurring (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 order_id INTEGER NOT NULL,
 action_id INTEGER NOT NULL,
 exp_date VARCHAR(18) NOT NULL,
 card_num VARCHAR(12) NOT NULL,
 recurring_id VARCHAR(765) DEFAULT NULL,
 account VARCHAR(765) DEFAULT NULL,
 user_id INTEGER NOT NULL,
 start DATE NOT NULL,
 amount NUMERIC(10,2) NOT NULL,
 currency VARCHAR(15) NOT NULL DEFAULT 'USD',
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

CREATE TABLE ak_sumofus.core_tag (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 hidden SMALLINT NOT NULL,
 name VARCHAR(765) NOT NULL,
 times_used INTEGER DEFAULT NULL,
 order_index INTEGER NOT NULL,
PRIMARY KEY(id),
UNIQUE(name)
)
DISTKEY(id)
INTERLEAVED SORTKEY(id,name);


CREATE TABLE ak_sumofus.core_mailing_tags (
 id INTEGER NOT NULL,
 mailing_id INTEGER NOT NULL,
 tag_id INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(mailing_id) REFERENCES core_mailing(id),
FOREIGN KEY(tag_id) REFERENCES core_tag(id)
)
DISTKEY(mailing_id)
INTERLEAVED SORTKEY(id, mailing_id, tag_id);


CREATE TABLE ak_sumofus.core_page_tags (
 id INTEGER NOT NULL,
 page_id INTEGER NOT NULL,
 tag_id INTEGER NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(page_id) REFERENCES core_page(id),
FOREIGN KEY(tag_id) REFERENCES core_tag(id)
)
DISTKEY(page_id)
INTERLEAVED SORTKEY(id, page_id, tag_id);


CREATE TABLE ak_sumofus.core_subscriptionhistory (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
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


CREATE TABLE ak_sumofus.core_subscription (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 user_id INTEGER NOT NULL,
 list_id INTEGER NOT NULL,
 PRIMARY KEY (id),
 FOREIGN KEY(list_id) REFERENCES core_list(id),
 FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(id, user_id, list_id, created_at);


CREATE TABLE ak_sumofus.core_phone (
 id INTEGER NOT NULL,
 created_at DATETIME NOT NULL,
 updated_at DATETIME NOT NULL,
 user_id INTEGER NOT NULL,
 phone VARCHAR(75) NOT NULL,
 source VARCHAR(75) NOT NULL,
 normalized_phone VARCHAR(75) NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY(user_id) REFERENCES core_user(id)
)
DISTKEY(user_id)
INTERLEAVED SORTKEY(id,user_id);
