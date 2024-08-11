CREATE SCHEMA project;
CREATE TABLE project.admissions (
    admission_id smallint NOT NULL,
    patient_id smallint NOT NULL,
    unit_name character varying(50),
    admission_time timestamp without time zone,
    discharge_time timestamp without time zone,
    CONSTRAINT chk_admission_time CHECK (((admission_time <= discharge_time) OR (discharge_time IS NULL)))
);

CREATE TABLE project.diagnosis (
    patient_id smallint NOT NULL,
    diagnosis_id smallint NOT NULL,
    diagnosis_name character varying(50),
    diagnosis_timestamp timestamp without time zone
);

CREATE TABLE project.lab (
    patient_id smallint NOT NULL,
    lab_id smallint NOT NULL,
    lab_name character varying(50) NOT NULL,
    lab_result numeric(10,2) NOT NULL,
    lab_text character varying(50) NOT NULL,
    lab_timestamp timestamp without time zone NOT NULL
);

CREATE TABLE project.patients (
    patient_id smallint NOT NULL,
    name character varying(50) NOT NULL,
    gender character(6) NOT NULL,
    date_birth date NOT NULL,
    ethnicity character varying(50) NOT NULL,
    height numeric(3,2) NOT NULL,
    CONSTRAINT ck_patientss_date_birth CHECK (((date_birth >= '1900-01-01'::date) AND (date_birth <= CURRENT_DATE)))
);

CREATE TABLE project.physical_exam (
    patient_id smallint NOT NULL,
    physicalexam_id smallint NOT NULL,
    physicalexam_value numeric(10,2) NOT NULL,
    physicalexam_text character varying(100) NOT NULL,
    physicalexam_timestamp timestamp without time zone NOT NULL
);

CREATE TABLE project.treatment (
    patient_id smallint NOT NULL,
    treatment_id smallint NOT NULL,
    treatment_name character varying(100),
    treatment_timestamp timestamp without time zone
);

ALTER TABLE ONLY project.admissions ADD CONSTRAINT pk_admissions PRIMARY KEY (admission_id);
ALTER TABLE ONLY project.diagnosis ADD CONSTRAINT pk_diagnosis PRIMARY KEY (diagnosis_id);
ALTER TABLE ONLY project.lab ADD CONSTRAINT pk_lab PRIMARY KEY (lab_id);
ALTER TABLE ONLY project.patients ADD CONSTRAINT pk_patients PRIMARY KEY (patient_id);
ALTER TABLE ONLY project.physical_exam ADD CONSTRAINT pk_physicalexam PRIMARY KEY (physicalexam_id);
ALTER TABLE ONLY project.treatment ADD CONSTRAINT pk_treatment PRIMARY KEY (treatment_id);
ALTER TABLE ONLY project.admissions ADD CONSTRAINT fk_patient_id_admission FOREIGN KEY (patient_id) REFERENCES project.patients(patient_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY project.diagnosis ADD CONSTRAINT fk_patient_id_diagnsois FOREIGN KEY (patient_id) REFERENCES project.patients(patient_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY project.lab ADD CONSTRAINT fk_patient_id_lab FOREIGN KEY (patient_id) REFERENCES project.patients(patient_id) ON UPDATE CASCADE ON DELETE CASCADE;
