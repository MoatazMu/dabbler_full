# member_activity_log

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| group_id | uuid | NO |
| user_id | uuid | NO |
| activity_type | text | NO |
| activity_id | uuid | YES |
| points_earned | integer | YES |
| created_at | timestamp with time zone | NO |
