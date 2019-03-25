CREATE TABLE ticket_distribution
(
  employee_cnp    CHAR(13)      NOT NULL
    CONSTRAINT ticket_distribution_employee_cnp_fk
      REFERENCES employee,
  month           DATE          NOT NULL,
  ticket_value    DECIMAL(5, 2) NOT NULL,
  ticket_quantity SMALLINT      NOT NULL
);

COMMENT ON TABLE ticket_distribution IS 'Tabel cu distribuirea tichetelor catre angajati in fiecare luna';

CREATE UNIQUE INDEX ticket_distribution_employee_id_month_year_quantity_ticket_value_uindex
  ON ticket_distribution (employee_cnp, month, ticket_value);

CREATE TRIGGER trim_ticket_distribution_month
  BEFORE INSERT OR UPDATE
  ON ticket_distribution
  FOR EACH ROW
EXECUTE PROCEDURE trim_month_column_to_month();