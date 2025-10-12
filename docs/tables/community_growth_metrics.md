# community_growth_metrics

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| metric_week | date | NO |
| total_groups | integer | YES |
| active_groups | integer | YES |
| total_members | integer | YES |
| weekly_active_members | integer | YES |
| events_created | integer | YES |
| event_participants | integer | YES |
| event_completion_rate | numeric | YES |
| metrics_by_region | jsonb | YES |
| metrics_by_sport | jsonb | YES |
| created_at | timestamp with time zone | NO |
