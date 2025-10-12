# users_backup

| column | type | nullable |
|---|---|---|
| id | uuid | YES |
| email | text | YES |
| display_name | text | YES |
| created_at | timestamp with time zone | YES |
| age | integer | YES |
| preferred_sports | ARRAY | YES |
| intent | USER-DEFINED | YES |
| avatar_url | text | YES |
| updated_at | timestamp with time zone | YES |
| sports | ARRAY | YES |
| phone | text | YES |
| phone_confirmed_at | timestamp with time zone | YES |
| phone_confirmed | boolean | YES |
| email_confirmed_at | timestamp with time zone | YES |
| last_sign_in_at | timestamp with time zone | YES |
| is_anonymous | boolean | YES |
| onboarding_completed | boolean | YES |
| onboarding_step | text | YES |
| language | text | YES |
| timezone | text | YES |
| notification_settings | jsonb | YES |
| privacy_settings | jsonb | YES |
| skill_level | text | YES |
| games_played | integer | YES |
| bio | text | YES |
