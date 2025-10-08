create table profile_feature_flags
(
    id                 uuid                     default gen_random_uuid()            not null
        primary key,
    feature_name       text                                                          not null
        unique,
    is_enabled         boolean                  default false,
    rollout_percentage integer                  default 0
        constraint profile_feature_flags_rollout_percentage_check
            check ((rollout_percentage >= 0) AND (rollout_percentage <= 100)),
    user_whitelist     uuid[]                   default ARRAY []::uuid[],
    created_at         timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at         timestamp with time zone default timezone('utc'::text, now()) not null
);

alter table profile_feature_flags
    owner to postgres;

grant delete, insert, references, select, trigger, truncate, update on profile_feature_flags to anon;

grant delete, insert, references, select, trigger, truncate, update on profile_feature_flags to authenticated;

grant delete, insert, references, select, trigger, truncate, update on profile_feature_flags to service_role;

INSERT INTO public.profile_feature_flags (id, feature_name, is_enabled, rollout_percentage, user_whitelist, created_at, updated_at) VALUES ('5f1a1121-ef93-4b8e-97c4-cbe76a1ab4dd', 'profile_analytics_dashboard', true, 100, '{}', '2025-08-14 14:11:58.153964 +00:00', '2025-08-14 14:11:58.153964 +00:00');
INSERT INTO public.profile_feature_flags (id, feature_name, is_enabled, rollout_percentage, user_whitelist, created_at, updated_at) VALUES ('6d44e5c5-0f64-4ffe-a1eb-da66667dd4bf', 'advanced_privacy_settings', true, 100, '{}', '2025-08-14 14:11:58.153964 +00:00', '2025-08-14 14:11:58.153964 +00:00');
INSERT INTO public.profile_feature_flags (id, feature_name, is_enabled, rollout_percentage, user_whitelist, created_at, updated_at) VALUES ('dc640694-f422-4303-896c-91a1cebb066e', 'profile_badges', false, 0, '{}', '2025-08-14 14:11:58.153964 +00:00', '2025-08-14 14:11:58.153964 +00:00');
INSERT INTO public.profile_feature_flags (id, feature_name, is_enabled, rollout_percentage, user_whitelist, created_at, updated_at) VALUES ('d9d98e80-66b7-4878-954c-f56c155e1438', 'skill_verification', false, 0, '{}', '2025-08-14 14:11:58.153964 +00:00', '2025-08-14 14:11:58.153964 +00:00');
INSERT INTO public.profile_feature_flags (id, feature_name, is_enabled, rollout_percentage, user_whitelist, created_at, updated_at) VALUES ('1d3b0fd3-fece-4aa5-b61c-891fe27c0f6e', 'profile_themes', false, 0, '{}', '2025-08-14 14:11:58.153964 +00:00', '2025-08-14 14:11:58.153964 +00:00');
