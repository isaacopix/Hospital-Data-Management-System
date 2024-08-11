Hospital Management System Database

Overview

This project provides a comprehensive database schema for managing hospital admissions, patient records, lab tests, treatments, and related data. The schema includes various tables and relationships designed to handle the complex data requirements of a hospital system. Additionally, several SQL queries are provided to extract meaningful insights and manage the data effectively.


Table of Contents

Database Creation
Sample Data Insertion
Important Queries
Grand Challenge
Database Schema

The database consists of the following tables:

admissions: Records patient admissions, including the unit name and time period of stay.
diagnosis: Stores diagnoses made for patients, along with the time of diagnosis.
lab: Contains lab test results for patients.
patients: Holds patient demographic information.
physical_exam: Records physical exam data for patients.
treatment: Tracks treatments administered to patients.
lab_name: A reference table for lab test types and their acceptable ranges.
treatment_pricing: A reference table for treatment names and their costs.
lab_pricing: A reference table for lab tests and their costs.
payments: Stores payment information made by patients.

