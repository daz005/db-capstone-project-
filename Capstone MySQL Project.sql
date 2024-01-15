use littlelemon_db;

select * from bookings;
select * from customer;
select * from menu;
select * from menuitems;
select * from `order delivery status`;
select * from orders;
select * from staff;

# Creating a view to summarize OrderID, Quantity and cost
CREATE VIEW OrdersView AS
select OrderID,Quantity,round(TotalCost,2)
from orders
where quantity > 2;
Select * from OrdersView;

#Information from four tables on all customers with orders that cost more than $150(includes CustomerID,FullName,OrderID,Cost,Menuname,Coursename,startername)
select c.CustomerID, concat(c.`First Name` ,' ',c.`Last Name`) AS "Full Name", o.OrderID,round(o.TotalCost,2) as cost, m.MenuName, mi.CourseName,mi.StarterName
from customer as c inner join orders as o on c.customerID = o.CustomerID
inner join menu as m on o.MenuID = m.Menuid
inner join menuitems as mi on m.MenuItemID = mi.MenuItemID
where o.TotalCost > 150
order by o.TotalCost;

#Menu items for which more than 2 orders have been placed.
select MenuName
from menu
where MenuID = any(select MenuID
from orders
where Quantity > 2);

#Procedure that displays the maximum ordered quantity in the Orders table. 
create procedure GetMaxQuantity()
select max(Quantity) as Max_Quantity_in_order
FROM orders
GO;
CALL GetMaxQuantity();

#Prepared statement to get order detail 
PREPARE GetOrderDetail from
'select o.OrderID,o.Quantity,o.TotalCost
from orders o inner join customer c on o.CustomerID = c.CustomerID
where c.CustomerID= ?';
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

#Procedure to delete an order record based on the user input of the order id.
DROP PROCEDURE IF EXISTS CancelOrder; 
DELIMITER //
CREATE PROCEDURE CancelOrder ( OID INT)
begin
DELETE FROM orders WHERE OrderID = OID ;
select concat('Order',OID,' is cancelled') as Confirmed;
END //
DELIMITER ;
call CancelOrder(5);

# To check whether a table in the restaurant is already booked
DROP PROCEDURE IF EXISTS CheckBooking ; 
CREATE PROCEDURE CheckBooking (Datebooking DATE, Tablenumber INT)
select concat('Table ',Tablenumber,' is already booked') as 'Booking status'
from bookings
where TableNo = Tablenumber and Bookingdate = Datebooking;
call CheckBooking("2023-07-04",5);

#Transaction procedure to commit valid bookings and rollback invalid ones.
DROP PROCEDURE IF EXISTS AddValidBooking;
DELIMITER //
CREATE PROCEDURE AddValidBooking ( datebooking DATE, tablenumber INT )
begin
START TRANSACTION;
INSERT INTO bookings (Bookingdate,TableNo) VALUES (datebooking,tablenumber);
#select * from booking;
IF (EXISTS(select count(TableNo) , count( Bookingdate) from bookings group by Bookingdate,TableNo having count(TableNo)>1 and count( Bookingdate)>1))
THEN SELECT concat('Table ',Tablenumber,' is already booked - BOOKING CANCELLED') as 'Booking status';
ROLLBACK;
else
COMMIT;
END IF;
END //
DELIMITER ;
call AddValidBooking('2023-07-04',5);
select * from bookings;

#Procedure to add a new table booking record
DROP PROCEDURE IF EXISTS AddBooking;
DELIMITER //
CREATE PROCEDURE AddBooking ( datebooking DATE, tablenumber INT,customerid INT )
begin
INSERT INTO bookings (Bookingdate,TableNo,CustomerID) VALUES (datebooking, tablenumber,customerid);
SELECT 'New booking added' as 'CONFIRMATION';
select * from bookings;
END //
DELIMITER ;
call AddBooking('2023-07-07',78,8);

# Procedure to update existing bookings in the booking table.
DROP PROCEDURE IF EXISTS UpdateBooking ;
DELIMITER //
CREATE PROCEDURE UpdateBooking  (bookingid INT, datebooking DATE )
begin
update bookings set Bookingdate = datebooking where BookingsID = bookingid;
SELECT concat('Booking ',bookingid,' updated.') as 'CONFIRMATION';
select * from bookings;
END //
DELIMITER ;
call UpdateBooking (2,'2023-07-22');

#Procedure called CancelBooking that they can use to cancel or remove a booking.
DROP PROCEDURE IF EXISTS CancelBooking  ;
DELIMITER //
CREATE PROCEDURE CancelBooking   (bookingid INT )
begin
delete from bookings where BookingsID = bookingid;
SELECT concat('Booking ',bookingid,' cancelled.') as 'CONFIRMATION';
select * from bookings;
END //
DELIMITER ;
call CancelBooking(2);




