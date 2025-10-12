# community_analytics

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| group_id | uuid | YES |
| metric_date | date | NO |
| total_members | integer | YES |
| new_members | integer | YES |
| active_members | integer | YES |
| churned_members | integer | YES |
| events_created | integer | YES |
| events_completed | integer | YES |
| total_participants | integer | YES |
| average_event_size | numeric | YES |
| posts_created | integer | YES |
| comments_created | integer | YES |
| reactions_count | integer | YES |
| average_engagement_rate | numeric | YES |
| challenges_created | integer | YES |
| challenge_participants | integer | YES |
| challenge_completion_rate | numeric | YES |
| tournaments_hosted | integer | YES |
| tournament_participants | integer | YES |
| matches_played | integer | YES |
| growth_rate | numeric | YES |
| retention_rate | numeric | YES |
| created_at | timestamp with time zone | NO |
