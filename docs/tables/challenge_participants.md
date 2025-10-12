# challenge_participants

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| challenge_id | uuid | NO |
| user_id | uuid | YES |
| team_id | uuid | YES |
| current_value | numeric | YES |
| progress_percentage | numeric | YES |
| is_completed | boolean | YES |
| completed_at | timestamp with time zone | YES |
| rank | integer | YES |
| previous_rank | integer | YES |
| last_update | timestamp with time zone | YES |
| update_count | integer | YES |
| is_verified | boolean | YES |
| verified_by | uuid | YES |
| verified_at | timestamp with time zone | YES |
| joined_at | timestamp with time zone | NO |
| left_at | timestamp with time zone | YES |
