# profiles_backup

| column | type | nullable |
|---|---|---|
| id | uuid | YES |
| email | text | YES |
| username | text | YES |
| full_name | text | YES |
| avatar_url | text | YES |
| phone_number | text | YES |
| date_of_birth | date | YES |
| bio | text | YES |
| is_profile_complete | boolean | YES |
| is_email_verified | boolean | YES |
| is_phone_verified | boolean | YES |
| created_at | timestamp with time zone | YES |
| updated_at | timestamp with time zone | YES |
| profile_completion_percentage | integer | YES |
| search_vector | tsvector | YES |
| display_name | text | YES |
