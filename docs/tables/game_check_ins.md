# game_check_ins

| column | type | nullable |
|---|---|---|
| id | uuid | NO |
| game_id | uuid | NO |
| player_id | uuid | NO |
| check_in_time | timestamp with time zone | NO |
| check_in_method | text | YES |
| location_latitude | double precision | YES |
| location_longitude | double precision | YES |
| device_id | text | YES |
