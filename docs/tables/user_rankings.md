# user_rankings

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| leaderboard_type | USER-DEFINED | NO |
| sport_id | uuid | YES |
| time_period | text | YES |
| rank | integer | NO |
| total_points | integer | NO |
| movement | integer | YES |
| previous_rank | integer | YES |
| updated_at | timestamp with time zone | NO |
