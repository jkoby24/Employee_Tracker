CREATE DATABASE employee_db; 

USE employee_db; 

CREATE TABLE department( 
id INT AUTO_INCREMENT PRIMARY KEY, 
name VARCHAR(30) NOT NULL 
); 

CREATE TABLE role( 
id INT AUTO_INCREMENT PRIMARY KEY, 
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




INSERT INTO departments
    (department_name)
VALUES
    ('Sales'),
    ('Accounting'),
    ('IT'),
    ('Marketing'),
    ('Executive');

INSERT INTO roles
    (title, salary, department_id)
VALUES
    ('Marketing_Rep', 90000, 20),
    ('Marketing_Manager', 130000, 20),
    ('Data_analyst', 150000, 60),
    ('IT_Programmer', 130000, 60),
     ('Sales_Rep', 80000, 80),
    ('Sales_Manager', 120000, 80),
    ('VP', 300000, 90),
    ('Account_Manager', 120000, 110),
    ('Accountant', 100000, 110);
    

INSERT INTO employees
    (first_name, last_name, role_id, manager_id)
VALUES
    ('Steven', 'King', 1, NULL),
    ('Neena', 'Kochar', 2, 5 ),
    ('Nia', 'Hall', 3, NULL),
    ('Bruce', 'Austin', 4, ),
    ('Alex', 'Ernst', 5, NULL ),
    ('Peter', 'Tucker', 6, 5),
    ('Chris', 'Olsen', 7, NULL),
    ('Karen', 'Vargas', 8, 1),
    ('Jennifer', 'Whalen', 9, 7),
    ('Pat', 'Fay', 11, 5),
    ('Douglass', 'Grant', 12, 3),
    ('Julia', 'Bull', 13, 1),
    ('Alyssa', 'Hutton', 14, 3),
    ('Johnathan', 'Taylor', 15, 3),
    ('Chris', 'Olave', 16, 3),
    ('Lisa', 'Ozer', 17, 7),
    ('Patrick', 'Sully', 18, 5),
    ('Kobe', 'Bryant', 19, 5),
    ('LeBron', 'James', 20, 5),
    ('Rick', 'James', 21, 5),
    ('Rick', 'Fox', 22, 7),
    ('Ahmed', 'Jacobs', 23, 7),
    ('Kelly', 'Chung', 24, 7),
    ('Halle', 'Berry', 25, 7);