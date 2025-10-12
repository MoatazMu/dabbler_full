# profile_audit_log

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| table_name | text | NO |
| action | text | NO |
| changed_at | timestamp with time zone | NO |
| changed_by | uuid | YES |
| changed_to | jsonb | YES |
