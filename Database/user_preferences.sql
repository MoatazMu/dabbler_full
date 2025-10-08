create table user_preferences
(
    id                       uuid                     default gen_random_uuid()            not null
        primary key,
    user_id                  uuid                                                          not null
        unique
        references profiles
            on delete cascade,
    preferred_game_types     text[]                   default ARRAY ['casual'::text, 'competitive'::text],
    preferred_game_duration  integer                  default 60,
    preferred_team_size_min  integer                  default 2,
    preferred_team_size_max  integer                  default 10,
    preferred_radius_km      integer                  default 10,
    preferred_venues         text[],
    travel_willingness       text                     default 'medium'::text
        constraint user_preferences_travel_willingness_check
            check (travel_willingness = ANY (ARRAY ['low'::text, 'medium'::text, 'high'::text])),
    weekly_availability      jsonb                    default '{}'::jsonb,
    advance_booking_days     integer                  default 7,
    last_minute_availability boolean                  default true,
    open_to_new_players      boolean                  default true,
    preferred_age_range_min  integer,
    preferred_age_range_max  integer,
    preferred_gender_mix     text                     default 'any'::text
        constraint user_preferences_preferred_gender_mix_check
            check (preferred_gender_mix = ANY (ARRAY ['any'::text, 'same'::text, 'mixed'::text])),
    equipment_sharing        boolean                  default true,
    coaching_interest        boolean                  default false,
    tournament_interest      boolean                  default false,
    created_at               timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at               timestamp with time zone default timezone('utc'::text, now()) not null
);

alter table user_preferences
    owner to postgres;

grant delete, insert, references, select, trigger, truncate, update on user_preferences to anon;

grant delete, insert, references, select, trigger, truncate, update on user_preferences to authenticated;

grant delete, insert, references, select, trigger, truncate, update on user_preferences to service_role;

