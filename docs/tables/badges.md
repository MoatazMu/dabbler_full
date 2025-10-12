# badges

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| achievement_id | uuid | NO |
| tier | USER-DEFINED | NO |
| name | text | NO |
| description | text | YES |
| icon_url | text | NO |
| design_metadata | jsonb | YES |
| unlock_message | text | YES |
| rarity_score | integer | YES |
| created_at | timestamp with time zone | NO |
