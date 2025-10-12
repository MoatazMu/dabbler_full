# game_invitations

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| game_id | uuid | NO |
| inviter_id | uuid | NO |
| invitee_email | text | YES |
| invitee_phone | text | YES |
| invitee_id | uuid | YES |
| status | text | YES |
| message | text | YES |
| invited_at | timestamp with time zone | NO |
| responded_at | timestamp with time zone | YES |
| expires_at | timestamp with time zone | YES |
