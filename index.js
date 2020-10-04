const mysql = require('mysql');
const inquirer = require('inquirer');
const Table = require('console.table');
const { type } = require('os');

connection = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: 'Sancho$07',
  database: 'employee_db',
});

connection.connect(function (err) {
  if (err) throw err;
  runSearch();
});

function runSearch() {
  inquirer
    .prompt({
      name: 'action',
      type: 'rawlist',
      message: 'What would you like to do?',
      choices: [
        'Add department',
        'Add role',
        'Add employee',
        'View all employees',
        'View employees by department',
        'View all departments',
        'View all roles',
        'Update employee role',
        'Exit',
      ],
    })
    .then(function (answer) {
      switch (answer.action) {
        case 'Add department':
          addDepartment();
          break;

        case 'Add role':
          addRole();
          break;

        case 'Add employee':
          addEmployee();
          break;

        case 'View all employees':
          viewEmployees();
          break;

        case 'View employees by department':
          viewByDept();
          break;

        case 'View all departments':
          viewAllDept();
          break;

        case 'View all roles':
          viewAllRoles();
          break;

        case 'Update employee role':
          updateRoles();
          break;

        case 'Exit':
          connection.end();
          break;
      }
    });
}

function addDepartment() {
  inquirer
    .prompt([
      {
        name: 'department',
        type: 'input',
        message: 'Enter new departments name',
      },
    ])
    .then(function (answer) {
      query = `INSERT INTO department SET ?`;
      connection.query(
        query,
        {
          name: answer.department,
        },
        (err) => {
          if (err) throw err;
          console.log('Added new department!');
          runSearch();
        }
      );
    });
}

function addRole() {
  inquirer
    .prompt([
      {
        name: 'title',
        type: 'input',
        message: 'Enter title of new role',
      },
      {
        name: 'salary',
        type: 'input',
        message: 'Enter salary for role',
      },
      {
        name: 'departmentid',
        type: 'list',
        message: 'Select department id for role',
        choices: ['1', '2', '3', '4', '5'],
      },
    ])
    .then(function (answer) {
      query = `INSERT INTO role SET ?`;
      connection.query(
        query,
        {
          title: answer.title,
          salary: answer.salary,
          department_id: answer.departmentid,
        },
        (err) => {
          if (err) throw err;
          console.log('Added new role!');
          runSearch();
        }
      );
    });
}

function addEmployee() {
  inquirer
    .prompt([
      {
        name: 'firstname',
        type: 'input',
        message: 'Enter employees first name',
      },
      {
        name: 'lastname',
        type: 'input',
        message: 'Enter employees last name',
      },
      {
        name: 'roleid',
        type: 'list',
        message: 'Select role id',
        choices: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'],
      },
      {
        name: 'managerid',
        type: 'list',
        message: 'Select manager id',
        choices: ['1', '3', '5', '8', '10', '12'],
      },
    ])
    .then(function (answer) {
      query = `INSERT INTO employee SET ?`;
      connection.query(
        query,
        {
          first_name: answer.firstname,
          last_name: answer.lastname,
          role_id: answer.roleid,
          manager_id: answer.managerid,
        },
        (err) => {
          if (err) throw err;
          console.log('Added new employee!');
          runSearch();
        }
      );
    });
}

function viewEmployees() {
  query = `SELECT employee.id, employee.first_name AS "First Name", employee.last_name AS "Last Name", role.title, department.name AS "Department", role.salary AS "Salary"
  FROM employee 
  LEFT JOIN role 
  ON role.id = employee.role_id 
  LEFT JOIN department  
  ON department.id = role.department_id
  ORDER BY employee.id;`;
  connection.query(query, (err, res) => {
    if (err) throw err;
    console.table(res);
    runSearch();
  });
}

function viewByDept() {
  connection.query('SELECT * FROM department', function (err, res) {
    if (err) throw err;
    inquirer
      .prompt({
        name: 'department',
        type: 'list',
        message: 'Select department to view',
        choices: [
          connection.query('SELECT * FROM department', function (err, res) {
            if (err) throw err;
          }),
        ],
      })
      .then(function (answer) {
        query = `SELECT employee.id, employee.first_name AS "First Name", employee.last_name AS "Last Name", role.title, department.name AS "Department", role.salary AS "Salary"
        FROM employee 
        LEFT JOIN role 
        ON role.id = employee.role_id 
        LEFT JOIN department  
        ON role.department_id = department.id WHERE department.name = '${answer.department}'`;
        connection.query(query, (err, res) => {
          if (err) throw err;
          console.table(res);
          runSearch();
        });
      });
  });
}

function viewAllDept() {
  query = `SELECT id, name AS "Departments" FROM department`;
  connection.query(query, (err, res) => {
    if (err) throw err;
    console.table(res);
    runSearch();
  });
}

function viewAllRoles() {
  query = `SELECT id, title AS "Title" FROM role`;
  connection.query(query, (err, res) => {
    if (err) throw err;
    console.table(res);
    runSearch();
  });
}

function updateRoles() {
  inquirer
    .prompt([
      {
        name: 'id',
        type: 'input',
        message: 'Enter id of employee',
      },
      {
        name: 'newrole',
        type: 'input',
        message: 'Enter employees new role id',
      },
    ])
    .then(function (answer) {
      connection.query(
        `UPDATE employee SET ? WHERE ?`,
        [
          {
            role_id: answer.newrole,
          },
          {
            id: answer.id,
          },
        ],
        (err) => {
          if (err) throw err;
          console.log('Updated employee!');
          runSearch();
        }
      );
    });
}
