# community_events

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| group_id | uuid | YES |
| organizer_id | uuid | NO |
| sport_id | uuid | YES |
| venue_id | uuid | YES |
| title | text | NO |
| description | text | YES |
| type | USER-DEFINED | NO |
| status | USER-DEFINED | YES |
| start_date | timestamp with time zone | NO |
| end_date | timestamp with time zone | NO |
| registration_deadline | timestamp with time zone | YES |
| min_participants | integer | YES |
| max_participants | integer | YES |
| current_participants | integer | YES |
| skill_level_min | integer | YES |
| skill_level_max | integer | YES |
| age_min | integer | YES |
| age_max | integer | YES |
| gender_restriction | text | YES |
| is_free | boolean | YES |
| entry_fee | numeric | YES |
| currency | text | YES |
| has_prizes | boolean | YES |
| prizes | jsonb | YES |
| rules | text | YES |
| equipment_required | ARRAY | YES |
| cover_image_url | text | YES |
| gallery_urls | ARRAY | YES |
| is_public | boolean | YES |
| requires_approval | boolean | YES |
| allow_waitlist | boolean | YES |
| view_count | integer | YES |
| share_count | integer | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
