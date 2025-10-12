# tournament_matches

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| tournament_id | uuid | NO |
| round_number | integer | NO |
| match_number | integer | NO |
| participant1_id | uuid | YES |
| participant2_id | uuid | YES |
| scheduled_time | timestamp with time zone | YES |
| actual_start_time | timestamp with time zone | YES |
| actual_end_time | timestamp with time zone | YES |
| status | text | YES |
| participant1_score | integer | YES |
| participant2_score | integer | YES |
| winner_id | uuid | YES |
| venue_court | text | YES |
| referee_id | uuid | YES |
| notes | text | YES |
| next_match_id | uuid | YES |
| next_match_position | integer | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
