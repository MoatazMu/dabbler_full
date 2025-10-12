# user_sports_profiles

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| sport_id | uuid | NO |
| skill_level | integer | YES |
| years_playing | integer | YES |
| preferred_positions | ARRAY | YES |
| certifications | ARRAY | YES |
| achievements | ARRAY | YES |
| is_primary_sport | boolean | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
