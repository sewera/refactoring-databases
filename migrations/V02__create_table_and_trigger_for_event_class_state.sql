create table if not exists event_class_state
(
    event_class_id         bigint not null,
    vehicle_id             bigint,
    last_event_id          bigint,
    last_update            bigint,
    is_active              boolean,
    last_event_description varchar,
    primary key (event_class_id, vehicle_id)
);

create or replace function update_event_class_state() returns trigger
    language plpgsql as
$$
begin
    insert into event_class_state (event_class_id, vehicle_id, last_event_id, last_update, is_active,
                                   last_event_description)
    values (new.event_class_id, new.vehicle_id, new.event_id,
            coalesce(new.resolve_time, new.event_time), new.resolve_time is null, new.event_description)
    on conflict (event_class_id, vehicle_id)
        do update set (last_event_id, last_event_description, last_update, is_active) =
                          (new.event_id, new.event_description,
                           coalesce(new.resolve_time, new.event_time),
                           new.resolve_time is null);
    return null;
end;
$$;

create or replace trigger trigger_event_class_state
    after
        insert or update
    on event
    for each row
execute function update_event_class_state();
