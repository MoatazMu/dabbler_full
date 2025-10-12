# password_reset_attempts

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| email | text | NO |
| ip_address | inet | YES |
| status | text | YES |
| token_hash | text | YES |
| attempted_at | timestamp with time zone | YES |
| completed_at | timestamp with time zone | YES |
| expires_at | timestamp with time zone | YES |
