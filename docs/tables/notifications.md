# notifications

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| title | text | NO |
| message | text | NO |
| type | text | NO |
| priority | text | NO |
| is_read | boolean | YES |
| data | jsonb | YES |
| image_url | text | YES |
| action_text | text | YES |
| action_route | text | YES |
| read_at | timestamp with time zone | YES |
| created_at | timestamp with time zone | YES |
| updated_at | timestamp with time zone | YES |
