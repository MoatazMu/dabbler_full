# community_groups

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| name | text | NO |
| description | text | YES |
| type | USER-DEFINED | YES |
| status | USER-DEFINED | YES |
| sport_id | uuid | YES |
| region_id | uuid | YES |
| created_by | uuid | YES |
| max_members | integer | YES |
| min_age | integer | YES |
| max_age | integer | YES |
| skill_level_min | integer | YES |
| skill_level_max | integer | YES |
| is_verified | boolean | YES |
| requires_approval | boolean | YES |
| is_visible | boolean | YES |
| allow_guest_view | boolean | YES |
| avatar_url | text | YES |
| cover_image_url | text | YES |
| member_count | integer | YES |
| event_count | integer | YES |
| activity_score | integer | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
