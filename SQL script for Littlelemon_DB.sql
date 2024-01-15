-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemon_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemon_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemon_DB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemon_DB` ;

-- -----------------------------------------------------
-- Table `LittleLemon_DB`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon_DB`.`menuitems` (
  `MenuItemID` INT NOT NULL,
  `CourseName` VARCHAR(225) NOT NULL,
  `StarterName` VARCHAR(225) NOT NULL,
  `DesertName` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon_DB`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon_DB`.`menu` (
  `Menuid` INT NOT NULL,
  `MenuItemid` INT NOT NULL,
  `cuisine` VARCHAR(45) NOT NULL,
  `MenuName` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`Menuid`),
  INDEX `MenuItemId_idx` (`MenuItemid` ASC) VISIBLE,
  CONSTRAINT `MenuItemId`
    FOREIGN KEY (`MenuItemid`)
    REFERENCES `LittleLemon_DB`.`menuitems` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon_DB`.`Order Delivery Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon_DB`.`Order Delivery Status` (
  `DeliveryID` INT NOT NULL,
  `DeliveryDate` DATE NOT NULL,
  `DeliveryStatus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeliveryID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon_DB`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon_DB`.`customer` (
  `CustomerID` INT NOT NULL,
  `First Name` VARCHAR(45) NOT NULL,
  `Last Name` VARCHAR(45) NOT NULL,
  `ContactNumber` BIGINT NOT NULL,
  `Address` VARCHAR(225) NOT NULL,
  `Email` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon_DB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon_DB`.`orders` (
  `OrderID` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `TotalCost` DECIMAL NOT NULL,
  `OrderDate` DATE NOT NULL,
  `DeliveryID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  INDEX `DeliveryID_idx` (`DeliveryID` ASC) VISIBLE,
  INDEX `CustomerId_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemon_DB`.`menu` (`Menuid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `DeliveryID`
    FOREIGN KEY (`DeliveryID`)
    REFERENCES `LittleLemon_DB`.`Order Delivery Status` (`DeliveryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ordersCustomerId`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemon_DB`.`customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon_DB`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon_DB`.`staff` (
  `StaffID` INT NOT NULL,
  `Name` VARCHAR(225) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(225) NOT NULL,
  `ContactNumber` BIGINT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `AnnualSalary` VARCHAR(225) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemon_DB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemon_DB`.`Bookings` (
  `BookingsID` INT NOT NULL AUTO_INCREMENT,
  `Bookingdate` DATE NOT NULL,
  `StaffID` INT NULL,
  `TableNo` INT NOT NULL,
  `CustomerID` INT NULL,
  PRIMARY KEY (`BookingsID`),
  INDEX `StaffID_idx` (`StaffID` ASC) VISIBLE,
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `StaffID`
    FOREIGN KEY (`StaffID`)
    REFERENCES `LittleLemon_DB`.`staff` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `bookingsCustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemon_DB`.`customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `LittleLemon_DB`.`menuitems`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemon_DB`;
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (1, 'Pizza', 'Chopped Italian Salad', 'Red wine');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (2, 'Spaghetti', 'Bruschetta', 'White wine');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (3, 'Lasagne', 'Crostini', 'Campari Soda');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (4, 'Lamb Stifado', 'Meze Platter', 'Tsikoudia');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (5, 'Souvlaki', 'Stuffed Cucumber Bites', 'Mastika');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (6, 'Spanikopita', 'Salad Skewers', 'Ouzo');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (7, 'Dal Chaaval', 'Paneer 65', 'Chai');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (8, 'Puttu Kadala', 'Pazhampori', 'Sambharam');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (9, 'Sambar rice', 'Vada', 'Kambu kool');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (10, 'Chow mein', 'Spring roll', 'Coconut milk');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (11, 'Kung Pao', 'Baby corn fritters', 'Kombucha');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (12, 'Chinese hotpot', 'Wontons', 'Bubbletea');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (13, 'Bulgogi', 'Kimchi pancake', 'Soju');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (14, 'Samgyupsal', 'Chicken wings', 'Makgeolli');
INSERT INTO `LittleLemon_DB`.`menuitems` (`MenuItemID`, `CourseName`, `StarterName`, `DesertName`) VALUES (15, 'Jajangmyeon', 'Pickled Radish', 'Sikhye');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemon_DB`.`menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemon_DB`;
INSERT INTO `LittleLemon_DB`.`menu` (`Menuid`, `MenuItemid`, `cuisine`, `MenuName`) VALUES (1, 2, 'Italian', 'Menu1');
INSERT INTO `LittleLemon_DB`.`menu` (`Menuid`, `MenuItemid`, `cuisine`, `MenuName`) VALUES (2, 5, 'Greek', 'Menu2');
INSERT INTO `LittleLemon_DB`.`menu` (`Menuid`, `MenuItemid`, `cuisine`, `MenuName`) VALUES (3, 8, 'Indian', 'Menu3');
INSERT INTO `LittleLemon_DB`.`menu` (`Menuid`, `MenuItemid`, `cuisine`, `MenuName`) VALUES (4, 10, 'Chinese', 'Menu4');
INSERT INTO `LittleLemon_DB`.`menu` (`Menuid`, `MenuItemid`, `cuisine`, `MenuName`) VALUES (5, 15, 'Korean', 'Menu5');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemon_DB`.`Order Delivery Status`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemon_DB`;
INSERT INTO `LittleLemon_DB`.`Order Delivery Status` (`DeliveryID`, `DeliveryDate`, `DeliveryStatus`) VALUES (1, '2023-07-04', 'Pending');
INSERT INTO `LittleLemon_DB`.`Order Delivery Status` (`DeliveryID`, `DeliveryDate`, `DeliveryStatus`) VALUES (2, '2023-07-23', 'Completed');
INSERT INTO `LittleLemon_DB`.`Order Delivery Status` (`DeliveryID`, `DeliveryDate`, `DeliveryStatus`) VALUES (3, '2023-07-01', 'Processed ');
INSERT INTO `LittleLemon_DB`.`Order Delivery Status` (`DeliveryID`, `DeliveryDate`, `DeliveryStatus`) VALUES (4, '2023-07-14', 'Completed');
INSERT INTO `LittleLemon_DB`.`Order Delivery Status` (`DeliveryID`, `DeliveryDate`, `DeliveryStatus`) VALUES (5, '2023-07-21', 'Completed');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemon_DB`.`customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemon_DB`;
INSERT INTO `LittleLemon_DB`.`customer` (`CustomerID`, `First Name`, `Last Name`, `ContactNumber`, `Address`, `Email`) VALUES (1, 'Olivia', 'Smith', 2344321234, '12 Dundas St', 'oliviasmith@gmail.com');
INSERT INTO `LittleLemon_DB`.`customer` (`CustomerID`, `First Name`, `Last Name`, `ContactNumber`, `Address`, `Email`) VALUES (2, 'Emma', 'Johnson', 4566543456, '56 Lee Centre Dr', 'emmajohnson@gmail.com');
INSERT INTO `LittleLemon_DB`.`customer` (`CustomerID`, `First Name`, `Last Name`, `ContactNumber`, `Address`, `Email`) VALUES (3, 'Charlotte', 'Williams', 7899876789, '57 Bay St', 'charlottewilliams@gmail.com');
INSERT INTO `LittleLemon_DB`.`customer` (`CustomerID`, `First Name`, `Last Name`, `ContactNumber`, `Address`, `Email`) VALUES (4, 'Amelia', 'Brown', 4322341243, '67 Adelaide Dr', 'ameliabrown@gmail.com');
INSERT INTO `LittleLemon_DB`.`customer` (`CustomerID`, `First Name`, `Last Name`, `ContactNumber`, `Address`, `Email`) VALUES (5, 'Sophia', 'Jones', 3455432345, '72 Carl Dr', 'sophiajones@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemon_DB`.`orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemon_DB`;
INSERT INTO `LittleLemon_DB`.`orders` (`OrderID`, `MenuID`, `Quantity`, `TotalCost`, `OrderDate`, `DeliveryID`, `CustomerID`) VALUES (1, 1, 10, 300.99, '2023-04-13', 1, 1);
INSERT INTO `LittleLemon_DB`.`orders` (`OrderID`, `MenuID`, `Quantity`, `TotalCost`, `OrderDate`, `DeliveryID`, `CustomerID`) VALUES (2, 3, 1, 140.80, '2023-05-04', 2, 2);
INSERT INTO `LittleLemon_DB`.`orders` (`OrderID`, `MenuID`, `Quantity`, `TotalCost`, `OrderDate`, `DeliveryID`, `CustomerID`) VALUES (3, 3, 3, 200.56, '2023-06-07', 3, 3);
INSERT INTO `LittleLemon_DB`.`orders` (`OrderID`, `MenuID`, `Quantity`, `TotalCost`, `OrderDate`, `DeliveryID`, `CustomerID`) VALUES (4, 5, 2, 170.34, '2023-06-30', 4, 4);
INSERT INTO `LittleLemon_DB`.`orders` (`OrderID`, `MenuID`, `Quantity`, `TotalCost`, `OrderDate`, `DeliveryID`, `CustomerID`) VALUES (5, 2, 2, 180.77, '2023-06-29', 5, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemon_DB`.`staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemon_DB`;
INSERT INTO `LittleLemon_DB`.`staff` (`StaffID`, `Name`, `Role`, `Address`, `ContactNumber`, `Email`, `AnnualSalary`) VALUES (1, 'Milo Warren', 'Head Waiter', '5 Bloor St', 4739674023, 'milowarren@gmail.com', '35000');
INSERT INTO `LittleLemon_DB`.`staff` (`StaffID`, `Name`, `Role`, `Address`, `ContactNumber`, `Email`, `AnnualSalary`) VALUES (2, 'Arron Norman', 'Head Chef', '56 Danfort Av', 3858648512, 'arronnorman@gmaiul.com', '70000');
INSERT INTO `LittleLemon_DB`.`staff` (`StaffID`, `Name`, `Role`, `Address`, `ContactNumber`, `Email`, `AnnualSalary`) VALUES (3, 'Jaxon Jenkins', 'Assistant waiter', '8 De Grassi St', 5678876567, 'jaxonjenkins@gmail.com', '24000');
INSERT INTO `LittleLemon_DB`.`staff` (`StaffID`, `Name`, `Role`, `Address`, `ContactNumber`, `Email`, `AnnualSalary`) VALUES (4, 'Alex England', 'Assistant Chef', '9 College St', 1746539648, 'alexengland@gmail.com', '50000');
INSERT INTO `LittleLemon_DB`.`staff` (`StaffID`, `Name`, `Role`, `Address`, `ContactNumber`, `Email`, `AnnualSalary`) VALUES (5, 'Jack Gilmore', 'Receptionist', '6 Eglington Av', 2375987634, 'jackgilmore@gmail.com', '65000');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemon_DB`.`Bookings`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemon_DB`;
INSERT INTO `LittleLemon_DB`.`Bookings` (`BookingsID`, `Bookingdate`, `StaffID`, `TableNo`, `CustomerID`) VALUES (1, '2023-07-04', 1, 5, 1);
INSERT INTO `LittleLemon_DB`.`Bookings` (`BookingsID`, `Bookingdate`, `StaffID`, `TableNo`, `CustomerID`) VALUES (2, '2023-07-23', 3, 3, 2);
INSERT INTO `LittleLemon_DB`.`Bookings` (`BookingsID`, `Bookingdate`, `StaffID`, `TableNo`, `CustomerID`) VALUES (3, '2023-07-01', 3, 2, 3);
INSERT INTO `LittleLemon_DB`.`Bookings` (`BookingsID`, `Bookingdate`, `StaffID`, `TableNo`, `CustomerID`) VALUES (4, '2023-07-14', 1, 2, 4);
INSERT INTO `LittleLemon_DB`.`Bookings` (`BookingsID`, `Bookingdate`, `StaffID`, `TableNo`, `CustomerID`) VALUES (5, '2023-07-21', 1, 1, 5);

COMMIT;

