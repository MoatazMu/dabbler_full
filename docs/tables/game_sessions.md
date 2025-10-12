# game_sessions

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| game_id | uuid | NO |
| status | text | YES |
| actual_start_time | timestamp with time zone | YES |
| actual_end_time | timestamp with time zone | YES |
| team_a_score | integer | YES |
| team_b_score | integer | YES |
| weather_condition | text | YES |
| temperature | numeric | YES |
| notes | text | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
