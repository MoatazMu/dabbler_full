create table profile_views
(
    id               uuid                     default gen_random_uuid()            not null
        primary key,
    profile_id       uuid                                                          not null
        references profiles
            on delete cascade,
    viewer_id        uuid
                                                                                   references profiles
                                                                                       on delete set null,
    viewed_at        timestamp with time zone default timezone('utc'::text, now()) not null,
    source           text
        constraint profile_views_source_check
            check (source = ANY (ARRAY ['search'::text, 'game'::text, 'friend'::text, 'direct'::text])),
    duration_seconds integer
);

alter table profile_views
    owner to postgres;

create index idx_profile_views_profile_date
    on profile_views (profile_id asc, viewed_at desc);

create index idx_profile_views_viewer
    on profile_views (viewer_id);

grant delete, insert, references, select, trigger, truncate, update on profile_views to anon;

grant delete, insert, references, select, trigger, truncate, update on profile_views to authenticated;

grant delete, insert, references, select, trigger, truncate, update on profile_views to service_role;

