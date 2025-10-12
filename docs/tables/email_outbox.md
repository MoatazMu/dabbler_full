# email_outbox

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| to_email | text | NO |
| subject | text | NO |
| body | text | NO |
| status | text | NO |
| created_at | timestamp with time zone | NO |
| sent_at | timestamp with time zone | YES |
| fail_reason | text | YES |
