INSERT INTO owner (full_name, national_id, phone)
VALUES
('Mahmoud Irheem', '900123456', '0597066855'),
('Heba Kordia', '900123457', '0597033526'),
('Mohammed Ayad', '900123458', '0598158422');


INSERT INTO engineer (first_name, last_name, phone, email)
VALUES
('Yasser', 'Awda', '0599111111', 'yasser@example.com'),
('Mohammed', 'Irheem', '0599222222', 'mohammed@example.com'),
('Mahmoud', 'Ibrahim', '0599333333', 'mahmoud@example.com');


INSERT INTO building
(owner_id, location, building_type, floors, construction_year)
VALUES
(1, 'Gaza City', 'Residential', 5, 2010),
(2, 'Khan Younis', 'Commercial', 3, 2005),
(3, 'Jabalia', 'Residential', 4, 2015);


INSERT INTO assessment
(building_id, engineer_id, assessment_date, overall_severity, notes)
VALUES
(1, 1, '2026-06-01', 'High', 'Major wall cracks'),
(2, 2, '2026-06-02', 'Medium', 'Roof damage observed'),
(3, 3, '2026-06-03', 'Critical', 'Foundation damage');


INSERT INTO damage
(damage_name, description)
VALUES
('Wall Crack', 'Cracks in walls'),
('Roof Damage', 'Roof partially damaged'),
('Column Damage', 'Structural column damage'),
('Foundation Damage', 'Foundation problems');


INSERT INTO assessment_damage
(assessment_id, damage_id, severity_level)
VALUES
(1,1,'High'),
(1,3,'High'),
(2,2,'Medium'),
(3,4,'Critical');


INSERT INTO media
(assessment_id, file_name, media_type, file_path)
VALUES
(1,'wall_crack.jpg','Image','/uploads/wall_crack.jpg'),
(2,'roof_damage.mp4','Video','/uploads/roof_damage.mp4'),
(3,'foundation_damage.jpg','Image','/uploads/foundation_damage.jpg');


INSERT INTO report
(assessment_id, file_path)
VALUES
(1,'/reports/report1.pdf'),
(2,'/reports/report2.pdf'),
(3,'/reports/report3.pdf');

SELECT
    b.building_id,
    o.full_name AS owner_name,
    o.phone,
    b.location,
    b.building_type,
    b.floors
FROM building b
JOIN owner o
ON b.owner_id = o.owner_id;

SELECT
    a.assessment_id,
    a.assessment_date,
    a.overall_severity,
    b.location,
    e.first_name || ' ' || e.last_name AS engineer_name
FROM assessment a
JOIN building b
ON a.building_id = b.building_id
JOIN engineer e
ON a.engineer_id = e.engineer_id;

SELECT
    a.assessment_id,
    b.location,
    d.damage_name,
    ad.severity_level
FROM assessment_damage ad
JOIN assessment a
ON ad.assessment_id = a.assessment_id
JOIN building b
ON a.building_id = b.building_id
JOIN damage d
ON ad.damage_id = d.damage_id
ORDER BY a.assessment_id;

SELECT
    building_type,
    COUNT(*) AS total_buildings
FROM building
GROUP BY building_type;

SELECT
    d.damage_name,
    COUNT(*) AS occurrence_count
FROM assessment_damage ad
JOIN damage d
ON ad.damage_id = d.damage_id
GROUP BY d.damage_name
ORDER BY occurrence_count DESC;

INSERT INTO assessment
(building_id, engineer_id, assessment_date, notes)
VALUES
(1,1,'2026-06-10','Test');
