# community_challenges

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| group_id | uuid | YES |
| created_by | uuid | YES |
| title | text | NO |
| description | text | YES |
| type | USER-DEFINED | NO |
| status | USER-DEFINED | YES |
| start_date | timestamp with time zone | NO |
| end_date | timestamp with time zone | NO |
| metric_type | text | NO |
| target_value | numeric | NO |
| unit | text | YES |
| min_participants | integer | YES |
| max_participants | integer | YES |
| current_participants | integer | YES |
| sport_id | uuid | YES |
| skill_level_min | integer | YES |
| skill_level_max | integer | YES |
| region_id | uuid | YES |
| has_rewards | boolean | YES |
| reward_points | integer | YES |
| reward_badges | ARRAY | YES |
| custom_rewards | jsonb | YES |
| rules | text | YES |
| verification_method | text | YES |
| allow_team_participation | boolean | YES |
| team_size_min | integer | YES |
| team_size_max | integer | YES |
| banner_image_url | text | YES |
| icon_url | text | YES |
| total_progress | numeric | YES |
| completion_rate | numeric | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
