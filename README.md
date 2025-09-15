# PLSQL_casestudy1 
/*Scenario: Support Ticket Management System
You are building a backend logic system for managing customer support tickets. Each ticket may have multiple messages or updates added over time. 
These messages are stored and handled using PL/SQL collections (not directly stored in the table). You’ll implement message handling, logging, validation, 
and reporting using PL/SQL constructs such as procedures, triggers, functions, cursors, records, and exception handling.
Table Structures*/
-- Support Tickets Table
CREATE TABLE support_tickets (
  ticket_id NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100),
  total_messages NUMBER DEFAULT 0
);
 
-- Ticket Messages Table (one message per row)
CREATE TABLE ticket_messages (
  message_id NUMBER PRIMARY KEY,
  ticket_id NUMBER REFERENCES support_tickets(ticket_id),
  message_text VARCHAR2(200)
);
 
-- Ticket Log Table
CREATE TABLE ticket_log (
  log_id NUMBER PRIMARY KEY,
  ticket_id NUMBER,
  action_taken VARCHAR2(200),
  log_time TIMESTAMP DEFAULT SYSTIMESTAMP
);

Sample Data
INSERT INTO support_tickets VALUES (301, 'Neha', 2);
INSERT INTO support_tickets VALUES (302, 'Ravi', 1);
INSERT INTO support_tickets VALUES (303, 'Simran', 0);
 
INSERT INTO ticket_messages VALUES (1, 301, 'Login Failed');
INSERT INTO ticket_messages VALUES (2, 301, 'Reset Attempted');
INSERT INTO ticket_messages VALUES (3, 302, 'Payment Error');
 
---
 /*
Practice Questions
1. Create a procedure add_message that accepts a ticket ID and a message string, inserts a new message into ticket_messages, and updates the total_messages column in support_tickets. Handle invalid ticket IDs and null inputs with appropriate exceptions.
2. Write a BEFORE INSERT trigger on ticket_messages to prevent more than 5 messages being added to any ticket. Use the total_messages value to check limit.
3. Create a function get_message_count that accepts a ticket ID and returns the number of messages from ticket_messages. Handle invalid or missing tickets using proper exception handling.
4. Write a cursor-based block to print all tickets from support_tickets where no messages exist (i.e., total_messages = 0).
5. Write a procedure log_ticket_action that accepts a ticket ID and a message like 'Message Added', and inserts an action log into ticket_log with timestamp. 
6. Create a package support_pkg that wraps add_message, log_ticket_action, and get_message_count, using proper structure and exception safety throughout.

-- */
