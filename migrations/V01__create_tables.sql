create table if not exists vehicle
(
    vehicle_id bigint primary key not null,
    object_id  bigint,
    account_id bigint,
    vin        char(17)
);

create sequence if not exists seq_vehicle_id;

create table if not exists event
(
    event_id          bigint primary key not null,
    event_class_id    bigint,
    event_time        bigint,
    resolve_time      bigint,
    vehicle_id        bigint,
    event_description varchar
);

create sequence if not exists seq_event_id;
