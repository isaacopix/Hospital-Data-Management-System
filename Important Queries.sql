/* a) Getting a list of all admissions that are not yet discharged: */

/* Select all columns from the admissions table */
SELECT *
FROM project.admissions
/* Filter the results to only include rows where the discharge date is still set to 'INFINITY' */
WHERE upper(period) = 'INFINITY';

/* b) Getting the acceptable ranges of lab results for each lab type: */

/* 
   Select the patient's name, lab test name, and the lab result 
   Join the lab table with the patients table based on patient_id 
   Join the lab_name table to get the acceptable ranges for each lab test 
   Filter the results to only include those where the lab result is outside the acceptable range 
*/
SELECT patients.name, lab.lab_name, lab.lab_result
FROM project.patients
INNER JOIN project.lab ON patients.patient_id = lab.patient_id
INNER JOIN project.lab_name ON lab.lab_name = lab_name.lab_name
WHERE lab.lab_result NOT BETWEEN lower(lab_name.acceptable_range) AND upper(lab_name.acceptable_range);

/* c) Getting a list of all patients who have not settled their bills: */

/* 
   Calculate the total cost of services (labs and treatments) for each patient 
   by combining lab and treatment costs. 
*/
WITH service_costs AS (
    SELECT patient_id, SUM(cost) AS total_cost
    FROM (
        /* Select the cost of lab tests for each patient */
        SELECT patient_id, cost
        FROM project.lab
        INNER JOIN project.lab_pricing ON lab.lab_name = lab_pricing.lab_name
        /* Union with the cost of treatments for each patient */
        UNION ALL
        SELECT patient_id, cost
        FROM project.treatment
        INNER JOIN project.treatment_pricing ON treatment.treatment_name = treatment_pricing.treatment_name
    ) AS services
    /* Group the results by patient_id to get the total cost per patient */
    GROUP BY patient_id
), 
/* Calculate the cost of bed occupancy for each patient */
bed_costs AS (
    SELECT patient_id, 200 * DATE_PART('day', AGE(upper(period), lower(period))) AS cost
    FROM project.admissions
)
/* 
   Select the names of patients who have not settled their bills 
   by comparing their payments against their total costs.
*/
SELECT patients.name
FROM project.patients
LEFT JOIN service_costs ON patients.patient_id = service_costs.patient_id
LEFT JOIN bed_costs ON patients.patient_id = bed_costs.patient_id
INNER JOIN project.payments ON patients.patient_id = payments.patient_id
LEFT JOIN project.admissions ON patients.patient_id = admissions.patient_id
WHERE payments.amount < 
    CASE
        /* If both service and bed costs are NULL, the total amount due is 0 */
        WHEN service_costs.total_cost IS NULL AND bed_costs.cost IS NULL THEN 0
        /* If only service costs are NULL, the total amount due is the bed cost */
        WHEN service_costs.total_cost IS NULL THEN bed_costs.cost
        /* If only bed costs are NULL, the total amount due is the service cost */
        WHEN bed_costs.cost IS NULL THEN service_costs.total_cost
        /* Otherwise, the total amount due is the sum of service and bed costs */
        ELSE service_costs.total_cost + bed_costs.cost
    END
    /* Exclude patients who are still admitted (discharge date is 'INFINITY') */
    AND upper(admissions.period) != 'INFINITY';

/* d) Getting the latest 3 diagnoses for each patient: */

/* 
   Assign a row number to each diagnosis, ordered by diagnosis timestamp in descending order 
   Filter to only include the latest 3 diagnoses per patient 
   Select all columns from the filtered results 
*/
WITH latest_diagnosis AS (
    SELECT patient_id, diagnosis_name, diagnosis_timestamp, 
           ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY diagnosis_timestamp DESC) AS rn
    FROM project.diagnosis
), 
latest_three_diagnosis AS (
    SELECT patient_id, diagnosis_name, diagnosis_timestamp
    FROM latest_diagnosis
    WHERE rn <= 3
)
SELECT *
FROM latest_three_diagnosis;
