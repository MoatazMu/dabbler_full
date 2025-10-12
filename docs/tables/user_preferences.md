# user_preferences

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| preferred_game_types | ARRAY | YES |
| preferred_game_duration | integer | YES |
| preferred_team_size_min | integer | YES |
| preferred_team_size_max | integer | YES |
| preferred_radius_km | integer | YES |
| preferred_venues | ARRAY | YES |
| travel_willingness | text | YES |
| weekly_availability | jsonb | YES |
| advance_booking_days | integer | YES |
| last_minute_availability | boolean | YES |
| open_to_new_players | boolean | YES |
| preferred_age_range_min | integer | YES |
| preferred_age_range_max | integer | YES |
| preferred_gender_mix | text | YES |
| equipment_sharing | boolean | YES |
| coaching_interest | boolean | YES |
| tournament_interest | boolean | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
