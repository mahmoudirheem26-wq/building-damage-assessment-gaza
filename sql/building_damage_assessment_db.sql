CREATE TYPE severity_type AS ENUM (
    'Low',
    'Medium',
    'High',
    'Critical'
);

CREATE TYPE media_type_enum AS ENUM (
    'Image',
    'Video'
);

-- OWNER

CREATE TABLE owner (
    owner_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    national_id VARCHAR(30) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

-- ENGINEER

CREATE TABLE engineer (
    engineer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE
);

-- BUILDING

CREATE TABLE building (
    building_id SERIAL PRIMARY KEY,
    owner_id INT NOT NULL,
    location VARCHAR(200) NOT NULL,
    building_type VARCHAR(50),
    floors INT,
    construction_year INT,

    CONSTRAINT fk_building_owner
    FOREIGN KEY (owner_id)
    REFERENCES owner(owner_id)
);

-- ASSESSMENT

CREATE TABLE assessment (
    assessment_id SERIAL PRIMARY KEY,
    building_id INT NOT NULL,
    engineer_id INT NOT NULL,
    assessment_date DATE NOT NULL,
    overall_severity severity_type NOT NULL,
    notes TEXT,

    CONSTRAINT fk_assessment_building
    FOREIGN KEY (building_id)
    REFERENCES building(building_id),

    CONSTRAINT fk_assessment_engineer
    FOREIGN KEY (engineer_id)
    REFERENCES engineer(engineer_id)
);

-- DAMAGE

CREATE TABLE damage (
    damage_id SERIAL PRIMARY KEY,
    damage_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- ASSESSMENT_DAMAGE

CREATE TABLE assessment_damage (
    assessment_id INT NOT NULL,
    damage_id INT NOT NULL,
    severity_level severity_type NOT NULL,

    PRIMARY KEY (assessment_id, damage_id),

    CONSTRAINT fk_assessment_damage_assessment
    FOREIGN KEY (assessment_id)
    REFERENCES assessment(assessment_id),

    CONSTRAINT fk_assessment_damage_damage
    FOREIGN KEY (damage_id)
    REFERENCES damage(damage_id)
);

-- MEDIA
CREATE TABLE media (
    media_id SERIAL PRIMARY KEY,
    assessment_id INT NOT NULL,
    file_name VARCHAR(150) NOT NULL,
    media_type media_type_enum NOT NULL,
    file_path VARCHAR(300),
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_media_assessment
    FOREIGN KEY (assessment_id)
    REFERENCES assessment(assessment_id)
);

-- REPORT

CREATE TABLE report (
    report_id SERIAL PRIMARY KEY,
    assessment_id INT UNIQUE NOT NULL,
    generated_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    file_path VARCHAR(300),

    CONSTRAINT fk_report_assessment
    FOREIGN KEY (assessment_id)
    REFERENCES assessment(assessment_id)
);

-- Trigger Function
CREATE OR REPLACE FUNCTION check_severity()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.overall_severity IS NULL THEN
        RAISE EXCEPTION 'Severity level cannot be empty';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_check_severity
BEFORE INSERT OR UPDATE ON assessment
FOR EACH ROW
EXECUTE FUNCTION check_severity();
