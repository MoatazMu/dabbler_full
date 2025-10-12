# games

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| title | text | NO |
| description | text | YES |
| sport_id | uuid | NO |
| venue_id | uuid | YES |
| organizer_id | uuid | NO |
| scheduled_date | date | NO |
| start_time | time without time zone | NO |
| end_time | time without time zone | NO |
| min_players | integer | NO |
| max_players | integer | NO |
| current_players | integer | YES |
| skill_level_id | uuid | YES |
| price_per_player | numeric | YES |
| currency | text | YES |
| status | text | YES |
| is_public | boolean | YES |
| allows_waitlist | boolean | YES |
| check_in_enabled | boolean | YES |
| cancellation_deadline | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
| sport | text | YES |
| skill_level | text | YES |
