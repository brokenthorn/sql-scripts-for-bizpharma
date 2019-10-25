SELECT *
FROM Operatie
WHERE IdTipOperatie = 14902 -- (PV automat) Diminuare card numarul: 'xxxx' cu 1,4 puncte.
  AND MomentOperatie BETWEEN '2019-06-01' AND '2019-06-30 23:59:59.999'
ORDER BY MomentOperatie DESC