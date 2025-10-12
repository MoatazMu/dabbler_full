# comments

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| post_id | uuid | NO |
| author_id | uuid | NO |
| parent_comment_id | uuid | YES |
| content | text | NO |
| likes_count | integer | YES |
| is_deleted | boolean | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
