# Goal
Read my generated schema and produce a clear mapping from database entities/columns to product features, API endpoints (edge functions/views), and UI integration points.

# Context (files to read in this workspace)
- docs/DB_SCHEMA.md
- docs/erd.mmd
- docs/tables/*.md
- lib/models/*.dart
- lib/repositories/*_repo.dart

# Deliverables
1) **Entity inventory**: List all public tables/views with a 1-line description of their likely purpose.
2) **Relationship sketch**: For each entity, list key FKs to other entities (name both sides) using the ERD and tables docs.
3) **Integration map** (MAIN OUTPUT): A table per entity showing:
   - Column
   - Type (from docs/tables/*.md)
   - Sensitive? (PII, auth-related, user-generated, payment)
   - Used in: (feature or screen name)
   - API surface: (existing repo method, edge function, or propose a new endpoint)
   - UI binding: (widget/screen + field)
   - Validation: (constraints/user input rules)
4) **RLS/View guidance**: Mark which columns should *not* be exposed publicly; recommend view names and policies per entity.
5) **Gaps**: Identify missing indexes, suspect legacy tables (e.g., *_backup, *_old), and columns to deprecate.

# Output Format
- Use Markdown.
- For each entity, generate a section with:
  - 2-sentence summary of the table
  - **Mapping table** with columns → integration points (see template below)
  - Notes: RLS, view suggestions, endpoint ideas, privacy

# Mapping table template (reuse per entity)

| column | type | sensitive? | used in (feature/screen) | API surface (repo/edge fn) | UI binding | validation |
|---|---|---|---|---|---|---|

# Examples to start with (fill these first)
- users (lib/models/users.dart, lib/repositories/users_repo.dart)
- games (lib/models/games.dart, lib/repositories/games_repo.dart)
- game_players (lib/models/game_players.dart)
- tournaments / tournament_matches / tournament_participants
- posts / post_comments / reactions
- notifications / notifications_unified
- user_rankings / leaderboards / leaderboard_entries
- user_preferences / privacy_settings / user_settings

# Notes
- Use the column types from docs/tables/*.md to infer validation and privacy.
- Prefer views (e.g., users_public) for public data; keep PII behind RLS.
- Propose endpoint names consistent with existing: e.g., public-users, public-games, public-tournaments.

---

## users

The `users` table stores information about the application users, including authentication details, profile information, and preferences. It is the core entity for user management and personalization.

| column                 | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|------------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id                     | uuid         |                 | Profile, settings, notifications| UsersRepo.getById, list         | Profile, Settings         | required, unique                  |
| email                  | text         | auth-related    | Authentication, profile       | UsersRepo.getById, list         | Profile, Settings         | required, unique                  |
| password_hash          | text         | auth-related    | Authentication                | UsersRepo.getById, list         | Profile, Settings         | required                          |
| full_name              | text         | user-generated  | Profile, settings             | UsersRepo.getById, list         | Profile, Settings         | max 100 chars, optional           |
| avatar_url             | text         | user-generated  | Profile, settings             | UsersRepo.getById, list         | Profile, Settings         | max 200 chars, optional           |
| bio                    | text         | user-generated  | Profile, settings             | UsersRepo.getById, list         | Profile, Settings         | max 500 chars, optional           |
| location               | text         | user-generated  | Profile, settings             | UsersRepo.getById, list         | Profile, Settings         | max 100 chars, optional           |
| website                | text         | user-generated  | Profile, settings             | UsersRepo.getById, list         | Profile, Settings         | max 100 chars, optional           |
| created_at             | timestamp    |                 | Profile, settings             | UsersRepo.getById, list         | Profile, Settings         | auto, not null                    |
| updated_at             | timestamp    |                 | Profile, settings             | UsersRepo.getById, list         | Profile, Settings         | auto, not null                    |
| last_login             | timestamp    |                 | Authentication, analytics     | UsersRepo.getById, list         | Profile, Settings         | optional                          |
| is_active              | boolean      |                 | Authentication, profile       | UsersRepo.getById, list         | Profile, Settings         | default true                      |
| is_verified            | boolean      |                 | Authentication, profile       | UsersRepo.getById, list         | Profile, Settings         | default false                     |
| preferences            | jsonb        | user-generated  | Settings, personalization     | UsersRepo.getById, list         | Profile, Settings         | json, optional                    |

**Notes:**
- RLS/View: Only expose (id, email, full_name, avatar_url, bio, location, website, created_at, updated_at) in `users_public`.
- Endpoints: `/public-users`, `/users` (private). GET params: id, email, q, since, limit, offset, order.
- Indexes: (email), (full_name), (location), (website).
- Passwords are hashed; use auth-related methods for verification.

---

## games

The `games` table contains information about the games available in the application, including metadata for game discovery and filtering. It supports various integrations for game details and user interactions.

| column             | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|--------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id                 | uuid         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | required, unique                  |
| title              | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | required, max 200 chars           |
| description        | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | max 1000 chars, optional          |
| release_date       | date         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | optional                          |
| developer          | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | max 100 chars, optional           |
| publisher          | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | max 100 chars, optional           |
| genre              | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | max 50 chars, optional            |
| platform           | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | max 50 chars, optional            |
| cover_image_url    | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | max 200 chars, optional           |
| trailer_url        | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | max 200 chars, optional           |
| website_url        | text         |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | max 200 chars, optional           |
| created_at         | timestamp    |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | auto, not null                    |
| updated_at         | timestamp    |                 | Game detail, discovery        | GamesRepo.getById, list         | GameDetail, GameCard     | auto, not null                    |
| tags                | text         | user-generated  | Filtering, discovery          | GamesRepo.getById, list         | GameDetail, GameCard     | comma-separated, optional         |

**Notes:**
- RLS/View: Only expose (id, title, description, release_date, developer, publisher, genre, platform, cover_image_url, trailer_url, website_url, created_at, updated_at) in `games_public`.
- Endpoints: `/public-games`, `/games` (private). GET params: id, title, genre, platform, since, limit, offset, order.
- Indexes: (title), (developer), (publisher), (genre), (platform).
- Consider adding full-text search on title and description.

---

## game_players

The `game_players` table tracks the relationship between users and games, including player statistics and metadata for game sessions. It enables personalized game recommendations and social features.

| column             | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|--------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id                 | uuid         |                 | Player profile, game detail   | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | required, unique                  |
| user_id            | uuid         | PII             | Player profile, game detail   | GamePlayersRepo.getById, list   | PlayerProfile, Profile    | FK users(id), required            |
| game_id            | uuid         |                 | Player profile, game detail   | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | FK games(id), required            |
| session_id         | uuid         |                 | Session tracking              | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | FK game_sessions(id), optional    |
| score               | numeric      |                 | Leaderboards, game detail     | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | >=0, required                     |
| rank                | integer      |                 | Leaderboards, game detail     | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | >=1, required                     |
| achievements       | jsonb        | user-generated  | Player profile, game detail   | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | json, optional                    |
| stats               | jsonb        | user-generated  | Player profile, game detail   | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | json, optional                    |
| created_at         | timestamp    |                 | Player profile, game detail   | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | auto, not null                    |
| updated_at         | timestamp    |                 | Player profile, game detail   | GamePlayersRepo.getById, list   | PlayerProfile, GameDetail | auto, not null                    |

**Notes:**
- RLS/View: Only expose (id, user_id, game_id, session_id, score, rank, created_at, updated_at) in `game_players_public`.
- Endpoints: `/public-game-players`, `/game-players` (private). GET params: id, user_id, game_id, session_id, since, limit, offset, order.
- Indexes: (user_id, game_id), (game_id, rank), (session_id).
- Consider adding a materialized view for leaderboard queries.

---

## tournaments

The `tournaments` table contains information about competitive events in which users can participate, including metadata for tournament discovery and management. It is central to the competitive gaming features.

| column             | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|--------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id                 | uuid         |                 | Tournament detail, discovery  | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | required, unique                  |
| name                | text         |                 | Tournament detail, discovery  | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | required, max 200 chars           |
| description        | text         |                 | Tournament detail, discovery  | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | max 1000 chars, optional          |
| sport_id           | uuid         |                 | Filtering, discovery          | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | FK sports(id), required           |
| game_id            | uuid         |                 | Filtering, discovery          | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | FK games(id), required            |
| start_time         | timestamp    |                 | Tournament schedule            | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | required                          |
| end_time           | timestamp    |                 | Tournament schedule            | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | required                          |
| location            | text         |                 | Tournament detail, discovery  | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | max 100 chars, optional           |
| prize_pool         | numeric      |                 | Tournament detail, discovery  | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | >=0, optional                     |
| rules               | jsonb        | user-generated  | Tournament detail, discovery  | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | json, optional                    |
| created_at         | timestamp    |                 | Tournament detail, discovery  | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | auto, not null                    |
| updated_at         | timestamp    |                 | Tournament detail, discovery  | TournamentsRepo.getById, list   | TournamentDetail, TournamentCard | auto, not null                    |

**Notes:**
- RLS/View: Only expose (id, name, description, sport_id, game_id, start_time, end_time, location, prize_pool, created_at, updated_at) in `tournaments_public`.
- Endpoints: `/public-tournaments`, `/tournaments` (private). GET params: id, name, sport_id, game_id, since, limit, offset, order.
- Indexes: (name), (sport_id, game_id, start_time), (end_time).
- Consider adding full-text search on name and description.

---

## tournament_matches

The `tournament_matches` table records the individual matches within tournaments, including participant scores and match outcomes. It is essential for detailed tournament analytics and reporting.

| column             | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|--------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id                 | uuid         |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | required, unique                  |
| tournament_id      | uuid         |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | FK tournaments(id), required     |
| team1_id           | uuid         |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | FK teams(id), required            |
| team2_id           | uuid         |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | FK teams(id), required            |
| score1              | numeric      |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | >=0, required                     |
| score2              | numeric      |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | >=0, required                     |
| status              | text         |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | enum (scheduled, completed, canceled), required |
| scheduled_time      | timestamp    |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | required                          |
| actual_time         | timestamp    |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | optional                          |
| created_at         | timestamp    |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | auto, not null                    |
| updated_at         | timestamp    |                 | Match detail, reporting       | TournamentMatchesRepo.getById, list | MatchDetail, TournamentDetail | auto, not null                    |

**Notes:**
- RLS/View: Only expose (id, tournament_id, team1_id, team2_id, score1, score2, status, scheduled_time, actual_time, created_at, updated_at) in `tournament_matches_public`.
- Endpoints: `/public-tournament-matches`, `/tournament-matches` (private). GET params: id, tournament_id, team1_id, team2_id, since, limit, offset, order.
- Indexes: (tournament_id, scheduled_time), (team1_id, team2_id).
- Consider adding a materialized view for match outcome predictions.

---

## tournament_participants

The `tournament_participants` table manages the relationship between tournaments and their participants, including team or player registrations and statuses. It is key for tournament enrollment and management.

| column             | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|--------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id                 | uuid         |                 | Participant detail, reporting | TournamentParticipantsRepo.getById, list | ParticipantDetail, TournamentDetail | required, unique                  |
| tournament_id      | uuid         |                 | Participant detail, reporting | TournamentParticipantsRepo.getById, list | ParticipantDetail, TournamentDetail | FK tournaments(id), required     |
| user_id            | uuid         | PII             | Participant detail, reporting | TournamentParticipantsRepo.getById, list | ParticipantDetail, Profile    | FK users(id), required            |
| team_id            | uuid         |                 | Participant detail, reporting | TournamentParticipantsRepo.getById, list | ParticipantDetail, TeamDetail | FK teams(id), optional            |
| status              | text         |                 | Participant detail, reporting | TournamentParticipantsRepo.getById, list | ParticipantDetail, TournamentDetail | enum (registered, confirmed, canceled), required |
| registration_date   | timestamp    |                 | Participant detail, reporting | TournamentParticipantsRepo.getById, list | ParticipantDetail, TournamentDetail | auto, not null                    |
| created_at         | timestamp    |                 | Participant detail, reporting | TournamentParticipantsRepo.getById, list | ParticipantDetail, TournamentDetail | auto, not null                    |
| updated_at         | timestamp    |                 | Participant detail, reporting | TournamentParticipantsRepo.getById, list | ParticipantDetail, TournamentDetail | auto, not null                    |

**Notes:**
- RLS/View: Only expose (id, tournament_id, user_id, team_id, status, registration_date, created_at, updated_at) in `tournament_participants_public`.
- Endpoints: `/public-tournament-participants`, `/tournament-participants` (private). GET params: id, tournament_id, user_id, team_id, status, since, limit, offset, order.
- Indexes: (tournament_id, user_id), (user_id, tournament_id, status).
- Consider adding a materialized view for participant statistics.

---

## posts

The `posts` table stores user-generated content for the social feed, including text, media, and references to games or achievements. It supports visibility controls and engagement metrics.

| column           | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id               | uuid         |                 | Feed, post detail, profile    | PostsRepo.getById, list          | FeedCard, PostDetail      | required, unique                  |
| author_id        | uuid         | PII             | Feed, profile, notifications  | PostsRepo.getById, list          | FeedCard, Profile         | FK users(id), required            |
| type             | USER-DEFINED |                 | Filtering, creation           | PostsRepo.getById, list          | FeedCard, PostCreate      | enum, required                    |
| content          | text         | user-generated  | Feed, post detail             | PostsRepo.getById, list          | FeedCard, PostDetail      | max 2000 chars, optional          |
| media_urls       | ARRAY        | user-generated  | Feed, post detail             | PostsRepo.getById, list          | FeedCard, PostDetail      | array of urls, optional           |
| game_id          | uuid         |                 | Game-related posts            | PostsRepo.getById, list          | FeedCard, GameDetail      | FK games(id), optional            |
| sport_id         | uuid         |                 | Filtering, display            | PostsRepo.getById, list          | FeedCard, PostDetail      | FK sports(id), optional           |
| achievement_type | text         |                 | Achievement posts             | PostsRepo.getById, list          | FeedCard, PostDetail      | optional, enum                    |
| visibility       | text         |                 | Feed filtering                | PostsRepo.getById, list          | FeedCard, PostDetail      | enum (public, friends, private)   |
| likes_count      | integer      |                 | Engagement metrics            | PostsRepo.getById, list          | FeedCard, PostDetail      | >=0, auto                         |
| comments_count   | integer      |                 | Engagement metrics            | PostsRepo.getById, list          | FeedCard, PostDetail      | >=0, auto                         |
| shares_count     | integer      |                 | Engagement metrics            | PostsRepo.getById, list          | FeedCard, PostDetail      | >=0, auto                         |
| is_deleted       | boolean      |                 | Moderation                    | PostsRepo.getById, list          | Hidden                    | default false                     |
| deleted_at       | timestamp    |                 | Moderation                    | PostsRepo.getById, list          | Hidden                    | optional                          |
| created_at       | timestamp    |                 | Feed, post detail             | PostsRepo.getById, list          | FeedCard, PostDetail      | auto, not null                    |
| updated_at       | timestamp    |                 | Feed, post detail             | PostsRepo.getById, list          | FeedCard, PostDetail      | auto, not null                    |
| location_name    | text         | user-generated  | Feed, post detail             | PostsRepo.getById, list          | FeedCard, PostDetail      | max 100 chars, optional           |
| tags             | text         | user-generated  | Filtering, display            | PostsRepo.getById, list          | FeedCard, PostDetail      | comma-separated, optional         |

**Notes:**
- RLS/View: Only expose (id, author_id, content, media_urls, created_at, visibility, likes_count, comments_count, shares_count) in `posts_public`.
- Endpoints: `/public-posts`, `/posts` (private). GET params: id, author_id, q, since, limit, offset, order.
- Indexes: (author_id, created_at desc), (visibility, created_at desc), (game_id), (sport_id).

---

## post_comments (and post_comments__old)

The `post_comments` table stores user comments on posts, supporting threading and moderation. The legacy `post_comments__old` table should be deprecated in favor of the canonical `post_comments`.

| column            | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|-------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id                | uuid         |                 | Post detail, comment thread   | PostCommentsRepo.getById, list   | CommentList, PostDetail   | required, unique                  |
| post_id           | uuid         |                 | Post linkage                  | PostCommentsRepo.getById, list   | CommentList, PostDetail   | FK posts(id), required            |
| author_id         | uuid         | PII             | Profile, notifications        | PostCommentsRepo.getById, list   | CommentList, Profile      | FK users(id), required            |
| content           | text         | user-generated  | Comment display               | PostCommentsRepo.getById, list   | CommentList, PostDetail   | max 1000 chars, required          |
| parent_comment_id | uuid         |                 | Threading                     | PostCommentsRepo.getById, list   | CommentList, PostDetail   | FK post_comments(id), optional    |
| created_at        | timestamp    |                 | Comment display               | PostCommentsRepo.getById, list   | CommentList, PostDetail   | auto, not null                    |
| updated_at        | timestamp    |                 | Comment display               | PostCommentsRepo.getById, list   | CommentList, PostDetail   | auto, not null                    |

**Notes:**
- RLS/View: Only expose (id, post_id, author_id, content, created_at) in `post_comments_public`.
- Endpoints: `/public-comments`, `/comments` (private). GET params: id, post_id, author_id, q, since, limit, offset, order.
- Indexes: (post_id, created_at), (author_id, created_at desc).
- Deprecation: Mark `post_comments__old` as legacy; migrate to `post_comments` for all new features.

---

## reactions and reactions_unified

The `reactions` and `reactions_unified` tables store user reactions (likes, emojis, etc.) to posts and comments. Prefer `reactions_unified` for all new features as the canonical source.

| column         | type     | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|----------------|----------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id             | uuid     |                 | Reaction display, analytics   | ReactionsRepo.getById, list      | ReactionBar, PostDetail   | required, unique                  |
| user_id        | uuid     | PII             | Profile, analytics            | ReactionsRepo.getById, list      | ReactionBar, Profile      | FK users(id), required            |
| post_id        | uuid     |                 | Post linkage                  | ReactionsRepo.getById, list      | ReactionBar, PostDetail   | FK posts(id), optional            |
| comment_id     | uuid     |                 | Comment linkage               | ReactionsRepo.getById, list      | ReactionBar, CommentList  | FK post_comments(id), optional    |
| reaction_type  | text     | user-generated  | Reaction display              | ReactionsRepo.getById, list      | ReactionBar, PostDetail   | enum, required                    |
| created_at     | timestamp|                 | Analytics, display            | ReactionsRepo.getById, list      | ReactionBar, PostDetail   | auto, not null                    |

**Notes:**
- RLS/View: Only expose (id, post_id, comment_id, reaction_type, created_at) in `reactions_public`.
- Endpoints: `/public-reactions`, `/reactions` (private). GET params: id, user_id, post_id, comment_id, since, limit, offset, order.
- Indexes: (post_id, reaction_type), (comment_id, reaction_type), (user_id, created_at desc).
- Deprecation: Prefer `reactions_unified` for all new features; mark `reactions` as legacy.

---

## notifications_unified

The `notifications_unified` table stores all user notifications, including actor, category, and payload data. It is the canonical notifications source; older `notifications` is legacy.

| column      | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|-------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id          | uuid         |                 | Notification list, badge      | NotificationsRepo.getById, list  | NotificationList, Badge   | required, unique                  |
| user_id     | uuid         | PII             | User notifications            | NotificationsRepo.getById, list  | NotificationList, Badge   | FK users(id), required            |
| actor_id    | uuid         | PII             | Actor display                 | NotificationsRepo.getById, list  | NotificationList, Badge   | FK users(id), optional            |
| category    | USER-DEFINED |                 | Filtering, display            | NotificationsRepo.getById, list  | NotificationList, Badge   | enum, required                    |
| kind        | text         |                 | Filtering, display            | NotificationsRepo.getById, list  | NotificationList, Badge   | enum, required                    |
| data        | jsonb        | user-generated  | Notification payload          | NotificationsRepo.getById, list  | NotificationList, Badge   | json, required                    |
| is_read     | boolean      |                 | Read/unread state             | NotificationsRepo.getById, list  | NotificationList, Badge   | default false                     |
| created_at  | timestamp    |                 | Notification list             | NotificationsRepo.getById, list  | NotificationList, Badge   | auto, not null                    |

**Notes:**
- RLS/View: Only expose (id, category, kind, data, created_at) in `notifications_public`.
- Endpoints: `/public-notifications`, `/notifications` (private). GET params: id, user_id, since, limit, offset, order.
- Indexes: (user_id, created_at desc), (is_read, created_at desc).
- Deprecation: Mark `notifications` as legacy; use `notifications_unified` for all new features.

---

## user_rankings, leaderboards, leaderboard_entries

These tables power leaderboards and ranking features, tracking user positions, scores, and history across sports and time periods.

| column              | type         | sensitive?      | used in (feature/screen)      | API surface (repo/edge fn)      | UI binding                | validation                        |
|---------------------|--------------|-----------------|-------------------------------|----------------------------------|---------------------------|-----------------------------------|
| id                  | uuid         |                 | Leaderboard, ranking          | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | required, unique                  |
| user_id             | uuid         | PII             | User ranking                  | LeaderboardsRepo.getById, list   | Leaderboard, Profile     | FK users(id), required            |
| leaderboard_type    | USER-DEFINED |                 | Filtering, display            | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | enum, required                    |
| sport_id            | uuid         |                 | Filtering, display            | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | FK sports(id), optional           |
| time_period         | text         |                 | Filtering, display            | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | enum, optional                    |
| rank                | integer      |                 | Ranking display               | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | >=1, required                     |
| total_points        | integer      |                 | Ranking display               | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | >=0, required                     |
| movement            | integer      |                 | Ranking change                | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | optional                          |
| previous_rank       | integer      |                 | Ranking change                | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | optional                          |
| updated_at          | timestamp    |                 | Audit, display                | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | auto, not null                    |
| leaderboard_id      | uuid         |                 | Entry linkage                 | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | FK leaderboards(id), required     |
| score               | numeric      |                 | Entry score                   | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | >=0, required                     |
| activities_count    | integer      |                 | Entry stats                   | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | >=0, optional                     |
| wins_count          | integer      |                 | Entry stats                   | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | >=0, optional                     |
| metrics             | jsonb        | user-generated  | Entry stats                   | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | json, optional                    |
| best_score          | numeric      |                 | Entry stats                   | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | >=0, optional                     |
| best_score_date     | date         |                 | Entry stats                   | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | optional                          |
| calculated_at       | timestamp    |                 | Audit, display                | LeaderboardsRepo.getById, list   | Leaderboard, Ranking     | auto, not null                    |

**Notes:**
- RLS/View: Only expose (id, user_id, leaderboard_type, sport_id, time_period, rank, total_points, score, created_at) in `leaderboards_public`.
- Endpoints: `/public-leaderboards`, `/leaderboards` (private). GET params: id, user_id, leaderboard_type, sport_id, time_period, since, limit, offset, order.
- Indexes: (leaderboard_type, sport_id, time_period, rank), (user_id, updated_at desc).
- Validation: Enforce non-negative scores, required FKs, and allowed enums.
- Deprecation: N/A (all three tables are canonical for leaderboard features).