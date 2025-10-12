# friendships

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| user_id | uuid | NO |
| friend_id | uuid | NO |
| status | USER-DEFINED | NO |
| initiated_by | uuid | NO |
| became_friends_at | timestamp with time zone | YES |
| blocked_at | timestamp with time zone | YES |
| blocked_by | uuid | YES |
| message | text | YES |
| created_at | timestamp with time zone | NO |
| updated_at | timestamp with time zone | NO |
