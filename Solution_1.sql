-- 1. Create a procedure add_message that accepts a ticket ID and a message string, inserts a new message into ticket_messages, 
-- and updates the total_messages column in support_tickets. Handle invalid ticket IDs and null inputs with appropriate exceptions.

CREATE OR REPLACE PROCEDURE add_message (p_ticket_id support_tickets.ticket_id%TYPE, 
                                            p_ticket_msg ticket_messages.MESSAGE_TEXT%TYPE)
IS
    null_value_exception EXCEPTION;
    invalid_value_exception EXCEPTION;
    v_ticket_id_count NUMBER;
BEGIN
    -- checking for null parameter then raise  exception
    IF p_ticket_id IS NULL OR p_ticket_msg IS NULL THEN
        RAISE null_value_exception;
       END IF; 
    
    -- checking if tickrt id passing to procedure is present in support_tickets table, if not then raise exception
    SELECT COUNT(1) INTO  v_ticket_id_count FROM support_tickets WHERE TICKET_ID = p_ticket_id;

    IF v_ticket_id_count = 0 THEN 
        RAISE invalid_value_exception;
    END IF; 

    -- insert values if no exception 
    INSERT INTO ticket_messages VALUES (ticket_messages_seq.NEXTVAL, p_ticket_id, p_ticket_msg);
    
    -- update support_tickets, increasing message count,  if no exception 
    UPDATE support_tickets SET TOTAL_MESSAGES = TOTAL_MESSAGES+1 where TICKET_ID = p_ticket_id;
    
EXCEPTION 
    WHEN null_value_exception THEN
        DBMS_OUTPUT.PUT_LINE ('ticket id can not be null');    
    WHEN others THEN 
    DBMS_OUTPUT.PUT_LINE ('something went wrong');
END add_message;


----------------------------------------------------------------------------------------------------

-- sequence creation 
	CREATE SEQUENCE ticket_messages_seq START WITH 4;