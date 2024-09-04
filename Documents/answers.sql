-- Creating the hospital_db database
CREATE DATABASE hospital_db;

-- Selecting the hospital_db database
USE hospital_db;

-- Creating the patients table
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    language VARCHAR(20) NOT NULL
);

-- Creating the providers table
CREATE TABLE providers (
    provider_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    provider_speciality VARCHAR(50) NOT NULL,
    email_address VARCHAR(100),
    phone_number VARCHAR(15),
    date_joined DATE NOT NULL
);

-- Creating the visits table
CREATE TABLE visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    provider_id INT,
    date_of_visit DATE NOT NULL,
    date_scheduled DATE NOT NULL,
    visit_department_id INT,
    visit_type VARCHAR(50) NOT NULL,
    blood_pressure_systollic INT,
    blood_pressure_diastollic DECIMAL(5,2),
    pulse DECIMAL(5,2),
    visit_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);

-- Creating the ed_visits table
CREATE TABLE ed_visits (
    ed_visit_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT,
    patient_id INT,
    acuity INT NOT NULL,
    reason_for_visit VARCHAR(255) NOT NULL,
    disposition VARCHAR(255) NOT NULL,
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Creating the admissions table
CREATE TABLE admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    admission_date DATE NOT NULL,
    discharge_date DATE NOT NULL,
    discharge_disposition VARCHAR(255) NOT NULL,
    service VARCHAR(50) NOT NULL,
    primary_diagnosis VARCHAR(255) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Creating the discharges table
CREATE TABLE discharges (
    discharge_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_id INT,
    patient_id INT,
    discharge_date DATE NOT NULL,
    discharge_disposition VARCHAR(255) NOT NULL,
    FOREIGN KEY (admission_id) REFERENCES admissions(admission_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- question 1.1
SELECT first_name, last_name, date_of_birth
FROM patients;

-- question 1.2
SELECT provider_id, first_name, provider_speciality
FROM providers
LIMIT 0, 1000;

-- question 2.1
SELECT *
FROM patients
WHERE first_name LIKE 'Ab%';

-- question 2.2
SELECT *
FROM providers
WHERE provider_speciality LIKE '%y';

-- question 3.1
SELECT *
FROM patients
WHERE date_of_birth > '1980-01-01';

-- question 3.2
SELECT *
FROM ed_visits
WHERE acuity >= 2;

-- question 4.1
SELECT *
FROM patients
WHERE language = 'Spanish';

-- question 4.2
SELECT *
FROM ed_visits
WHERE reason_for_visit = 'Migraine' AND disposition = 'Admitted';

-- question 4.3
SELECT *
FROM patients
WHERE date_of_birth BETWEEN '1975-01-01' AND '1980-12-31';

-- question 5.1
SELECT first_name, last_name
FROM patients
ORDER BY last_name;

-- question 5.2
SELECT *
FROM visits
ORDER BY date_of_visit DESC;

-- question 6.1
SELECT *
FROM admissions
WHERE primary_diagnosis = 'Stroke' AND discharge_disposition = 'Home';

-- question 6.2
SELECT *
FROM providers
WHERE date_joined > '1995-01-01'
  AND (provider_speciality = 'Pediatrics' OR provider_speciality = 'Cardiology');

-- Bonus Challenge
SELECT *
FROM discharges
WHERE discharge_disposition = 'Home'
  AND discharge_date BETWEEN '2018-03-01' AND '2018-03-07';






