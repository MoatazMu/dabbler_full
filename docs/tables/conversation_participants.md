# conversation_participants

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| conversation_id | uuid | NO |
| user_id | uuid | NO |
| role | text | YES |
| last_read_message_id | uuid | YES |
| last_read_at | timestamp with time zone | YES |
| is_muted | boolean | YES |
| muted_until | timestamp with time zone | YES |
| joined_at | timestamp with time zone | NO |
| left_at | timestamp with time zone | YES |
