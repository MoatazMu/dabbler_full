create table user_tier_progress
(
    id                       uuid                     default gen_random_uuid()            not null
        primary key,
    user_id                  uuid                                                          not null
        unique
        references profiles
            on delete cascade,
    current_tier_id          uuid                                                          not null
        references tier_levels,
    total_points             integer                  default 0,
    points_to_next_tier      integer,
    tier_progress_percentage numeric(5, 2)            default 0,
    highest_tier_achieved    uuid
        references tier_levels,
    tier_up_count            integer                  default 0,
    last_tier_up             timestamp with time zone,
    created_at               timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at               timestamp with time zone default timezone('utc'::text, now()) not null
);

alter table user_tier_progress
    owner to postgres;

create index idx_user_tier_progress_points
    on user_tier_progress (total_points desc);

create index idx_user_tier_progress_tier
    on user_tier_progress (current_tier_id);

grant delete, insert, references, select, trigger, truncate, update on user_tier_progress to anon;

grant delete, insert, references, select, trigger, truncate, update on user_tier_progress to authenticated;

grant delete, insert, references, select, trigger, truncate, update on user_tier_progress to service_role;

