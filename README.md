Hospital Management System Database

Overview

This project provides a comprehensive database schema for managing hospital admissions, patient records, lab tests, treatments, and related data. The schema includes various tables and relationships designed to handle the complex data requirements of a hospital system. Additionally, several SQL queries are provided to extract meaningful insights and manage the data effectively.


Table of Contents: 

I) Database Creation

II) Sample Data Insertion

III) Important Queries

IV) Grand Challenge


Database Schema

The database consists of the following tables:

1) admissions: Records patient admissions, including the unit name and time period of stay.

2) diagnosis: Stores diagnoses made for patients, along with the time of diagnosis.

3) lab: Contains lab test results for patients.

4) patients: Holds patient demographic information.

5) physical_exam: Records physical exam data for patients.

6) treatment: Tracks treatments administered to patients.

7) lab_name: A reference table for lab test types and their acceptable ranges.

8) treatment_pricing: A reference table for treatment names and their costs.

9) lab_pricing: A reference table for lab tests and their costs.

10) payments: Stores payment information made by patients.

