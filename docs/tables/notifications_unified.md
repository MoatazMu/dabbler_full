# notifications_unified

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| actor_id | uuid | YES |
| category | USER-DEFINED | NO |
| kind | text | NO |
| data | jsonb | NO |
| is_read | boolean | NO |
| created_at | timestamp with time zone | NO |
