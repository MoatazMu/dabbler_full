# point_transactions

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | YES |
| type | USER-DEFINED | NO |
| points | integer | NO |
| achievement_id | uuid | YES |
| game_id | uuid | YES |
| description | text | YES |
| metadata | jsonb | YES |
| multipliers_applied | jsonb | YES |
| final_points | integer | NO |
| balance_before | integer | NO |
| balance_after | integer | NO |
| created_at | timestamp with time zone | NO |
| created_date_utc | date | YES |
