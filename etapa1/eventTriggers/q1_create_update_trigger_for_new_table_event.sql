CREATE EVENT TRIGGER create_trigger_for_new_table_event
ON ddl_command_end
WHEN TAG IN ('CREATE TABLE')
EXECUTE FUNCTION create_trigger_for_new_table();