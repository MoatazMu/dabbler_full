# player_ratings

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| game_id | uuid | NO |
| rater_id | uuid | YES |
| rated_player_id | uuid | YES |
| skill_rating | integer | YES |
| sportsmanship_rating | integer | YES |
| punctuality_rating | integer | YES |
| overall_rating | integer | YES |
| comment | text | YES |
| created_at | timestamp with time zone | NO |
