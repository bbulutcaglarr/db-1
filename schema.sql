create table cache
(
    `key`      varchar(255) not null
        primary key,
    value      mediumtext   not null,
    expiration int          not null
)
    collate = utf8mb4_unicode_ci;

create table cache_locks
(
    `key`      varchar(255) not null
        primary key,
    owner      varchar(255) not null,
    expiration int          not null
)
    collate = utf8mb4_unicode_ci;

create table categories
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(255) not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table failed_jobs
(
    id         bigint unsigned auto_increment
        primary key,
    uuid       varchar(255)                        not null,
    connection text                                not null,
    queue      text                                not null,
    payload    longtext                            not null,
    exception  longtext                            not null,
    failed_at  timestamp default CURRENT_TIMESTAMP not null,
    constraint failed_jobs_uuid_unique
        unique (uuid)
)
    collate = utf8mb4_unicode_ci;

create table job_batches
(
    id             varchar(255) not null
        primary key,
    name           varchar(255) not null,
    total_jobs     int          not null,
    pending_jobs   int          not null,
    failed_jobs    int          not null,
    failed_job_ids longtext     not null,
    options        mediumtext   null,
    cancelled_at   int          null,
    created_at     int          not null,
    finished_at    int          null
)
    collate = utf8mb4_unicode_ci;

create table jobs
(
    id           bigint unsigned auto_increment
        primary key,
    queue        varchar(255)     not null,
    payload      longtext         not null,
    attempts     tinyint unsigned not null,
    reserved_at  int unsigned     null,
    available_at int unsigned     not null,
    created_at   int unsigned     not null
)
    collate = utf8mb4_unicode_ci;

create index jobs_queue_index
    on jobs (queue);

create table migrations
(
    id        int unsigned auto_increment
        primary key,
    migration varchar(255) not null,
    batch     int          not null
)
    collate = utf8mb4_unicode_ci;

create table password_reset_tokens
(
    email      varchar(255) not null
        primary key,
    token      varchar(255) not null,
    created_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table sessions
(
    id            varchar(255)    not null
        primary key,
    user_id       bigint unsigned null,
    ip_address    varchar(45)     null,
    user_agent    text            null,
    payload       longtext        not null,
    last_activity int             not null
)
    collate = utf8mb4_unicode_ci;

create index sessions_last_activity_index
    on sessions (last_activity);

create index sessions_user_id_index
    on sessions (user_id);

create table tags
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(255) not null,
    created_at timestamp    null,
    updated_at timestamp    null
)
    collate = utf8mb4_unicode_ci;

create table users
(
    id                bigint unsigned auto_increment
        primary key,
    name              varchar(255)         not null,
    email             varchar(255)         not null,
    email_verified_at timestamp            null,
    password          varchar(255)         not null,
    is_admin          tinyint(1) default 0 not null,
    remember_token    varchar(100)         null,
    created_at        timestamp            null,
    updated_at        timestamp            null,
    constraint users_email_unique
        unique (email)
)
    collate = utf8mb4_unicode_ci;

