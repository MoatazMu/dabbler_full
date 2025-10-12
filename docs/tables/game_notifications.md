# game_notifications

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| game_id | uuid | NO |
| recipient_id | uuid | NO |
| type | text | NO |
| title | text | NO |
| message | text | NO |
| is_read | boolean | YES |
| sent_at | timestamp with time zone | NO |
| read_at | timestamp with time zone | YES |
| metadata | jsonb | YES |
