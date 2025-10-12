# activity_log

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| activity_type | text | NO |
| activity_subtype | text | YES |
| title | text | NO |
| description | text | YES |
| venue | text | YES |
| amount | numeric | YES |
| currency | text | YES |
| points | integer | YES |
| status | text | YES |
| target_id | text | YES |
| target_type | text | YES |
| target_user_id | uuid | YES |
| target_user_name | text | YES |
| target_user_avatar | text | YES |
| count | integer | YES |
| metadata | jsonb | NO |
| action_route | text | YES |
| created_at | timestamp with time zone | NO |
