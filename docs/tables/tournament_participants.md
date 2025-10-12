# tournament_participants

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| tournament_id | uuid | NO |
| user_id | uuid | YES |
| team_id | uuid | YES |
| display_name | text | NO |
| seed_number | integer | YES |
| skill_rating | integer | YES |
| current_round | integer | YES |
| is_eliminated | boolean | YES |
| final_position | integer | YES |
| matches_played | integer | YES |
| matches_won | integer | YES |
| matches_lost | integer | YES |
| matches_drawn | integer | YES |
| points_scored | integer | YES |
| points_conceded | integer | YES |
| total_points | integer | YES |
| registered_at | timestamp with time zone | NO |
| eliminated_at | timestamp with time zone | YES |
