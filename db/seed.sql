DROP DATABASE IF EXISTS employee_db;

CREATE DATABASE employee_db; 

USE employee_db; 

CREATE TABLE department( 
id INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
name VARCHAR (30) NOT NULL
); 

CREATE TABLE role( 
 id INT AUTO_INCREMENT PRIMARY KEY NOT NULL, 
 title VARCHAR(30) NOT NULL, 
 salary DECIMAL (8,2) NOT NULL, 
 department_id INT NOT NULL, 
 FOREIGN KEY(department_id) REFERENCES department(id)
 ); 
 
 CREATE TABLE employee( 
id INT AUTO_INCREMENT PRIMARY KEY, 
 first_name VARCHAR(30) NOT NULL, 
 last_name VARCHAR (30) NOT NULL, 
 role_id INT NOT NULL, 
 manager_id INT, 
 FOREIGN KEY(role_id) REFERENCES role(id),
 FOREIGN KEY(manager_id) REFERENCES employee(id)
 ); 

SELECT * from department;



INSERT INTO department
    (name)
VALUES
    ('Sales'),
    ('Accounting'),
    ('IT'),
    ('Marketing'),
    ('Executive');

INSERT INTO role
    (title, salary, department_id)
VALUES
	('Sales_Manager', 120000, 1),
	('Sales_Rep', 80000, 1),
	('Account_Manager', 120000, 2),
    ('Accountant', 100000, 2),
    ('Project_Manager', 180000,3),
    ('Data_analyst', 150000, 3),
    ('IT_Programmer', 130000, 3),
    ('Marketing_Manager', 130000, 4),
    ('Marketing_Rep', 90000, 4),
    ('VP', 300000, 5);
    
     
   SELECT * FROM role; 
    
    

INSERT INTO employee
    (first_name, last_name, role_id, manager_id)
VALUES
    ('Steven', 'King', 1, NULL),
    ('Neena', 'Kochar', 2, 1 ),
    ('Nia', 'Hall', 2, 1),
    ('Bruce', 'Austin', 2, 1),
    ('Alex', 'Ernst', 3, NULL ),
    ('Peter', 'Tucker', 4, 3),
    ('Chris', 'Olsen', 4, 3),
    ('Karen', 'Vargas', 5, NULL),
    ('Jennifer', 'Whalen', 6, 5),
    ('Pat', 'Fay', 6, 5),
    ('Douglass', 'Grant', 7, 5),
    ('Julia', 'Bull', 7, 5),
    ('Alyssa', 'Hutton', 7, 5),
    ('Johnathan', 'Taylor', 7, 5),
    ('Chris', 'Olave', 7, 5),
    ('Lisa', 'Ozer', 7, 5),
    ('Patrick', 'Sully', 8, NULL),
    ('Kobe', 'Bryant', 9, 8),
    ('LeBron', 'James', 9, 8),
    ('Rick', 'James', 9, 8),
    ('Rick', 'Fox', 9, 8),
    ('Ahmed', 'Jacobs', 9, 8),
    ('Kelly', 'Chung', 9, 8),
    ('Halle', 'Berry', 10, NULL);

SELECT employee.id, employee.first_name AS "First Name", employee.last_name AS "Last Name", role.title, department.name AS "Department", role.salary AS "Salary", CONCAT(manager.first_name," ",manager.last_name) AS "Manager"

FROM employee 
LEFT JOIN role 
ON role.id = employee.role_id 
LEFT JOIN department  
ON department.id = role.department_id
LEFT JOIN employee manager ON manager.id = employee.manager_id
ORDER BY employee.id;