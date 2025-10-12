# challenge_progress_updates

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| participant_id | uuid | NO |
| value_added | numeric | NO |
| new_total | numeric | NO |
| evidence_type | text | YES |
| evidence_id | uuid | YES |
| evidence_url | text | YES |
| is_verified | boolean | YES |
| verified_by | uuid | YES |
| notes | text | YES |
| created_at | timestamp with time zone | NO |
