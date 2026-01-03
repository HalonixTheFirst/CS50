-- Keep a log of any SQL queries you execute as you solve the mystery.
.schema
.tables
SELECT * FROM crime_scene_reports;
SELECT * FROM crime_scene_reports WHERE street='Humphrey Street' AND day = 28 AND month=7;
.tables
SELECT * FROM bakery_security_logs;
SELECT * FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10;
SELECT * FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268;
SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268;
.tables
SELECT * FROM people;
SELECT * FROM people WHERE license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268);
SELECT * FROM phone_calls

SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268);

SELECT * FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration DESC;

SELECT * FROM phone_calls WHERE day=28 AND month=7 AND receiver IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268))ORDER BY duration DESC;

SELECT * FROM interviews;
SELECT * FROM interviews WHERE day=28 AND month =7;

SELECT * FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC;


SELECT * FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6;

SELECT receiver FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6;

SELECT caller,receiver FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6;

SELECT * FROM atm_transactions WHERE day=28 AND month=7;
SELECT * FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street';

SELECT * FROM flights;
SELECT * FROM flights WHERE day=28 AND month=7;
SELECT * FROM flights WHERE day=28 AND month=7 ORDER BY hour;

SELECT * FROM airports;

SELECT * FROM passengers;
SELECT * FROM passengers WHERE flight_id =6;
SELECT passport_number FROM passengers WHERE flight_id =6;

SELECT * FROM bank_accounts;
SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street');

SELECT * FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268);


SELECT * FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268) AND phone_number IN (
SELECT caller FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6);

SELECT passport_number FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268) AND phone_number IN (
SELECT caller FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6);

SELECT * FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268) AND phone_number IN (
SELECT caller FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6)
);

SELECT flight_id FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268) AND phone_number IN (
SELECT caller FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6)
);

SELECT * FROM flights WHERE id in (SELECT flight_id FROM passengers WHERE passport_number IN (SELECT passport_number FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268) AND phone_number IN (
SELECT caller FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6)
)) ORDER BY hour;

SELECT passport_number FROM passengers WHERE flight_id=36 AND passport_number IN (SELECT passport_number FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268) AND phone_number IN (
SELECT caller FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6)
);

SELECT * FROM people;

SELECT name FROM people WHERE passport_number in (SELECT passport_number FROM passengers WHERE flight_id=36 AND passport_number IN (SELECT passport_number FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268) AND phone_number IN (
SELECT caller FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6)
));

SELECT name,phone_number,passport_number,license_plate FROM people WHERE passport_number in (SELECT passport_number FROM passengers WHERE flight_id=36 AND passport_number IN (SELECT passport_number FROM people WHERE id in(SELECT person_id FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street')) AND
license_plate IN(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268) AND phone_number IN (
SELECT caller FROM phone_calls WHERE day=28 AND month=7 AND caller IN (SELECT phone_number FROM people WHERE license_plate IN
(SELECT license_plate FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268)) ORDER BY duration ASC LIMIT 6)
));

SELECT * FROM bakery_security_logs WHERE day=28 AND month=7 and hour=10 AND ID between 260 AND 268;

SELECT * FROM bank_accounts WHERE account_number IN
(SELECT account_number FROM atm_transactions WHERE day=28 AND month=7 AND atm_location='Leggett Street');
