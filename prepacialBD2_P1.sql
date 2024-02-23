CREATE DATABASE IF NOT EXISTS Billetera; 
use billetera; 

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name_U VARCHAR(100),
    phone VARCHAR(15),
     balance DECIMAL(10, 2),
    password_U VARCHAR(100),
    salt VARCHAR(50),
    status_U VARCHAR(20),
    times TIMESTAMP
);

CREATE TABLE Contact (
	contac_id INT PRIMARY KEY,
	friend_id INT REFERENCES User_U(user_id),
    user_id INT REFERENCES User_U(user_id)
);

CREATE TABLE Transactions (
    request_id INT PRIMARY KEY,
    to_id INT,
    amount DECIMAL(10, 2),
    from_id INT ,
    reason VARCHAR(255),
    category VARCHAR(50),
    request_send VARCHAR(10),
    times TIMESTAMP,
    FOREIGN KEY (from_id) REFERENCES User_U(user_id),
    FOREIGN KEY (to_id) REFERENCES User_U(user_id)
);

CREATE TABLE users_detail (
    no_acount INT PRIMARY KEY,
     aadhar_doc VARCHAR(500),
    image BLOB, 
    user_id INT REFERENCES User_U(user_id),
	phone VARCHAR(50),
    doc_number VARCHAR(50),
    name_U VARCHAR(100),
    times TIMESTAMP
  
);

-- Registro 1
INSERT INTO Users (user_id, name_U, phone, balance, password_U, salt, status_U, times)
VALUES (1, 'Juan Pérez', '123456789', 1000.00, 'contraseña123', 'salt123', 'activo', CURRENT_TIMESTAMP);

-- Registro 2
INSERT INTO Users (user_id, name_U, phone, balance, password_U, salt, status_U, times)
VALUES (2, 'María López', '987654321', 2500.50, 'clave456', 'salt456', 'activo', CURRENT_TIMESTAMP);

-- Registro 3
INSERT INTO Users (user_id, name_U, phone, balance, password_U, salt, status_U, times)
VALUES (3, 'Carlos Ramírez', '555444333', 500.75, 'password789', 'salt789', 'inactivo', CURRENT_TIMESTAMP);

-- Registro 4
INSERT INTO Users (user_id, name_U, phone, balance, password_U, salt, status_U, times)
VALUES (4, 'Ana García', '777888999', 300.25, 'clave123', 'saltABC', 'activo', CURRENT_TIMESTAMP);

-- Registro 5
INSERT INTO Users (user_id, name_U, phone, balance, password_U, salt, status_U, times)
VALUES (5, 'Luisa Martínez', '111222333', 750.00, 'contraseña456', 'saltXYZ', 'activo', CURRENT_TIMESTAMP);

-- Registro 1
INSERT INTO Contact (contac_id, friend_id, user_id)
VALUES (1, 2, 1);

-- Registro 2
INSERT INTO Contact (contac_id, friend_id, user_id)
VALUES (2, 3, 1);

-- Registro 3
INSERT INTO Contact (contac_id, friend_id, user_id)
VALUES (3, 4, 2);

-- Registro 4
INSERT INTO Contact (contac_id, friend_id, user_id)
VALUES (4, 5, 3);

-- Registro 5
INSERT INTO Contact (contac_id, friend_id, user_id)
VALUES (5, 1, 4);

-- Registro 1
INSERT INTO Transactions (request_id, to_id, amount, from_id, reason, category, request_send, times)
VALUES (1, 2, 100.00, 1, 'Pago de deuda', 'Pago', 'enviado', CURRENT_TIMESTAMP);

-- Registro 2
INSERT INTO Transactions (request_id, to_id, amount, from_id, reason, category, request_send, times)
VALUES (2, 3, 50.25, 4, 'Compra en línea', 'Compra', 'enviado', CURRENT_TIMESTAMP);

-- Registro 3
INSERT INTO Transactions (request_id, to_id, amount, from_id, reason, category, request_send, times)
VALUES (3, 5, 200.50, 2, 'Transferencia familiar', 'Transferencia', 'enviado', CURRENT_TIMESTAMP);

-- Registro 4
INSERT INTO Transactions (request_id, to_id, amount, from_id, reason, category, request_send, times)
VALUES (4, 1, 300.75, 3, 'Pago de factura', 'Pago', 'enviado', CURRENT_TIMESTAMP);

-- Registro 5
INSERT INTO Transactions (request_id, to_id, amount, from_id, reason, category, request_send, times)
VALUES (5, 4, 75.20, 5, 'Gasto en entretenimiento', 'Gasto', 'enviado', CURRENT_TIMESTAMP);


-- Registro 1
INSERT INTO users_detail (no_acount, aadhar_doc, image, user_id, phone, doc_number, name_U, times)
VALUES (123456, 'documento1.pdf', 'imagen1', 1, '123456789', 'DOC123', 'Juan Pérez', CURRENT_TIMESTAMP);

-- Registro 2
INSERT INTO users_detail (no_acount, aadhar_doc, image, user_id, phone, doc_number, name_U, times)
VALUES (789012, 'documento2.pdf', 'imagen2', 2, '987654321', 'DOC456', 'María López', CURRENT_TIMESTAMP);

-- Registro 3
INSERT INTO users_detail (no_acount, aadhar_doc, image, user_id, phone, doc_number, name_U, times)
VALUES (345678, 'documento3.pdf', 'imagen3', 3, '555444333', 'DOC789', 'Carlos Ramírez', CURRENT_TIMESTAMP);

-- Registro 4
INSERT INTO users_detail (no_acount, aadhar_doc, image, user_id, phone, doc_number, name_U, times)
VALUES (901234, 'documento4.pdf', 'imagen4', 4, '777888999', 'DOCABC', 'Ana García', CURRENT_TIMESTAMP);

-- Registro 5
INSERT INTO users_detail (no_acount, aadhar_doc, image, user_id, phone, doc_number, name_U, times)
VALUES (567890, 'documento5.pdf', 'imagen5', 5, '111222333', 'DOCXYZ', 'Luisa Martínez', CURRENT_TIMESTAMP);
