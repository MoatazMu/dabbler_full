create table user_feed_cache
(
    id              uuid                     default gen_random_uuid()            not null
        primary key,
    user_id         uuid                                                          not null
        references profiles
            on delete cascade,
    post_id         uuid                                                          not null
        references posts
            on delete cascade,
    relevance_score double precision                                              not null,
    cached_at       timestamp with time zone default timezone('utc'::text, now()) not null,
    constraint unique_user_post_cache
        unique (user_id, post_id)
);

alter table user_feed_cache
    owner to postgres;

create index idx_user_feed_cache_user_score
    on user_feed_cache (user_id asc, relevance_score desc);

create index idx_user_feed_cache_cached_at
    on user_feed_cache (cached_at);

grant delete, insert, references, select, trigger, truncate, update on user_feed_cache to anon;

grant delete, insert, references, select, trigger, truncate, update on user_feed_cache to authenticated;

grant delete, insert, references, select, trigger, truncate, update on user_feed_cache to service_role;

