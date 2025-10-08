create table profile_metrics
(
    id                        uuid                     default gen_random_uuid()            not null
        primary key,
    metric_date               date                                                          not null,
    total_profiles            integer                  default 0,
    completed_profiles        integer                  default 0,
    active_users_daily        integer                  default 0,
    active_users_weekly       integer                  default 0,
    new_profiles_count        integer                  default 0,
    avg_completion_percentage numeric(5, 2)            default 0,
    avg_sports_per_user       numeric(5, 2)            default 0,
    created_at                timestamp with time zone default timezone('utc'::text, now()) not null
);

alter table profile_metrics
    owner to postgres;

create unique index idx_profile_metrics_date
    on profile_metrics (metric_date);

grant delete, insert, references, select, trigger, truncate, update on profile_metrics to anon;

grant delete, insert, references, select, trigger, truncate, update on profile_metrics to authenticated;

grant delete, insert, references, select, trigger, truncate, update on profile_metrics to service_role;

