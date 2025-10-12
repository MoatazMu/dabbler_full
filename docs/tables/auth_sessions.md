# auth_sessions

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| device_id | text | NO |
| device_name | text | YES |
| device_type | text | YES |
| ip_address | inet | YES |
| user_agent | text | YES |
| is_active | boolean | YES |
| last_activity | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
| expires_at | timestamp with time zone | YES |
