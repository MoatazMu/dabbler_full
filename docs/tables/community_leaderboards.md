# community_leaderboards

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| name | text | NO |
| category | USER-DEFINED | NO |
| period | USER-DEFINED | NO |
| group_id | uuid | YES |
| sport_id | uuid | YES |
| region_id | uuid | YES |
| challenge_id | uuid | YES |
| tournament_id | uuid | YES |
| skill_level_min | integer | YES |
| skill_level_max | integer | YES |
| age_min | integer | YES |
| age_max | integer | YES |
| period_start | date | NO |
| period_end | date | NO |
| min_activities | integer | YES |
| scoring_method | text | YES |
| is_active | boolean | YES |
| last_calculated | timestamp with time zone | YES |
| next_calculation | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
