# user_tier_progress

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| current_tier_id | uuid | NO |
| total_points | integer | YES |
| points_to_next_tier | integer | YES |
| tier_progress_percentage | numeric | YES |
| highest_tier_achieved | uuid | YES |
| tier_up_count | integer | YES |
| last_tier_up | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
