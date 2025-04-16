SELECT session_id, host_name, program_name,
JSON_ARRAY(session_id,host_name, program_name) jsonArray,
JSON_OBJECT('sessionId': session_id, 'hostName': host_name, 'programName':program_name) as jsonObject
FROM sys.dm_exec_sessions 
WHERE is_user_process = 1;
