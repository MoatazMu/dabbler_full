# user_badges

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| badge_id | uuid | NO |
| achievement_id | uuid | NO |
| tier | USER-DEFINED | NO |
| earned_at | timestamp with time zone | NO |
| is_showcased | boolean | YES |
| showcase_order | integer | YES |
| times_earned | integer | YES |
