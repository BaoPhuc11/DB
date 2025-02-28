USE LeaveManagement;
GO


CREATE TABLE Teams (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Employees (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    team_id INT NULL,
    FOREIGN KEY (team_id) REFERENCES Teams(id) ON DELETE SET NULL
);


CREATE TABLE Roles (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE Features (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    endpoint VARCHAR(255) NOT NULL
);


CREATE TABLE Employee_Roles (
    employee_id INT,
    role_id INT,
    PRIMARY KEY (employee_id, role_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES Roles(id) ON DELETE CASCADE
);


CREATE TABLE Role_Features (
    role_id INT,
    feature_id INT,
    PRIMARY KEY (role_id, feature_id),
    FOREIGN KEY (role_id) REFERENCES Roles(id) ON DELETE CASCADE,
    FOREIGN KEY (feature_id) REFERENCES Features(id) ON DELETE CASCADE
);


CREATE TABLE Leave_Requests (
    id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    reason TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'Inprogress',
    FOREIGN KEY (employee_id) REFERENCES Employees(id) ON DELETE CASCADE
);

CREATE TABLE Leave_Request_History (
    id INT IDENTITY(1,1) PRIMARY KEY,
    leave_request_id INT NOT NULL,
    action VARCHAR(50) NOT NULL,
    reason TEXT NULL,
    processed_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (leave_request_id) REFERENCES Leave_Requests(id) ON DELETE CASCADE
);


CREATE TABLE Work_Schedule (
    id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT NOT NULL,
    work_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(id) ON DELETE CASCADE
);
