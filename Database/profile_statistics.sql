create table profile_statistics
(
    id                    uuid                     default gen_random_uuid()            not null
        primary key,
    user_id               uuid                                                          not null
        unique
        references profiles
            on delete cascade,
    total_games_played    integer                  default 0,
    total_games_organized integer                  default 0,
    total_wins            integer                  default 0,
    total_losses          integer                  default 0,
    total_draws           integer                  default 0,
    favorite_sport_id     uuid
        references sports,
    total_hours_played    numeric                  default 0,
    average_game_duration integer                  default 0,
    longest_streak        integer                  default 0,
    current_streak        integer                  default 0,
    total_teammates       integer                  default 0,
    total_venues_visited  integer                  default 0,
    sportsmanship_rating  numeric(3, 2)            default 5.0,
    reliability_rating    numeric(3, 2)            default 5.0,
    achievements_unlocked integer                  default 0,
    badges_earned         text[]                   default ARRAY []::text[],
    last_game_date        date,
    last_active           timestamp with time zone default timezone('utc'::text, now()),
    created_at            timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at            timestamp with time zone default timezone('utc'::text, now()) not null
);

alter table profile_statistics
    owner to postgres;

create index idx_profile_statistics_user_id
    on profile_statistics (user_id);

create index idx_profile_statistics_last_active
    on profile_statistics (last_active desc);

grant delete, insert, references, select, trigger, truncate, update on profile_statistics to anon;

grant delete, insert, references, select, trigger, truncate, update on profile_statistics to authenticated;

grant delete, insert, references, select, trigger, truncate, update on profile_statistics to service_role;

