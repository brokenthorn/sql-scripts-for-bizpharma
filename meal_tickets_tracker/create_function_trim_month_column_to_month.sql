CREATE OR REPLACE FUNCTION trim_month_column_to_month() RETURNS TRIGGER AS
$$
BEGIN
  new.month := date_trunc('month', new.month);
  RETURN new;
END;
$$ LANGUAGE plpgsql;