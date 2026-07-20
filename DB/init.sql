USE socrud;

CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    address VARCHAR(100)
);

-- Insertar datos
INSERT INTO members (firstname, lastname, address) VALUES
('Airi', 'Satou', 'Tokyo'),
('Angelica', 'Ramos', 'London'),
('Ashton', 'Cox', 'San Francisco');
