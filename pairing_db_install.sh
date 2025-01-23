#!/bin/bash
conf_file=${APP_HOME}/configuration/configuration.properties
typeset -A config # init array

while read line
do
    if echo $line | grep -F = &>/dev/null
    then
        varname=$(echo "$line" | cut -d '=' -f 1)
        config[$varname]=$(echo "$line" | cut -d '=' -f 2-)
    fi
done < $conf_file
dbPassword=$(java -jar  ${APP_HOME}/utility/pass_dypt/pass_dypt.jar spring.datasource.password)
conn="mysql -h${config[dbIp]} -P${config[dbPort]} -u${config[dbUsername]} -p${dbPassword} ${config[appdbName]}"

`${conn} <<EOFMYSQL


INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('Notification window End Time', 'pairing_notification_sms_end_time', 0, '18:00', 1, 'auto_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('Notification window Start Time', 'pairing_notification_sms_start_time', 0, '14:00', 1, 'auto_pairing', NULL, 'system', 'system');


INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('Grace period for invalid IMEI pair', 'pairing_allowed_days', 0, '10', 1, 'auto_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('# of valid IMEI pair allowed at any point of time', 'pairing_allowed_count', 0, '2', 1, 'auto_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('', 'pairing_msisdn_min_length', 0, '7', 1, 'auto_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('', 'pairing_msisdn_max_length', 0, '13', 1, 'auto_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('', 'pairing_otp_max_valid_retries', 0, '3', 1, 'auto_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('Comma separated values of device type that uses auto_pairing process', 'pairing_allowed_device_type', 0, 'smartphone,featurephone,mobile', 1, 'auto_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('This flag is used to identify the amnesty and post amnesty based on date (YYYY-MM-DD)', 'GRACE_PERIOD_END_DATE', 0, '2024-12-12', 1, 'auto_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (created_on, description, modified_on, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES (NOW(), 'Notification is sent or not', NOW(), 'pairing_send_notification_flag', 1, 'Yes', 1, 'auto_pairing', NULL, 'system', 'system');


INSERT IGNORE INTO sys_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by) VALUES ('', 'manual_pair_clean_up_days', 0, '3', 0, 'manual_pairing', NULL, 'system', 'system');

INSERT IGNORE INTO sys_param (DESCRIPTION, tag, TYPE, VALUE, ACTIVE, feature_name, remark, user_type, modified_by) VALUES ('mgmt_init_start_clean_up_hours', 'mgmt_init_start_clean_up_hours', 0, '2', 1, 'manual_pairing_incomplete_clean', NULL, 'system', 'system');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to the public user when invalid  IMEI is auto paired bt EIRS system', 'AutoPairGsmaInvalidSMS', NULL, 'Your <MSISDN> has been auto paired with <ACTUAL_IMEI>.', 1, 'auto_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to the public user when valid but non tax paid IMEI is auto paired bt EIRS system', 'AutoPairGsmaValidSMS', NULL, 'Your <MSISDN> has been auto paired with <ACTUAL_IMEI>.', 1, 'auto_pairing', NULL, 'system', 'system', 'en');	

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send validate the public user when public user send a request for manual pairing on web or mobile application', 'ManualPairOtpSMS', NULL, '<OTP> is your OTP for manual pairing request. Never share your OTP with anyone', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email Notification send to validate the public user when public user send a request for manual pairing on web or mobile application', 'ManualPairOtpEmail', NULL, 'Hi,\n<OTP> is your OTP for manual pairing request. Never share your OTP with anyone', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to public user when public user request for manual pairing on web or mobile application is pair successfully', 'ManualPairSMS', NULL, 'Your pairing request for reference number <REFERENCE_ID> is paired successfully. The pairing details are as follow\n<Pair>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email Notification send to public user when public user request for manual pairing on web or mobile application is processed successfully', 'ManualPairEmail', NULL, 'Hi,\nYour pairing request for reference number <REFERENCE_ID> is paired successfully. The pairing details are as follow\n<Pair>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES (NULL, 'ManualPairRepairSMS', NULL, 'Your repair request with reference number <REFERENCE_ID> is repaired successfully. The new pair detail is\n<PAIR>.', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email, Notification send to public user when public user request for  manual repair on web or mobile application is processed successfully', 'ManualPairRepairEmail', NULL, 'Hi,\nYour repair request with reference number <REFERENCE_ID> is repaired successfully. The new pair detail is\n<PAIR>.', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provided IMEI not belonging to same device in the manual pairing request ', 'HTTP_RESP_FAIL_DEVICE_MODELS_ARE_NOT_SAME', NULL, 'All the provided IMEI do not belong to same device. Kindly check your IMEI.', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provided IMEI that does not need pairing  to be done in the manual pairing request ', 'HTTP_RESP_FAIL_DEVICE_TYPES_ARE_NOT_ALLOWED', NULL, 'There is no need to pair this device. This IMEI will work and does not require pairing.', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide custom duty paid IMEI that does not need pairing  to be done in the manual pairing request ', 'HTTP_RESP_OTP_CUSTOM_CHECKED_NO_PAIR_REQUIRED', NULL, 'This IMEI is part of  tax paid device. This IMEI will work and does not require pairing.', 1, 'manual_pairing',NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide already paired IMEI pair in the manual pairing request ', 'HTTP_RESP_ALREADY_PAIRED', NULL, 'Pair already exists between the IMEI and MSISDN', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide duplicate  IMEI in the manual pairing request ', 'HTTP_RESP_DUPLICATE_IMEI_FAIL', NULL, 'IMEI is found to be duplicate. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide stolen or lost  IMEI in the manual pairing request ', 'HTTP_RESP_BLACKLIST_IMEI_FAIL', NULL, 'IMEI is found to be stolen or lost. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide stolen or lost  IMEI in the manual pairing request ', 'HTTP_RESP_GREYLIST_IMEI_FAIL', NULL, 'IMEI is found to be stolen or lost. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide IMEI in the manual pairing request whose limit is already exhausted', 'HTTP_RESP_PAIR_COUNT_LIMIT_FAIL', NULL, 'Pair limit for this IMEI has been exhausted. Hence this IMEI cannot be paired further.', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language) VALUES ('Message displayed on web/mobile application to public user when public user provide  IMEI of special category  in the manual pairing request which does not require pairing.', 'HTTP_RESP_NWL_NO_PAIR_REQUIRED', NULL, 'No Need to
pair as Found in Exception list as VIP', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide invalid IMEI in the manual pairing request ', 'HTTP_RESP_INVALID_IMEI_FAIL', NULL, 'IMEI is found to be invalid. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide non GSMA approved IMEI in the manual pairing request ', 'HTTP_RESP_FAIL_GSMA_INVALID', NULL, 'IMEI is found to be GSMA non-compliant. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide correct OTP', 'HTTP_RESP_OTP_VALIDATION_SUCCESS', NULL, 'OTP validation completed successfully', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to the public user when request sent by public user has failed  for manual pairing ', 'ManualPairRepairFailedSMS', NULL, 'Your repair request  for reference number <REFERENCE_ID> has failed.', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email Notification send to public user when public user request for  manual repair on web or mobile application has failed', 'ManualPairRepairFailedEmail', NULL, 'Hi,\nYour repair request  for reference number <REFERENCE_ID> has failed.', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email Notification send to public user when public user request for  manual pairing on web or mobile application has failed', 'ManualPairFailedEmail', NULL, 'Hi,\nYour pairing request for reference number <REFERENCE_ID> is not paired. The pairing details are\n<Pair>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to public user when public user request for  manual pairing on web or mobile application has failed', 'ManualPairFailedSMS', NULL, 'Your pairing request for reference number <REFERENCE_ID> is not paired. The pairing details are\n<Pair>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user request for manual pairing is accepted successfully for further processsing', 'HTTP_RESP_REQUEST_ACCEPTED', NULL, 'Your request has been accepted. The OTP has been sent to your Contact Number / Email ID for reference number <REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user request to resend the OTP again', 'HTTP_RESP_RESEND_OTP', NULL, 'OTP has been resent for reference number <REFERENCE_ID> on your Contact Number / Email ID', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide IMEI of VIP user  in the manual pairing request which does not require pairing.', 'HTTP_RESP_EXCEPTION_LIST_VIP_NO_PAIR_REQUIRED', NULL, 'No Need to pair as Found in Exception list as VIP', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide IMEI pair is present in exception list  in the manual pairing request which does not require pairing.', 'HTTP_RESP_EXCEPTION_LIST_NON_VIP_NO_PAIR_REQUIRED', NULL, 'No Need to pair as Found in Exception list as NON VIP', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Mail Subject send to public user when public user request to repair the IMEI is accepted successfully for further processing', 'ManualPairRepairSubject', NULL, 'Repaired Notification <REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Mail Subject send to public user when public user request to pair the IMEI is accepted successfully for further processing', 'ManualPairSubject', NULL, 'Paired Notification <REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Mail Subject send to public user when public user request to pair the IMEI is accepted successfully for further processing', 'ManualPairOtpSubject', NULL, 'OTP for Reference Number <REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES (NULL, 'HTTP_RESP_REQUEST_ALREADY_PROCESSED', NULL, 'Request Number <REFERENCE_ID> already processed. Not resending Otp', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user exhaust all the OTP resend limit in the manual pairing request ', 'HTTP_RESP_OTP_VALIDATION_FAIL_MAX_RETRY', NULL, 'Otp validation limit Exhausted for Request No:<REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user send a repair request for an non-existent pair.', 'HTTP_RESP_PAIR_NOT_FOUND_FAIL', NULL, 'Pairs Not found', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user enter wrong OTP  in the manual pairing request ', 'HTTP_RESP_OTP_VALIDATION_FAIL', NULL, 'Otp Invalid for Request No:<REFERENCE_ID>, left attempt:<OTP_COUNT_LEFT>', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user send a repair request for an non-existent pair.', 'HTTP_RESP_OLD_PAIR_NOT_FOUND_FAIL', NULL, 'Invalid Request, Pair not exist', 1, 'manual_pairing', NULL, 'system', 'system', 'en');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user request for repair is processed successfully.', 'HTTP_RESP_REPAIR_SUCCESS', NULL, 'The device is successfully Repaired', 1, 'manual_pairing', NULL, 'system', 'system', 'en');


INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to the public user when invalid  IMEI is auto paired by EIRS system', 'AutoPairGsmaInvalidSMS', NULL, '', 1, 'auto_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to the public user when valid but non tax paid IMEI is auto paired bt EIRS system', 'AutoPairGsmaValidSMS', NULL, '', 1, 'auto_pairing', NULL, 'system', 'system', 'km');	

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send validate the public user when public user send a request for manual pairing on web or mobile application', 'ManualPairOtpSMS', NULL, 'km- <OTP> is your OTP for manual pairing request. Never share your OTP with anyone', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email Notification send to validate the public user when public user send a request for manual pairing on web or mobile application', 'ManualPairOtpEmail', NULL, 'km- Hi,\n<OTP> is your OTP for manual pairing request. Never share your OTP with anyone', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to public user when public user request for manual pairing on web or mobile application is pair successfully', 'ManualPairSMS', NULL, 'km- Your pairing request for reference number <REFERENCE_ID> is paired successfully. The pairing details are as follow\n<Pair>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email Notification send to public user when public user request for manual pairing on web or mobile application is processed successfully', 'ManualPairEmail', NULL, 'km- Hi,\nYour pairing request for reference number <REFERENCE_ID> is paired successfully. The pairing details are as follow\n<Pair>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to public user when public user request for  manual repair on web or mobile application is processed successfully', 'ManualPairRepairSMS', NULL, 'km- Your repair request with reference number <REFERENCE_ID> is repaired successfully. The new pair detail is\n<PAIR>.', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email, Notification send to public user when public user request for  manual repair on web or mobile application is processed successfully', 'ManualPairRepairEmail', NULL, 'km- Hi,\nYour repair request with reference number <REFERENCE_ID> is repaired successfully. The new pair detail is\n<PAIR>.', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provided IMEI not belonging to same device in the manual pairing request ', 'HTTP_RESP_FAIL_DEVICE_MODELS_ARE_NOT_SAME', NULL, 'km- All the provided IMEI do not belong to same device. Kindly check your IMEI.', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provided IMEI that does not need pairing  to be done in the manual pairing request ', 'HTTP_RESP_FAIL_DEVICE_TYPES_ARE_NOT_ALLOWED', NULL, 'km- There is no need to pair this device. This IMEI will work and does not require pairing.', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide custom duty paid IMEI that does not need pairing  to be done in the manual pairing request ', 'HTTP_RESP_OTP_CUSTOM_CHECKED_NO_PAIR_REQUIRED', NULL, 'km- This IMEI is part of  tax paid device. This IMEI will work and does not require pairing.', 1, 'manual_pairing',NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide already paired IMEI pair in the manual pairing request ', 'HTTP_RESP_ALREADY_PAIRED', NULL, 'km- Pair already exists between the IMEI and MSISDN', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide duplicate  IMEI in the manual pairing request ', 'HTTP_RESP_DUPLICATE_IMEI_FAIL', NULL, 'km- IMEI is found to be duplicate. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide stolen or lost  IMEI in the manual pairing request ', 'HTTP_RESP_BLACKLIST_IMEI_FAIL', NULL, 'km- IMEI is found to be stolen or lost. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide stolen or lost  IMEI in the manual pairing request ', 'HTTP_RESP_GREYLIST_IMEI_FAIL', NULL, 'km- IMEI is found to be stolen or lost. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide IMEI in the manual pairing request whose limit is already exhausted', 'HTTP_RESP_PAIR_COUNT_LIMIT_FAIL', NULL, 'km- Pair limit for this IMEI has been exhausted. Hence this IMEI cannot be paired further.', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language) 
VALUES ('Message displayed on web/mobile application to public user when public user provide  IMEI of special category  in the manual pairing request which does not require pairing.', 'HTTP_RESP_NWL_NO_PAIR_REQUIRED', NULL, 'km- No Need to pair as Found in Exception list as VIP', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide invalid IMEI in the manual pairing request ', 'HTTP_RESP_INVALID_IMEI_FAIL', NULL, 'km- IMEI is found to be invalid. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide non GSMA approved IMEI in the manual pairing request ', 'HTTP_RESP_FAIL_GSMA_INVALID', NULL, 'km- IMEI is found to be GSMA non-compliant. Hence this IMEI cannot be paired', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide correct OTP', 'HTTP_RESP_OTP_VALIDATION_SUCCESS', NULL, 'km- OTP validation completed successfully', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to the public user when request sent by public user has failed  for manual pairing ', 'ManualPairRepairFailedSMS', NULL, 'km- Your repair request  for reference number <REFERENCE_ID> has failed.', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email Notification send to public user when public user request for  manual repair on web or mobile application has failed', 'ManualPairRepairFailedEmail', NULL, 'km- Hi,\nYour repair request  for reference number <REFERENCE_ID> has failed.', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Email Notification send to public user when public user request for  manual pairing on web or mobile application has failed', 'ManualPairFailedEmail', NULL, 'km- Hi,\nYour pairing request for reference number <REFERENCE_ID> is not paired. The pairing details are\n<Pair>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('SMS Notification send to public user when public user request for  manual pairing on web or mobile application has failed', 'ManualPairFailedSMS', NULL, 'km- Your pairing request for reference number <REFERENCE_ID> is not paired. The pairing details are\n<Pair>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user request for manual pairing is accepted successfully for further processsing', 'HTTP_RESP_REQUEST_ACCEPTED', NULL, 'km- Your request has been accepted. The OTP has been sent to your Contact Number / Email ID for reference number <REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user request to resend the OTP again', 'HTTP_RESP_RESEND_OTP', NULL, 'km- OTP has been resent for reference number <REFERENCE_ID> on your Contact Number / Email ID', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide IMEI of VIP user  in the manual pairing request which does not require pairing.', 'HTTP_RESP_EXCEPTION_LIST_VIP_NO_PAIR_REQUIRED', NULL, 'km- No Need to pair as Found in Exception list as VIP', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user provide IMEI pair is present in exception list  in the manual pairing request which does not require pairing.', 'HTTP_RESP_EXCEPTION_LIST_NON_VIP_NO_PAIR_REQUIRED', NULL, 'km- No Need to pair as Found in Exception list as NON VIP', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Mail Subject send to public user when public user request to repair the IMEI is accepted successfully for further processing', 'ManualPairRepairSubject', NULL, 'km- Repaired Notification <REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Mail Subject send to public user when public user request to pair the IMEI is accepted successfully for further processing', 'ManualPairSubject', NULL, 'km- Paired Notification <REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Mail Subject send to public user when public user request to pair the IMEI is accepted successfully for further processing', 'ManualPairOtpSubject', NULL, 'km- OTP for Reference Number <REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES (NULL, 'HTTP_RESP_REQUEST_ALREADY_PROCESSED', NULL, 'km- Request Number <REFERENCE_ID> already processed. Not resending Otp', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user exhaust all the OTP resend limit in the manual pairing request ', 'HTTP_RESP_OTP_VALIDATION_FAIL_MAX_RETRY', NULL, 'km- Otp validation limit Exhausted for Request No:<REFERENCE_ID>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user send a repair request for an non-existent pair.', 'HTTP_RESP_PAIR_NOT_FOUND_FAIL', NULL, 'km- Pairs Not found', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user enter wrong OTP  in the manual pairing request ', 'HTTP_RESP_OTP_VALIDATION_FAIL', NULL, 'km- Otp Invalid for Request No:<REFERENCE_ID>, left attempt:<OTP_COUNT_LEFT>', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user send a repair request for an non-existent pair.', 'HTTP_RESP_OLD_PAIR_NOT_FOUND_FAIL', NULL, 'km- Invalid Request, Pair not exist', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

INSERT IGNORE INTO eirs_response_param (description, tag, type, value, active, feature_name, remark, user_type, modified_by, language)
VALUES ('Message displayed on web/mobile application to public user when public user request for repair is processed successfully.', 'HTTP_RESP_REPAIR_SUCCESS', NULL, 'km- The device is successfully Repaired', 1, 'manual_pairing', NULL, 'system', 'system', 'km');

EOFMYSQL`

echo "DB Script Execution Completed"
