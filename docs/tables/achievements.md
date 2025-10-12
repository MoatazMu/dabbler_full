# achievements

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| code | text | NO |
| name | text | NO |
| description | text | NO |
| icon_url | text | YES |
| category | USER-DEFINED | NO |
| type | USER-DEFINED | NO |
| tier | USER-DEFINED | YES |
| points | integer | NO |
| criteria | jsonb | NO |
| prerequisite_achievement_ids | ARRAY | YES |
| is_active | boolean | YES |
| is_hidden | boolean | YES |
| is_repeatable | boolean | YES |
| max_repeats | integer | YES |
| available_from | timestamp with time zone | YES |
| available_until | timestamp with time zone | YES |
| display_order | integer | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
