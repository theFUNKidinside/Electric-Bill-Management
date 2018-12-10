-- City Name, Village Name, and average of the average monthly bill per account --
DELIMITER $$
CREATE PROCEDURE GetCityVillageAndAverage()
BEGIN
    SELECT City_Name, Village_Name, AVG(avgamt) as 'Average Monthly Bill'
	FROM City as c 
    INNER JOIN Village as v on v.City_ID = c.City_ID
	INNER JOIN (
	SELECT Village_ID, (SELECT avg(Bill_Amount) 
    FROM GroupA.Monthly_Bill b WHERE b.Client_ID = a.Client_ID) as avgamt FROM Accounts as a
) 	as x on x.Village_ID = v.Village_ID
	GROUP BY City_Name, Village_Name;
END$$
DELIMITER ;
CALL GetCityVillageAndAverage();

-- Cities and Villages with number of accounts greater than the average accounts per village --
DELIMITER $$
CREATE PROCEDURE GetCityAndVillageGreaterThanAverage()
BEGIN
    SELECT c.City_Name, v.village_name, count(a.Client_ID) as 'Number of Accounts'
	FROM GroupA.Accounts as a
	INNER JOIN GroupA.Village as v on v.Village_ID = a.Village_ID
	INNER JOIN GroupA.City as c on c.City_ID = v.City_ID
	GROUP BY a.Village_ID
	HAVING COUNT(a.Client_ID) > (
		SELECT AVG(ave) FROM (
			SELECT a.Village_ID, COUNT(a.Client_ID) ave
			FROM GroupA.Accounts as a
			GROUP BY a.Village_ID
		) as x
);
END$$
DELIMITER ;
CALL GetCityAndVillageGreaterThanAverage();

-- Accounts with average monthly bill greater than parameters --
DELIMITER $$
CREATE PROCEDURE GetAccountsGreaterThanParameters(IN amount int)
BEGIN
    SELECT Client_Name
	FROM Accounts as a
	WHERE (SELECT AVG(Bill_Amount) FROM GroupA.Monthly_Bill as b WHERE b.Client_ID = a.Client_ID) > amount;
END$$
DELIMITER ;     
CALL GetAccountsGreaterThanParameters(1500);


-- Minimum and maximum bill for each account between param_start and param_end --
DELIMITER $$
CREATE PROCEDURE GetMinAndMaxBill(IN start_date date, IN end_date date)
BEGIN
	SELECT a.Client_ID, a.Client_Name, MIN(Bill_Amount) as 'Minimum', MAX(Bill_Amount) as 'Maximum' 
	FROM monthly_bill as mb
	INNER JOIN groupa.accounts as a on a.Client_ID=mb.Client_ID
	WHERE Bill_Date BETWEEN start_date AND end_date
	GROUP BY a.Client_ID
	ORDER BY a.Client_ID;
END$$
DELIMITER ;
CALL GetMinAndMaxBill('2018-01-13', '2019-05-22');
drop procedure GetMinAndMaxBill;


-- Number of Accounts per City and Village --
DELIMITER $$
CREATE PROCEDURE GetNumberOfAccounts()
BEGIN
    SELECT c.City_Name, (SELECT COUNT(*) FROM GroupA.Accounts as a2 
    INNER JOIN GroupA.Village as v2 on v2.Village_ID = a2.Village_ID 
    WHERE v2.City_ID = c.City_ID) as City_Account, v.village_name, 
    COUNT(a.Client_ID) Village_Account
	FROM GroupA.Accounts as a
	INNER JOIN Village as v on v.Village_ID = a.Village_ID
	INNER JOIN City as c on c.City_ID = v.City_ID
	GROUP BY c.City_Name, v.village_name
	ORDER BY c.City_Name, v.village_name;
END$$
DELIMITER ;
CALL GetNumberOfAccounts();