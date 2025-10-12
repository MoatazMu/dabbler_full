# social_notifications

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| type | text | NO |
| actor_id | uuid | YES |
| post_id | uuid | YES |
| comment_id | uuid | YES |
| friendship_id | uuid | YES |
| conversation_id | uuid | YES |
| title | text | NO |
| body | text | YES |
| data | jsonb | YES |
| is_read | boolean | YES |
| read_at | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
