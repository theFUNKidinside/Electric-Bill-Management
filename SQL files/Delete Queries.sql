-- Delete from City table --
DELIMITER $$
CREATE PROCEDURE DeleteFromCity(IN c_id int)
BEGIN
    DELETE FROM City 
    WHERE City_ID = c_id;
END$$
DELIMITER ;
CALL DeleteFromCity(1);
SELECT * FROM City;

-- Delete from Village table --
DELIMITER $$
CREATE PROCEDURE DeleteFromVillage(IN v_id int)
BEGIN
	DELETE FROM Village
	WHERE Village_ID = v_id
    LIMIT 1;
END$$
DELIMITER ;
CALL DeleteFromVillage(2);
SELECT * FROM Village;

-- Delete from Accounts table --
DELIMITER $$
CREATE PROCEDURE DeleteFromAccounts(IN a_id int)
BEGIN
    DELETE FROM Accounts
    WHERE Client_ID = a_id;
END$$
DELIMITER ;
CALL DeleteFromAccounts(1);
SELECT * FROM Accounts;

-- Delete from Monthly Bill table
DELIMITER $$
CREATE PROCEDURE DeleteFromMonthlyBill(IN m_id int)
BEGIN
    DELETE FROM Monthly_Bill
    WHERE Bill_ID = m_id;
END$$
DELIMITER ;
CALL DeleteFromMonthlyBill(31);
SELECT * FROM Monthly_Bill;