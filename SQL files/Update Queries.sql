-- Update City Table --
DELIMITER $$
CREATE PROCEDURE UpdateCity(IN id int, IN new_city varchar(255))
BEGIN
	UPDATE City
	SET City_Name = new_city
    WHERE City_ID = id;
END$$
DELIMITER ;
CALL UpdateCity(4, 'Canlaon');

-- Update Village Table --
DELIMITER $$
CREATE PROCEDURE UpdateVillage(IN v_id int, IN new_village varchar(255))
BEGIN
	UPDATE Village
	SET Village_Name = new_village
    WHERE Village_ID = v_id;
END$$
DELIMITER ;
CALL UpdateVillage(4, 'Masulog');

-- Update Accounts Table--
DELIMITER $$
CREATE PROCEDURE UpdateAccount(IN id int, IN new_name varchar(255), IN new_village int)
BEGIN
	UPDATE Accounts
	SET Client_Name = new_name, Village_ID = new_village
    WHERE Client_ID = id;
END$$
DELIMITER ;
CALL UpdateAccount(8, 'Raymundo', 18);

-- Updates Monthly Bill Table --
DELIMITER $$
CREATE PROCEDURE UpdateMonthlyBill(IN id int, IN b_date date, IN d_date date, IN kwh int)
BEGIN
	DECLARE b_amount float; 
	SET b_amount = (820 + 80 + (kwh * 8.17));
    INSERT INTO Monthly_Bill(Client_ID, Bill_Date, Due_date, Bill_amount)
    SELECT id, b_date , d_date, b_amount;
END$$
DELIMITER ;
CALL UpdateMonthlyBill(50, '2018-3-13', '2018-2-22', 79);