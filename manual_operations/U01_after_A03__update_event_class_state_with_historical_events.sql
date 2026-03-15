start transaction;

with last_event as (select *
                    from event
                    where event_id in (select max(event_id) as last_event_id
                                       from event
                                       group by (event_class_id, vehicle_id)))
insert
into event_class_state (event_class_id, vehicle_id, last_event_id, last_update, is_active,
                        last_event_description)
select event_class_id,
       vehicle_id,
       event_id,
       coalesce(resolve_time, event_time),
       resolve_time is null,
       event_description
from last_event
on conflict (event_class_id, vehicle_id)
    do update set (last_event_id, last_event_description, last_update, is_active) =
                      (select event_id,
                              event_description,
                              coalesce(resolve_time, event_time),
                              resolve_time is null
                       from last_event
                       where event_class_state.event_class_id = last_event.event_class_id
                         and event_class_state.vehicle_id = last_event.vehicle_id);

commit;

-- events from vehicles on all accounts should be present
select s.vehicle_id,
       s.event_class_id,
       v.account_id,
       v.vin,
       s.last_event_id,
       s.last_update,
       s.last_event_description
from event_class_state s
         join vehicle v on v.vehicle_id = s.vehicle_id;
