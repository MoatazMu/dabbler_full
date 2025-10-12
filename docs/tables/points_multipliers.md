# points_multipliers

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| code | text | NO |
| name | text | NO |
| description | text | YES |
| multiplier | numeric | NO |
| conditions | jsonb | NO |
| is_active | boolean | YES |
| valid_from | timestamp with time zone | YES |
| valid_until | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