create table achievements
(
    id          bigint unsigned auto_increment
        primary key,
    user_id     bigint unsigned not null,
    name        varchar(255)    not null,
    description varchar(255)    null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint achievements_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table admin_actions
(
    id          bigint unsigned auto_increment
        primary key,
    admin_id    bigint unsigned not null,
    action_type varchar(255)    not null,
    description text            null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint admin_actions_admin_id_foreign
        foreign key (admin_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table campaigns
(
    id              bigint unsigned auto_increment
        primary key,
    user_id         bigint unsigned             null,
    title           varchar(255)                not null,
    description     text                        null,
    goal_amount     decimal(15, 2)              not null,
    start_date      date                        null,
    end_date        date                        null,
    amount          decimal(15, 2) default 0.00 not null,
    created_at      timestamp                   null,
    updated_at      timestamp                   null,
    total_donations decimal(15, 2) default 0.00 not null,
    constraint campaigns_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table campaign_categories
(
    id          bigint unsigned auto_increment
        primary key,
    campaign_id bigint unsigned not null,
    category_id bigint unsigned not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint campaign_categories_campaign_id_foreign
        foreign key (campaign_id) references campaigns (id)
            on delete cascade,
    constraint campaign_categories_category_id_foreign
        foreign key (category_id) references categories (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table campaign_tags
(
    id          bigint unsigned auto_increment
        primary key,
    campaign_id bigint unsigned not null,
    tag_id      bigint unsigned not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint campaign_tags_campaign_id_foreign
        foreign key (campaign_id) references campaigns (id)
            on delete cascade,
    constraint campaign_tags_tag_id_foreign
        foreign key (tag_id) references tags (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table campaign_updates
(
    id          bigint unsigned auto_increment
        primary key,
    campaign_id bigint unsigned not null,
    content     text            not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint campaign_updates_campaign_id_foreign
        foreign key (campaign_id) references campaigns (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table comments
(
    id          bigint unsigned auto_increment
        primary key,
    user_id     bigint unsigned not null,
    campaign_id bigint unsigned not null,
    content     text            not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint comments_campaign_id_foreign
        foreign key (campaign_id) references campaigns (id)
            on delete cascade,
    constraint comments_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table donations
(
    id             bigint unsigned auto_increment
        primary key,
    user_id        bigint unsigned                not null,
    campaign_id    bigint unsigned                not null,
    amount         decimal(15, 2)                 not null,
    payment_method varchar(255)                   null,
    created_at     timestamp                      null,
    updated_at     timestamp                      null,
    status         varchar(255) default 'pending' not null,
    constraint donations_campaign_id_foreign
        foreign key (campaign_id) references campaigns (id)
            on delete cascade,
    constraint donations_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table feedback
(
    id          bigint unsigned auto_increment
        primary key,
    user_id     bigint unsigned not null,
    campaign_id bigint unsigned not null,
    message     text            not null,
    rating      int             null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint feedback_campaign_id_foreign
        foreign key (campaign_id) references campaigns (id)
            on delete cascade,
    constraint feedback_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table invoices
(
    id             bigint unsigned auto_increment
        primary key,
    donation_id    bigint unsigned not null,
    user_id        bigint unsigned not null,
    invoice_number varchar(255)    not null,
    total_amount   decimal(15, 2)  not null,
    created_at     timestamp       null,
    updated_at     timestamp       null,
    constraint invoices_invoice_number_unique
        unique (invoice_number),
    constraint invoices_donation_id_foreign
        foreign key (donation_id) references donations (id)
            on delete cascade,
    constraint invoices_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table notification_settings
(
    id                  bigint unsigned auto_increment
        primary key,
    user_id             bigint unsigned      not null,
    email_notifications tinyint(1) default 1 not null,
    sms_notifications   tinyint(1) default 0 not null,
    created_at          timestamp            null,
    updated_at          timestamp            null,
    constraint notification_settings_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table notifications
(
    id              bigint unsigned auto_increment
        primary key,
    user_id         bigint unsigned                      null,
    notifiable_id   bigint unsigned                      null,
    notifiable_type varchar(255) default 'default_value' not null,
    type            varchar(255)                         not null,
    message         varchar(255)                         not null,
    `read`          tinyint(1)   default 0               not null,
    created_at      timestamp                            null,
    updated_at      timestamp                            null,
    constraint notifications_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table refunds
(
    id          bigint unsigned auto_increment
        primary key,
    donation_id bigint unsigned not null,
    reason      varchar(255)    null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint refunds_donation_id_foreign
        foreign key (donation_id) references donations (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table reports
(
    id                   bigint unsigned auto_increment
        primary key,
    reported_by          bigint unsigned                not null,
    reported_campaign_id bigint unsigned                not null,
    reason               text                           not null,
    status               varchar(255) default 'pending' not null,
    created_at           timestamp                      null,
    updated_at           timestamp                      null,
    constraint reports_reported_by_foreign
        foreign key (reported_by) references users (id)
            on delete cascade,
    constraint reports_reported_campaign_id_foreign
        foreign key (reported_campaign_id) references campaigns (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table saved_campaigns
(
    id          bigint unsigned auto_increment
        primary key,
    user_id     bigint unsigned not null,
    campaign_id bigint unsigned not null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint saved_campaigns_campaign_id_foreign
        foreign key (campaign_id) references campaigns (id)
            on delete cascade,
    constraint saved_campaigns_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table transactions
(
    id                 bigint unsigned auto_increment
        primary key,
    donation_id        bigint unsigned not null,
    transaction_status varchar(255)    not null,
    payment_reference  varchar(255)    null,
    created_at         timestamp       null,
    updated_at         timestamp       null,
    constraint transactions_donation_id_foreign
        foreign key (donation_id) references donations (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;

create table user_profiles
(
    id              bigint unsigned auto_increment
        primary key,
    user_id         bigint unsigned not null,
    address         varchar(255)    null,
    phone           varchar(255)    null,
    profile_picture varchar(255)    null,
    country         varchar(255)    null,
    created_at      timestamp       null,
    updated_at      timestamp       null,
    constraint user_profiles_user_id_foreign
        foreign key (user_id) references users (id)
            on delete cascade
)
    collate = utf8mb4_unicode_ci;


