# profile_feature_flags

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| feature_name | text | NO |
| is_enabled | boolean | YES |
| rollout_percentage | integer | YES |
| user_whitelist | ARRAY | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
