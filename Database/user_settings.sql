create table user_settings
(
    id                   uuid                     default gen_random_uuid()            not null
        primary key,
    user_id              uuid                                                          not null
        unique
        references profiles
            on delete cascade,
    theme_mode           text                     default 'system'::text
        constraint user_settings_theme_mode_check
            check (theme_mode = ANY (ARRAY ['light'::text, 'dark'::text, 'system'::text])),
    language             text                     default 'en'::text,
    notification_enabled boolean                  default true,
    email_notifications  boolean                  default true,
    push_notifications   boolean                  default true,
    sms_notifications    boolean                  default false,
    two_factor_enabled   boolean                  default false,
    created_at           timestamp with time zone default timezone('utc'::text, now()) not null,
    updated_at           timestamp with time zone default timezone('utc'::text, now()) not null
);

alter table user_settings
    owner to postgres;

grant delete, insert, references, select, trigger, truncate, update on user_settings to anon;

grant delete, insert, references, select, trigger, truncate, update on user_settings to authenticated;

grant delete, insert, references, select, trigger, truncate, update on user_settings to service_role;

INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('aedff8e1-85a1-4056-81dd-2dd01f367757', '5366fef8-54a5-495e-a9bc-54db1791d4da', 'system', 'en', true, true, true, false, false, '2025-08-09 19:53:33.840161 +00:00', '2025-08-09 19:53:33.840161 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('eb58582f-fead-47e3-81c9-f82ec25017ed', '07a1bb0d-b9a0-4fff-bc87-4810a6167700', 'system', 'en', true, true, true, false, false, '2025-08-09 22:54:21.973126 +00:00', '2025-08-09 22:54:21.973126 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('ff3f5d3b-444e-48ae-a01e-a4f82f889842', 'c81a1653-ee21-443d-8eb1-ee91382f4bcb', 'system', 'en', true, true, true, false, false, '2025-08-09 23:41:55.032192 +00:00', '2025-08-09 23:41:55.032192 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('5ce354f1-9f44-4e76-a551-373f5e81c024', '39ee63cb-a0bc-4065-a5a4-c4c31751a8fe', 'system', 'en', true, true, true, false, false, '2025-08-09 23:58:09.234094 +00:00', '2025-08-09 23:58:09.234094 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('ba4de806-1b32-44a4-b09b-233b68c8dbfc', '0e6fb273-167b-4d0a-afb1-21131b6b1991', 'system', 'en', true, true, true, false, false, '2025-08-10 00:08:06.542307 +00:00', '2025-08-10 00:08:06.542307 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('71599a94-0b27-4c5b-ae7b-90c8e11002e4', 'e5f51ac5-d8aa-4b85-8ca7-5f85a9e75742', 'system', 'en', true, true, true, false, false, '2025-08-10 07:46:37.696490 +00:00', '2025-08-10 07:46:37.696490 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('122324bb-a3ea-42a5-9c3b-fc8d9e44b435', 'e0acddba-433b-420c-a7e8-7a4fc9658b7d', 'system', 'en', true, true, true, false, false, '2025-08-10 07:51:20.298550 +00:00', '2025-08-10 07:51:20.298550 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('7cad90d7-e5df-4f84-bb17-e996a0d36c87', '9f76edc1-371f-41d7-9c4e-107bbc68eeef', 'system', 'en', true, true, true, false, false, '2025-08-11 17:27:46.001312 +00:00', '2025-08-11 17:27:46.001312 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('a45b7358-26d5-42ff-8436-9ad56246d5e2', 'c3d4e786-764b-4f5c-bc05-8fe37ea653f5', 'system', 'en', true, true, true, false, false, '2025-08-11 17:36:39.898381 +00:00', '2025-08-11 17:36:39.898381 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('e617287b-d0ce-42fb-8515-27d182cb95f5', 'd7396bda-1420-43b5-99cd-a567f466ebd6', 'system', 'en', true, true, true, false, false, '2025-08-11 17:44:18.346204 +00:00', '2025-08-11 17:44:18.346204 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('a27f255d-c8c9-4cf5-bf84-3890e652bfd6', '9523fc4f-14ce-419d-9823-f867928bf5a3', 'system', 'en', true, true, true, false, false, '2025-08-11 18:10:22.088633 +00:00', '2025-08-11 18:10:22.088633 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('058464c4-abce-4680-8b12-34dde3625787', '51fe8e94-7dd2-45e9-b3d0-a15799f87fd4', 'system', 'en', true, true, true, false, false, '2025-08-11 18:36:29.072716 +00:00', '2025-08-11 18:36:29.072716 +00:00');
INSERT INTO public.user_settings (id, user_id, theme_mode, language, notification_enabled, email_notifications, push_notifications, sms_notifications, two_factor_enabled, created_at, updated_at) VALUES ('73db9b9b-23b8-44e2-be25-fa5ce3f4a98b', '62171403-6f59-4ad8-8da9-86c311fa15a3', 'system', 'en', true, true, true, false, false, '2025-08-11 19:14:32.062697 +00:00', '2025-08-11 19:14:32.062697 +00:00');
