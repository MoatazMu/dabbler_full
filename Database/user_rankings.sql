create table user_rankings
(
    id               uuid                     default gen_random_uuid()            not null
        primary key,
    user_id          uuid                                                          not null
        references profiles
            on delete cascade,
    leaderboard_type leaderboard_type                                              not null,
    sport_id         uuid
        references sports,
    time_period      text,
    rank             integer                                                       not null,
    total_points     integer                                                       not null,
    movement         integer                  default 0,
    previous_rank    integer,
    updated_at       timestamp with time zone default timezone('utc'::text, now()) not null,
    constraint unique_user_ranking
        unique (user_id, leaderboard_type, sport_id, time_period)
);

alter table user_rankings
    owner to postgres;

create index idx_user_rankings_user
    on user_rankings (user_id);

create index idx_user_rankings_rank
    on user_rankings (leaderboard_type, sport_id, time_period, rank);

grant delete, insert, references, select, trigger, truncate, update on user_rankings to anon;

grant delete, insert, references, select, trigger, truncate, update on user_rankings to authenticated;

grant delete, insert, references, select, trigger, truncate, update on user_rankings to service_role;

