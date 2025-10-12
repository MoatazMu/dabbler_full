# leaderboards

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| type | USER-DEFINED | NO |
| sport_id | uuid | YES |
| time_period | text | YES |
| entries | jsonb | YES |
| last_calculated | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
