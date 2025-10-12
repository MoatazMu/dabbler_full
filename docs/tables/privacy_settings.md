# privacy_settings

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| profile_visibility | text | YES |
| show_real_name | boolean | YES |
| show_email | boolean | YES |
| show_phone | boolean | YES |
| show_location | boolean | YES |
| show_age | boolean | YES |
| show_sports_stats | boolean | YES |
| show_game_history | boolean | YES |
| show_upcoming_games | boolean | YES |
| show_favorite_venues | boolean | YES |
| searchable | boolean | YES |
| allow_friend_requests | boolean | YES |
| allow_game_invites | boolean | YES |
| allow_messages | boolean | YES |
| share_analytics | boolean | YES |
| share_location_data | boolean | YES |
| marketing_emails | boolean | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
