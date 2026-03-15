drop table if exists event;
drop table if exists event_class_state;
drop table if exists vehicle;

drop routine if exists set_resolve_time_for_event(ref_event_description varchar);
drop routine if exists update_event_class_state();

drop sequence if exists seq_event_id;
drop sequence if exists seq_vehicle_id;
