# scheduled_rewards

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| reward_type | text | NO |
| scheduled_date | date | NO |
| points_amount | integer | YES |
| metadata | jsonb | YES |
| claimed | boolean | YES |
| claimed_at | timestamp with time zone | YES |
| expires_at | timestamp with time zone | YES |
| created_at | timestamp with time zone | NO |
