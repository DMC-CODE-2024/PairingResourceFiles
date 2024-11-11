source ~/.bash_profile

source $commonConfigurationFilePath
dbDecryptPassword=$(java -jar  ${APP_HOME}/encryption_utility/PasswordDecryptor-0.1.jar spring.datasource.password)

mysql  -h$dbIp -P$dbPort -u$dbUsername -p${dbDecryptPassword} $appdbName <<EOFMYSQL

 
CREATE TABLE `temp_exception_list` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `file_name` varchar(255) DEFAULT NULL,
  `imei` varchar(20) DEFAULT NULL,
  `imsi` varchar(50) DEFAULT NULL,
  `msisdn` varchar(15) DEFAULT NULL,
  `operator_id` varchar(50) DEFAULT NULL,
  `operator_name` varchar(50) DEFAULT NULL,
  `complaint_type` varchar(50) DEFAULT NULL,
  `expiry_date` timestamp NULL DEFAULT NULL,
  `mode_type` varchar(50) DEFAULT NULL,
  `request_type` varchar(50) DEFAULT NULL,
  `txn_id` varchar(50) DEFAULT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `user_type` varchar(50) DEFAULT NULL,
  `actual_imei` varchar(50) DEFAULT NULL,
  `tac` varchar(50) DEFAULT NULL,
  `remarks` varchar(250) DEFAULT NULL,
  `modified_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `edr_date_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `temp_imei` (`imei`)
);

CREATE TABLE `eirs_invalid_imei` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `actual_imei` varchar(20) DEFAULT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `imei` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `actual_imei` (`actual_imei`),
  KEY `imei` (`imei`),
  KEY `imei_2` (`imei`)
);

CREATE TABLE `imei_manual_pair_mgmt` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contact_number_otp` varchar(20) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `email_id_otp` varchar(50) DEFAULT NULL,
  `fail_reason` varchar(100) DEFAULT NULL,
  `imei1` varchar(20) DEFAULT NULL,
  `imei2` varchar(20) DEFAULT NULL,
  `imei3` varchar(20) DEFAULT NULL,
  `imei4` varchar(20) DEFAULT NULL,
  `msisdn1` varchar(20) DEFAULT NULL,
  `msisdn2` varchar(20) DEFAULT NULL,
  `msisdn3` varchar(20) DEFAULT NULL,
  `msisdn4` varchar(20) DEFAULT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `otp_retries` int DEFAULT NULL,
  `request_id` varchar(30) DEFAULT NULL,
  `request_type` varchar(20) DEFAULT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `language` varchar(10) DEFAULT NULL,
  `old_msisdn` varchar(20) DEFAULT NULL,
  `description1` varchar(100) DEFAULT NULL,
  `description2` varchar(100) DEFAULT NULL,
  `description3` varchar(100) DEFAULT NULL,
  `description4` varchar(100) DEFAULT NULL,
  `status1` varchar(20) DEFAULT NULL,
  `status2` varchar(20) DEFAULT NULL,
  `status3` varchar(20) DEFAULT NULL,
  `status4` varchar(20) DEFAULT NULL,
  `gui_msisdn1` varchar(20) DEFAULT NULL,
  `gui_msisdn2` varchar(20) DEFAULT NULL,
  `gui_msisdn3` varchar(20) DEFAULT NULL,
  `gui_msisdn4` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `request_id` (`request_id`),
  KEY `status` (`status`,`created_on`)
);



CREATE TABLE `imei_pair_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) DEFAULT NULL,
  `gsma_status` enum('INVALID','VALID') DEFAULT NULL,
  `pairing_date` datetime(6) DEFAULT NULL,
  `record_time` datetime(6) DEFAULT NULL,
  `msisdn` varchar(20) DEFAULT NULL,
  `imei` varchar(20) DEFAULT NULL,
  `imsi` varchar(20) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Operator` varchar(20) DEFAULT NULL,
  `allowed_days` int DEFAULT '60',
  `expiry_date` timestamp NULL DEFAULT NULL,
  `pair_mode` varchar(20) DEFAULT NULL,
  `actual_imei` varchar(20) DEFAULT NULL,
  `txn_id` varchar(50) DEFAULT NULL,
  `modified_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `request_id` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `INX_PAIR_MODE` (`imsi`,`pair_mode`),
  KEY `imei` (`imei`)
);

CREATE TABLE `imei_pair_detail_his` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `created_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `allowed_days` int DEFAULT NULL,
  `imei` varchar(20) DEFAULT NULL,
  `imsi` varchar(20) DEFAULT NULL,
  `msisdn` varchar(20) DEFAULT NULL,
  `pairing_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `record_time` timestamp NULL DEFAULT NULL,
  `file_name` varchar(100) DEFAULT NULL,
  `gsma_status` varchar(20) DEFAULT NULL,
  `pair_mode` varchar(20) DEFAULT NULL,
  `operator` varchar(20) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `action_remark` varchar(50) DEFAULT NULL,
  `expiry_date` timestamp NULL DEFAULT NULL,
  `actual_imei` varchar(20) DEFAULT NULL,
  `txn_id` varchar(50) DEFAULT NULL,
  `modified_on` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `imei` (`imei`),
  KEY `INX_PAIR_MODE` (`imsi`,`pair_mode`)
);


INSERT INTO app.sys_param (tag, value) VALUES ('default_language', 'en');

INSERT INTO sys_param(tag,value,feature_name)  values  ('GRACE_PERIOD_END_DATE','yyyy-MM-dd','');

INSERT INTO app.sys_param (tag, value,feature_name) VALUES ('pairing_allowed_device_type', 'Mobile,Laptop','auto_pairing_identify');

INSERT INTO app.sys_param (tag, value,feature_name) VALUES ('pairing_allowed_days', '10','auto_pairing_identify');

INSERT INTO app.sys_param (tag, value,feature_name) VALUES ('pairing_allowed_count', '5','auto_pairing_identify');

INSERT INTO app.sys_param (tag, value,feature_name) VALUES ('pairing_notification_sms_start_time', '09:00','auto_pairing_identify');

INSERT INTO app.sys_param (tag, value,feature_name) VALUES ('pairing_notification_sms_end_time', '18:00','auto_pairing_identify'); 


EOFMYSQL
