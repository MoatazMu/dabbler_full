# messages

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| conversation_id | uuid | NO |
| sender_id | uuid | YES |
| content | text | YES |
| media_urls | ARRAY | YES |
| reply_to_message_id | uuid | YES |
| is_edited | boolean | YES |
| edited_at | timestamp with time zone | YES |
| is_deleted | boolean | YES |
| deleted_at | timestamp with time zone | YES |
| delivered_to | ARRAY | YES |
| read_by | ARRAY | YES |
| created_at | timestamp with time zone | NO |
| topic | text | YES |
