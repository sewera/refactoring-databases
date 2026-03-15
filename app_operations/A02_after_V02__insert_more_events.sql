-- this transaction will run after creating a trigger for event_class_state
-- it won't update any vehicles on account_id=2,
-- so after the following inserts, vehicles from that account
-- shouldn't be visible in event_class_state
start transaction;

insert into event (event_id, event_class_id, event_time, resolve_time, vehicle_id, event_description)
values (nextval('seq_event_id'), 1, 40, 41,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V3' limit 1), 'Evt_19'),
       (nextval('seq_event_id'), 4, 42, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V3' limit 1), 'Evt_20'),
       (nextval('seq_event_id'), 3, 48, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V3' limit 1), 'Evt_21'),
       (nextval('seq_event_id'), 1, 72, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_012_V2' limit 1), 'Evt_22'),
       (nextval('seq_event_id'), 2, 76, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_012_V2' limit 1), 'Evt_23');

commit;

select *
from event
order by event_id desc;

-- notice that only account_id=1 vehicles are present
select s.vehicle_id,
       s.event_class_id,
       v.account_id,
       v.vin,
       s.last_event_id,
       s.last_update,
       s.last_event_description
from event_class_state s
         join vehicle v on v.vehicle_id = s.vehicle_id;
