-- Add New City --
DELIMITER $$
CREATE PROCEDURE AddCity(IN add_city varchar(255))
BEGIN
	INSERT INTO City(City_Name) 
    VALUES(add_city);
END$$
DELIMITER ;
CALL AddCity('Manila');

-- Add New Village --
DELIMITER $$
CREATE PROCEDURE AddVillage(IN add_village varchar(255), IN id int)
BEGIN
	INSERT INTO Village(Village_Name, City_ID) 
    VALUES(add_village, id);
END$$
DELIMITER ;
CALL AddVillage('Sta. Mesa', 4);

-- Add New Account --
DELIMITER $$
CREATE PROCEDURE AddAccount(IN add_account varchar(255), IN id int)
BEGIN
	INSERT INTO Accounts(Client_Name, Village_ID) 
    VALUES(add_account, id);
END$$
DELIMITER ;
CALL AddAccount('Villegas', 8);