create table user_sports_profiles
(
    id                  uuid                     default gen_random_uuid()            not null
        primary key,
    user_id             uuid                                                          not null
        references profiles
            on delete cascade,
    sport_id            uuid                                                          not null
        references sports,
    skill_level         integer                  default 1
        references skill_levels (level),
    years_playing       integer                  default 0,
    preferred_positions text[],
    certifications      text[],
    achievements        text[],
    is_primary_sport    boolean                  default false,
    created_at          timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at          timestamp with time zone default timezone('utc'::text, now()) not null,
    unique (user_id, sport_id)
);

alter table user_sports_profiles
    owner to postgres;

create index idx_user_sports_profiles_user_sport
    on user_sports_profiles (user_id, sport_id);

create index idx_user_sports_profiles_skill
    on user_sports_profiles (skill_level);

grant delete, insert, references, select, trigger, truncate, update on user_sports_profiles to anon;

grant delete, insert, references, select, trigger, truncate, update on user_sports_profiles to authenticated;

grant delete, insert, references, select, trigger, truncate, update on user_sports_profiles to service_role;

