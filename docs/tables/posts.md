# posts

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| author_id | uuid | NO |
| type | USER-DEFINED | NO |
| content | text | YES |
| media_urls | ARRAY | YES |
| game_id | uuid | YES |
| sport_id | uuid | YES |
| achievement_type | text | YES |
| visibility | text | YES |
| likes_count | integer | YES |
| comments_count | integer | YES |
| shares_count | integer | YES |
| is_deleted | boolean | YES |
| deleted_at | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
| location_name | text | YES |
| tags | text | YES |
