# event_registrations

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| event_id | uuid | NO |
| user_id | uuid | NO |
| status | text | YES |
| team_name | text | YES |
| position | text | YES |
| notes | text | YES |
| payment_status | text | YES |
| payment_amount | numeric | YES |
| payment_date | timestamp with time zone | YES |
| checked_in | boolean | YES |
| checked_in_at | timestamp with time zone | YES |
| registered_at | timestamp with time zone | NO |
| cancelled_at | timestamp with time zone | YES |
