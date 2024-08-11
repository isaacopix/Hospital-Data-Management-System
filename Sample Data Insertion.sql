
/*
1) Adding data
*/

/* Inserting lab names into the lab_name table:
   This is the first reference table with lab_name column that is used as a foreign key in the lab table. */
INSERT INTO project.lab_name (lab_name, acceptable_range) VALUES
('Blood Test', numrange(80,100,'[]')),
('Urinalysis', numrange(8,10,'[]')),
('X-Ray', numrange(0,1,'[]')),
('MRI', numrange(1,2,'[]')),
('ECG', numrange(75,100,'[]'));

/* Inserting into the treatment_pricing table:
   This is the second reference with treatment_name column that is used as a foreign key in the treatment table. */
INSERT INTO project.treatment_pricing(treatment_name, cost)
VALUES ('Antibiotics', 100.00),
       ('Intravenous fluids', 200.00),
       ('Painkillers', 100.00),
       ('Physical therapy', 500.00),
       ('Surgery', 1000.00);

/* Inserting into lab_pricing table:
   This is the third reference table with lab_name that is used as a foreign key in the lab table. */
INSERT INTO project.lab_pricing(lab_name, cost)
VALUES ('Blood Test', 100.00),
       ('Urinalysis', 200.00),
       ('X-Ray', 200.00),
       ('MRI', 500.00),
       ('ECG', 1000.00);

/* Inserting admission data in the admissions table:
   This includes one scenario where the upper bound of the period column is INFINITY,
   meaning the patient has not been discharged yet. 
   Also, two patients with the same unit name are included. */
INSERT INTO project.admissions (patient_id, unit_name, period) VALUES
  (101, 'ICU', TSTZRANGE('2023-02-15 12:00:00+00', '2023-02-18 08:00:00+00')),
  (102, 'ICU', TSTZRANGE('2023-02-15 08:00:00+00', '2023-02-28 09:00:00+00')),
  (103, 'Cardiology', TSTZRANGE('2023-03-05 16:00:00+00', '2023-03-15 11:30:00+00')),
  (104, 'Oncology', TSTZRANGE('2023-03-05 11:00:00+00', '2023-03-10 19:00:00+00')),
  (105, 'Neurology', TSTZRANGE('2023-03-08 14:30:00+00', 'INFINITY'));

/* Inserting patient data in the patients table:
   This table contains patient demographic data and uses the patient_id column as a foreign key to other tables.
   Two patients share the same birth date, two patients share the same ethnicity, and three patients share the same gender. */
INSERT INTO project.patients (patient_id, name, gender, date_birth, ethnicity, height) VALUES
  (101, 'John Doe', 'Male', '1980-05-20', 'Caucasian', 1.8),
  (102, 'Jane Smith', 'Female', '1995-02-14', 'African American', 1.6),
  (103, 'Samuel Johnson', 'Male', '1972-10-30', 'Hispanic', 1.75),
  (104, 'Emily Brown', 'Female', '1972-10-30', 'Asian', 1.65),
  (105, 'Michael Davis', 'Male', '1965-01-01', 'Caucasian', 1.86);

/* Inserting lab data into the lab table:
   Each patient is associated with a different lab. */
INSERT INTO project.lab (patient_id, lab_name, lab_result, lab_text, lab_timestamp) VALUES
  (101, 'Blood Test', 70.5, 'Complete Blood Count', '2023-02-15 11:00:00'),
  (102, 'Urinalysis', 8.3, 'pH level', '2023-02-15 12:30:00'),
  (103, 'X-Ray', 0.8, 'Bone density', '2023-03-05 15:00:00'),
  (104, 'MRI', 1.5, 'Brain scan', '2023-03-05 17:30:00'),
  (105, 'ECG', 70, 'Heart rate', '2023-03-08 11:00:00');

/* Inserting diagnosis data into the diagnosis table:
   Each patient has a unique diagnosis. */
INSERT INTO project.diagnosis (patient_id, diagnosis_name, diagnosis_timestamp) VALUES
  (101, 'Pneumonia', '2023-02-15 20:30:00'),
  (102, 'Asthma', '2023-02-15 15:45:00'),
  (103, 'Hypertension', '2023-03-05 19:20:00'),
  (104, 'Breast Cancer', '2023-03-05 11:30:00'),
  (105, 'Migraine', '2023-03-08 09:30:00');

/* Inserting into the physical_exam table:
   Some patients share the same physical exam. */
INSERT INTO project.physical_exam (patient_id, physicalexam_value, physicalexam_text, physicalexam_timestamp) VALUES
  (101, 120, 'Blood pressure', '2023-02-15 08:40:00'),
  (102, 80, 'Pulse rate', '2023-02-15 08:40:00'),
  (103, 118, 'Blood pressure', '2023-03-05 11:25:00'),
  (104, 80, 'Pulse rate', '2023-03-05 11:25:00'),
  (105, 122, 'Blood pressure', '2023-03-08 14:55:00');

/* Inserting into the treatment table:
   Three treatments occur days after diagnosis, and two occur on the same day. */
INSERT INTO project.treatment (patient_id, treatment_name, treatment_timestamp) VALUES
  (101, 'Antibiotics', '2023-02-15 15:00:00'),
  (102, 'Intravenous fluids', '2023-02-16 09:00:00'),
  (103, 'Painkillers', '2023-03-05 15:45:00'),
  (104, 'Physical Therapy', '2023-03-07 11:45:00'),
  (105, 'Surgery', '2023-03-12 15:30:00');

/* Inserting into the payments table:
   Two payments are fulfilled, and three are not. */
INSERT INTO project.payments (patient_id, date, amount) VALUES
  (101, '2023-02-28 10:00:00', 750.00),
  (102, '2023-02-20 10:30:00', 500.00),
  (103, '2023-03-21 12:00:00', 1000.00),
  (104, '2023-03-19 12:30:00', 1200.00),
  (105, '2023-03-20 16:00:00', 1500.00);

/*
2) UPDATE & DELETE
*/

/* Updating patient’s discharge time:
   Correcting the upper bound of the period column for patient_id 102 
   since the patient is still admitted. */
UPDATE project.admissions
SET period = TSTZRANGE(lower(period), 'infinity')
WHERE patient_id = 102;

/* Deleting a lab_name from the list of labs being administered:
   Assuming a lab is no longer being administered, deleting its lab_name. */
DELETE FROM project.lab_name
WHERE lab_name = 'Eye Test';

