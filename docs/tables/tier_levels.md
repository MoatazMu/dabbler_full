# tier_levels

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| level | integer | NO |
| name | text | NO |
| description | text | YES |
| icon_url | text | YES |
| color_hex | text | YES |
| min_points | integer | NO |
| max_points | integer | NO |
| benefits | jsonb | YES |
| privileges | jsonb | YES |
| created_at | timestamp with time zone | NO |
