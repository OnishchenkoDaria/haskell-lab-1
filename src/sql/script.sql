CREATE DATABASE IF NOT EXISTS `Software_Package_Development_University`;
USE `Software_Package_Development_University`;

CREATE TABLE IF NOT EXISTS students(
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    `group` VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
    );

CREATE TABLE IF NOT EXISTS teachers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    teacher_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    email VARCHAR(100) UNIQUE
    );

CREATE TABLE IF NOT EXISTS software_packages(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    `description` TEXT,
    `version` VARCHAR(50),
    author_id INT NOT NULL,
    author_type ENUM('student', 'teacher') NOT NULL,
    CONSTRAINT chk_author_type CHECK (author_type IN ('student', 'teacher'))
    );

CREATE TABLE seminars (
    id INT AUTO_INCREMENT PRIMARY KEY,
    topic VARCHAR(150) NOT NULL,
    `date` DATE,
    audience INT
);

CREATE TABLE demonstrations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    package_id INT NOT NULL,
    `date` DATE,
    audience INT,
    FOREIGN KEY (package_id) REFERENCES software_packages(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    package_id INT NOT NULL,
    test_date DATE,
    result INT, # 1-100 points
    FOREIGN KEY (package_id) REFERENCES software_packages(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE student_teacher_relation (
    student_id INT NOT NULL,
    teacher_id INT NOT NULL,
    PRIMARY KEY (student_id, teacher_id),
    FOREIGN KEY (student_id) REFERENCES students(id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
        ON DELETE CASCADE ON UPDATE CASCADE
);