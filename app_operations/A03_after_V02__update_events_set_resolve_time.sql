-- Test function for easier data updates
create or replace procedure set_resolve_time_for_event(ref_event_description varchar)
    language plpgsql as
$$
begin
    update event
    set resolve_time = event_time + 1
    where event_description = ref_event_description;
end;
$$;

start transaction;

call set_resolve_time_for_event('Evt_05');
call set_resolve_time_for_event('Evt_06');
call set_resolve_time_for_event('Evt_07');
call set_resolve_time_for_event('Evt_20');
call set_resolve_time_for_event('Evt_21');

commit;

select *
from event
order by event_id desc;

-- notice that only account_id in (1, 2) are present,
-- events from vehicles on account_id=3 are still missing
select s.vehicle_id,
       s.event_class_id,
       v.account_id,
       v.vin,
       s.last_event_id,
       s.last_update,
       s.last_event_description
from event_class_state s
         join vehicle v on v.vehicle_id = s.vehicle_id;
