# leaderboard_entries

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| leaderboard_id | uuid | NO |
| user_id | uuid | NO |
| rank | integer | NO |
| previous_rank | integer | YES |
| rank_change | integer | YES |
| score | numeric | NO |
| activities_count | integer | YES |
| wins_count | integer | YES |
| metrics | jsonb | YES |
| best_score | numeric | YES |
| best_score_date | date | YES |
| calculated_at | timestamp with time zone | NO |
