CREATE TABLE employee_payroll
(
  employee_cnp     CHAR(13) NOT NULL
    CONSTRAINT employee_payroll_employee_cnp_fk
      REFERENCES employee,
  month            DATE     NOT NULL,
  days_worked      SMALLINT NOT NULL,
  days_on_vacation SMALLINT NOT NULL,
  CONSTRAINT employee_payroll_pk
    PRIMARY KEY (employee_cnp, month)
);

COMMENT ON TABLE employee_payroll IS 'Tabel cu zilele lucrate si concedii';

CREATE TRIGGER trim_employee_payroll_month
  BEFORE INSERT OR UPDATE
  ON employee_payroll
  FOR EACH ROW
EXECUTE PROCEDURE trim_month_column_to_month();

SELECT *
FROM employee_payroll
