# profile_audit

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| table_name | text | NO |
| action | text | NO |
| changed_at | timestamp with time zone | NO |
| changed_by | uuid | YES |
| old_data | jsonb | YES |
| new_data | jsonb | YES |
