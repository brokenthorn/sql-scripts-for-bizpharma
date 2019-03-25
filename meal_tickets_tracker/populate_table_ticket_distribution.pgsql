DO LANGUAGE plpgsql $$
  DECLARE
    ep employee_payroll%ROWTYPE;
  BEGIN
    FOR ep IN SELECT * FROM employee_payroll
      LOOP
        INSERT INTO ticket_distribution (employee_cnp, month, ticket_value, ticket_quantity)
        SELECT ep.employee_cnp,
               ep.month + INTERVAL '1 month',
               15.0,
               COALESCE(ep.days_worked -
                        (SELECT pm_ep.days_on_vacation
                         FROM employee_payroll pm_ep
                         WHERE pm_ep.month = (ep.month - INTERVAL '1 month')),
                        0);
      END LOOP;
  END $$;

SELECT *
FROM ticket_distribution;