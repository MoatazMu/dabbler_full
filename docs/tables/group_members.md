# group_members

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| group_id | uuid | NO |
| user_id | uuid | NO |
| role | text | YES |
| status | text | YES |
| can_create_events | boolean | YES |
| can_invite_members | boolean | YES |
| can_moderate_content | boolean | YES |
| contribution_score | integer | YES |
| last_active | timestamp with time zone | YES |
| joined_at | timestamp with time zone | NO |
| left_at | timestamp with time zone | YES |
