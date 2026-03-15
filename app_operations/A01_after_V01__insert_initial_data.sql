start transaction;

insert into vehicle (vehicle_id, object_id, account_id, vin)
values (nextval('seq_vehicle_id'), 11, 1, 'Acc_01_Obj_011_V1'),
       (nextval('seq_vehicle_id'), 11, 1, 'Acc_01_Obj_011_V2'),
       (nextval('seq_vehicle_id'), 11, 1, 'Acc_01_Obj_011_V3'),
       (nextval('seq_vehicle_id'), 12, 1, 'Acc_01_Obj_012_V1'),
       (nextval('seq_vehicle_id'), 12, 1, 'Acc_01_Obj_012_V2'),
       (nextval('seq_vehicle_id'), 21, 2, 'Acc_02_Obj_021_V1'),
       (nextval('seq_vehicle_id'), 22, 2, 'Acc_02_Obj_022_V1'),
       (nextval('seq_vehicle_id'), 31, 3, 'Acc_03_Obj_031_V1');

insert into event (event_id, event_class_id, event_time, resolve_time, vehicle_id, event_description)
values (nextval('seq_event_id'), 1, 1, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V1' limit 1), 'Evt_01'),
       (nextval('seq_event_id'), 1, 2, 3,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_012_V2' limit 1), 'Evt_02'),
       (nextval('seq_event_id'), 1, 1, 4,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V3' limit 1), 'Evt_03'),
       (nextval('seq_event_id'), 2, 4, 6,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_012_V1' limit 1), 'Evt_04'),
       (nextval('seq_event_id'), 1, 5, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_02_Obj_021_V1' limit 1), 'Evt_05'),
       (nextval('seq_event_id'), 1, 7, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_02_Obj_022_V1' limit 1), 'Evt_06'),
       (nextval('seq_event_id'), 3, 10, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V1' limit 1), 'Evt_07'),
       (nextval('seq_event_id'), 1, 12, 18,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V1' limit 1), 'Evt_08'),
       (nextval('seq_event_id'), 1, 15, null,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V1' limit 1), 'Evt_09'),
       (nextval('seq_event_id'), 2, 20, 23,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_011_V1' limit 1), 'Evt_10'),
       (nextval('seq_event_id'), 1, 21, 24,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_012_V1' limit 1), 'Evt_11'),
       (nextval('seq_event_id'), 3, 25, 29,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_012_V1' limit 1), 'Evt_12'),
       (nextval('seq_event_id'), 1, 28, 31,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_012_V2' limit 1), 'Evt_13'),
       (nextval('seq_event_id'), 2, 30, 31,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_01_Obj_012_V2' limit 1), 'Evt_14'),
       (nextval('seq_event_id'), 1, 40, 41,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_03_Obj_031_V1' limit 1), 'Evt_15'),
       (nextval('seq_event_id'), 2, 40, 41,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_03_Obj_031_V1' limit 1), 'Evt_16'),
       (nextval('seq_event_id'), 3, 40, 41,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_03_Obj_031_V1' limit 1), 'Evt_17'),
       (nextval('seq_event_id'), 4, 40, 41,
        (select v.vehicle_id from vehicle v where v.vin = 'Acc_03_Obj_031_V1' limit 1), 'Evt_18');

commit;

select *
from vehicle;

select *
from event;
