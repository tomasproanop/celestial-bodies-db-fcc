-- Create the database
CREATE DATABASE universe;

-- Connect to the database
\c universe

-- Create galaxy table
CREATE TABLE galaxy(
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    meaning TEXT NOT NULL,
    is_visible_to_naked_eye BOOLEAN NOT NULL,
    age_in_million_years INT NOT NULL
);

-- Insert data into galaxy table
INSERT INTO galaxy (name, meaning, is_visible_to_naked_eye, age_in_million_years)
VALUES 
('Milky Way', 'Our own galaxy', TRUE, 13500),
('Andromeda', 'Nearest spiral galaxy', TRUE, 10000),
('Triangulum', 'Part of the Local Group', TRUE, 2000),
('Messier 81', 'Nearby spiral galaxy', FALSE, 11000),
('Whirlpool Galaxy', 'A grand-design spiral galaxy', FALSE, 450),
('Sombrero Galaxy', 'An unbarred spiral galaxy', FALSE, 29000);

-- Create star table
CREATE TABLE star(
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    distance_in_light_years NUMERIC(7, 2) NOT NULL,
    brightness_of_star NUMERIC(5, 2) NOT NULL,
    approval_date DATE,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id)
);

-- Insert data into star table
INSERT INTO star (name, distance_in_light_years, brightness_of_star, approval_date, galaxy_id)
VALUES
('Sun', 0.00, -26.74, '2024-01-01', 1),
('Proxima Centauri', 4.24, 11.05, '2024-01-02', 1),
('Betelgeuse', 642.5, 0.42, '2024-01-03', 1),
('Sirius', 8.6, -1.46, '2024-01-04', 2),
('Vega', 25.04, 0.03, '2024-01-05', 3),
('Rigel', 863, 0.13, '2024-01-06', 3);

-- Create planet table
CREATE TABLE planet(
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    orbital_period_in_years NUMERIC(7, 2) NOT NULL,
    rotation_period_in_days NUMERIC(5, 2),
    has_moon BOOLEAN NOT NULL,
    star_id INT NOT NULL REFERENCES star(star_id)
);

-- Insert data into planet table
INSERT INTO planet (name, orbital_period_in_years, rotation_period_in_days, has_moon, star_id)
VALUES
('Mercury', 0.24, 58.65, FALSE, 1),
('Venus', 0.62, 243.02, FALSE, 1),
('Earth', 1.00, 1.00, TRUE, 1),
('Mars', 1.88, 1.03, TRUE, 1),
('Jupiter', 11.86, 0.41, TRUE, 1),
('Saturn', 29.45, 0.44, TRUE, 1),
('Uranus', 84.02, 0.72, TRUE, 1),
('Neptune', 164.79, 0.67, TRUE, 1),
('PlanetX', 200.00, 10.00, FALSE, 2),
('Alpha', 1.50, 2.00, TRUE, 2),
('Beta', 2.50, 1.50, TRUE, 3),
('Gamma', 1.75, 1.25, FALSE, 3);

-- Create moon table
CREATE TABLE moon(
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    year_discovered INT,
    diameter_in_km INT,
    planet_id INT NOT NULL REFERENCES planet(planet_id)
);

-- Insert data into moon table
INSERT INTO moon (name, year_discovered, diameter_in_km, planet_id)
VALUES
('Moon', NULL, 3476, 3),
('Phobos', 1877, 23, 4),
('Deimos', 1877, 13, 4),
('Io', 1610, 3630, 5),
('Europa', 1610, 3138, 5),
('Ganymede', 1610, 5262, 5),
('Callisto', 1610, 4800, 5),
('Titan', 1655, 5150, 6),
('Rhea', 1672, 1530, 6),
('Iapetus', 1671, 1435, 6),
('Oberon', 1787, 1550, 7),
('Titania', 1787, 1610, 7),
('Triton', 1846, 2720, 8),
('Nereid', 1949, 340, 8),
('Vanth', 2005, NULL, 9),
('Charon', 1978, 1200, 10),
('Nix', 2005, 46, 10),
('Hydra', 2005, 61, 10),
('Kerberos', 2011, 28, 10),
('Styx', 2012, 20, 10),
('Atlas', 1980, 40, 6),
('Prometheus', 1980, 80, 6),
('Pandora', 1980, 100, 6),
('Pan', 1990, 20, 6),
('Janus', 1966, 190, 6),
('Epimetheus', 1966, 120, 6);

-- Create an additional table, for example, asteroid
CREATE TABLE asteroid(
    asteroid_id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    composition TEXT NOT NULL,
    is_potentially_hazardous BOOLEAN NOT NULL,
    discovery_year INT NOT NULL
);

-- Insert data into asteroid table
INSERT INTO asteroid (name, composition, is_potentially_hazardous, discovery_year)
VALUES
('Ceres', 'Rock and ice', FALSE, 1801),
('Pallas', 'Silicate and metal', TRUE, 1802),
('Vesta', 'Nickel-iron core', FALSE, 1807);

-- Ensure at least two columns per table are not NULL and add UNIQUE constraints
ALTER TABLE galaxy ADD UNIQUE (meaning);
ALTER TABLE star ADD UNIQUE (brightness_of_star);
ALTER TABLE planet ADD UNIQUE (orbital_period_in_years);
ALTER TABLE moon ADD UNIQUE (diameter_in_km);
ALTER TABLE asteroid ADD UNIQUE (composition);

-- Ensure at least one INT column in each table
ALTER TABLE star ADD COLUMN number_of_planets INT;
ALTER TABLE galaxy ADD COLUMN number_of_stars INT;
