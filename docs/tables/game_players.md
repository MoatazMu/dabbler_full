# game_players

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| game_id | uuid | NO |
| player_id | uuid | NO |
| status | text | YES |
| team | text | YES |
| position | text | YES |
| joined_at | timestamp with time zone | NO |
| checked_in_at | timestamp with time zone | YES |
| check_in_code | text | YES |
| player_rating | integer | YES |
| rated_at | timestamp with time zone | YES |
