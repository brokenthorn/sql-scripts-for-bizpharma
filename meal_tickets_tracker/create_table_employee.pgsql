CREATE TABLE employee
(
  cnp        CHAR(13)    NOT NULL
    CONSTRAINT employee_pk PRIMARY KEY,
  first_name VARCHAR(64) NOT NULL,
  last_name  VARCHAR(64) NOT NULL
);

COMMENT ON TABLE employee IS 'Tabela cu angajatii companiei';

CREATE INDEX employee_first_name_last_name_index
  ON employee (first_name, last_name);

