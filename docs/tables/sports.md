# sports

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| name | text | NO |
| code | text | NO |
| icon_url | text | YES |
| min_players | integer | NO |
| max_players | integer | NO |
| default_duration | integer | YES |
| requires_venue | boolean | YES |
| is_team_sport | boolean | YES |
| is_active | boolean | YES |
| created_at | timestamp with time zone | NO |
| icon_name | text | YES |
| category | text | YES |
| player_count_min | integer | YES |
| player_count_max | integer | YES |
