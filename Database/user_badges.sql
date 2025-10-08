create table user_badges
(
    id             uuid                     default gen_random_uuid()            not null
        primary key,
    user_id        uuid                                                          not null
        references profiles
            on delete cascade,
    badge_id       uuid                                                          not null
        references badges,
    achievement_id uuid                                                          not null
        references achievements,
    tier           badge_tier                                                    not null,
    earned_at      timestamp with time zone default timezone('utc'::text, now()) not null,
    is_showcased   boolean                  default false,
    showcase_order integer,
    times_earned   integer                  default 1,
    constraint unique_user_badge
        unique (user_id, badge_id)
);

alter table user_badges
    owner to postgres;

create index idx_user_badges_user
    on user_badges (user_id);

create index idx_user_badges_showcased
    on user_badges (user_id, showcase_order)
    where (is_showcased = true);

create index idx_user_badges_user_earned_badge
    on user_badges (user_id asc, earned_at desc, badge_id asc);

grant delete, insert, references, select, trigger, truncate, update on user_badges to anon;

grant delete, insert, references, select, trigger, truncate, update on user_badges to authenticated;

grant delete, insert, references, select, trigger, truncate, update on user_badges to service_role;

