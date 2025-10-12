# users

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| email | text | NO |
| display_name | text | YES |
| created_at | timestamp with time zone | NO |
| age | integer | YES |
| intent | USER-DEFINED | YES |
| avatar_url | text | YES |
| updated_at | timestamp with time zone | YES |
| sports | ARRAY | YES |
| phone | text | YES |
| phone_confirmed_at | timestamp with time zone | YES |
| email_confirmed_at | timestamp with time zone | YES |
| last_sign_in_at | timestamp with time zone | YES |
| is_anonymous | boolean | YES |
| onboarding_completed | boolean | NO |
| onboarding_step | text | NO |
| language | text | YES |
| timezone | text | YES |
| notification_settings | jsonb | YES |
| privacy_settings | jsonb | YES |
| skill_level | text | YES |
| games_played | integer | YES |
| bio | text | YES |
| date_of_birth | date | YES |
| is_profile_complete | boolean | YES |
| is_email_verified | boolean | YES |
| is_phone_verified | boolean | YES |
| profile_completion_percentage | integer | YES |
| gender | USER-DEFINED | YES |
| auth_id | uuid | NO |
