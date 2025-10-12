# user_achievements

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| achievement_id | uuid | NO |
| current_progress | jsonb | YES |
| required_progress | jsonb | YES |
| progress_percentage | numeric | YES |
| is_completed | boolean | YES |
| completed_at | timestamp with time zone | YES |
| completion_count | integer | YES |
| started_at | timestamp with time zone | NO |
| last_updated | timestamp with time zone | NO |
