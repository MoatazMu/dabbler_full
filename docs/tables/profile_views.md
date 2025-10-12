# profile_views

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| profile_id | uuid | NO |
| viewer_id | uuid | YES |
| viewed_at | timestamp with time zone | NO |
| source | text | YES |
| duration_seconds | integer | YES |
