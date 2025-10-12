# post_comments__old

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| post_id | uuid | NO |
| author_id | uuid | NO |
| content | text | NO |
| parent_comment_id | uuid | YES |
| created_at | timestamp with time zone | YES |
| updated_at | timestamp with time zone | YES |
