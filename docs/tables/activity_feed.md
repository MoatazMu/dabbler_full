# activity_feed

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| kind | text | NO |
| title | text | NO |
| message | text | NO |
| action_route | text | YES |
| created_at | timestamp with time zone | NO |
| notification_id | uuid | YES |
| is_read | boolean | NO |
| read_at | timestamp with time zone | YES |
