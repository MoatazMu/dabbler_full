# profile_statistics

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| total_games_played | integer | YES |
| total_games_organized | integer | YES |
| total_wins | integer | YES |
| total_losses | integer | YES |
| total_draws | integer | YES |
| favorite_sport_id | uuid | YES |
| total_hours_played | numeric | YES |
| average_game_duration | integer | YES |
| longest_streak | integer | YES |
| current_streak | integer | YES |
| total_teammates | integer | YES |
| total_venues_visited | integer | YES |
| sportsmanship_rating | numeric | YES |
| reliability_rating | numeric | YES |
| achievements_unlocked | integer | YES |
| badges_earned | ARRAY | YES |
| last_game_date | date | YES |
| last_active | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
