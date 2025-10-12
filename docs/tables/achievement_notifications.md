# achievement_notifications

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| achievement_id | uuid | NO |
| notification_type | text | YES |
| title | text | NO |
| message | text | YES |
| is_read | boolean | YES |
| read_at | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
