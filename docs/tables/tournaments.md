# tournaments

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| event_id | uuid | YES |
| format | USER-DEFINED | NO |
| status | USER-DEFINED | YES |
| rounds | integer | YES |
| current_round | integer | YES |
| matches_per_round | integer | YES |
| points_for_win | integer | YES |
| points_for_draw | integer | YES |
| points_for_loss | integer | YES |
| is_seeded | boolean | YES |
| seeding_method | text | YES |
| match_duration_minutes | integer | YES |
| break_duration_minutes | integer | YES |
| rules_url | text | YES |
| bracket_data | jsonb | YES |
| total_matches | integer | YES |
| completed_matches | integer | YES |
| started_at | timestamp with time zone | YES |
| completed_at | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
