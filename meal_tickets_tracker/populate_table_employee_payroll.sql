-- for employee_id=1 (Manole Paul-Sebastian by default during dev)
INSERT INTO employee_payroll (employee_cnp, month, days_worked, days_on_vacation)
VALUES (1880115142615, make_date(2018, 1, 4), 0, 2),
       (1880115142615, make_date(2018, 2, 4), 0, 3),
       (1880115142615, make_date(2018, 3, 4), 0, 2),
       (1880115142615, make_date(2018, 4, 4), 0, 2),
       (1880115142615, make_date(2018, 5, 4), 0, 1),
       (1880115142615, make_date(2018, 6, 4), 0, 3),
       (1880115142615, make_date(2018, 7, 4), 0, 3),
       (1880115142615, make_date(2018, 8, 4), 0, 0),
       (1880115142615, make_date(2018, 9, 4), 0, 0),
       (1880115142615, make_date(2018, 10, 4), 0, 1),
       (1880115142615, make_date(2018, 11, 4), 0, 1),
       (1880115142615, make_date(2018, 12, 4), 0, 2);

INSERT INTO employee_payroll (employee_cnp, month, days_worked, days_on_vacation)
VALUES (1880115142615, make_date(2019, 1, 4), 0, 0),
       (1880115142615, make_date(2019, 2, 4), 0, 0),
       (1880115142615, make_date(2019, 3, 4), 0, 0),
       (1880115142615, make_date(2019, 4, 4), 0, 2),
       (1880115142615, make_date(2019, 5, 4), 0, 1),
       (1880115142615, make_date(2019, 6, 4), 0, 2),
       (1880115142615, make_date(2019, 7, 4), 0, 2),
       (1880115142615, make_date(2019, 8, 4), 0, 3),
       (1880115142615, make_date(2019, 9, 4), 0, 0),
       (1880115142615, make_date(2019, 10, 4), 0, 1),
       (1880115142615, make_date(2019, 11, 4), 0, 1),
       (1880115142615, make_date(2019, 12, 4), 0, 7);

-- setare automata zile lucrate din zilele din luna respectiva minus zilele de concediu:
UPDATE employee_payroll
SET days_worked = extract(DAYS FROM date_trunc('month', month) + INTERVAL '1 month - 1 day') -
                  days_on_vacation;

SELECT *
FROM employee_payroll;