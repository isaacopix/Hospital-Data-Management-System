/*
Grand Challenge:

Objective:

Combine all the admission periods into one `tstzmultirange` to represent all the times when the hospital has patients.
Using range subtraction, find all the dates and times when the hospital is completely devoid of admitted patients.
*/

WITH occupied_periods AS (
  /* Step 1: Aggregate all admission periods into a single `tstzmultirange`.
     This `multirange` will represent all the times when the hospital has at least one admitted patient. */
  SELECT unnest(range_agg(period))::tstzmultirange AS period
  FROM project.admissions
)
SELECT 
  /* Step 2: Subtract the `occ
  upied_periods` from the entire time range of interest.
     This will give us all the periods within the specified date range when the hospital is completely empty. */
  tstzrange('2023-02-01 00:00:00', '2023-05-31 23:59:59','[)')::tstzmultirange - period AS unoccupied_periods
FROM occupied_periods;




