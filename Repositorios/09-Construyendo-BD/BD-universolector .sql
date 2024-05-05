DROP DATABASE IF EXISTS universolector;
CREATE DATABASE universolector;
USE universolector;

CREATE TABLE autor(
	codigo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE editorial (
	codigo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    razon_social VARCHAR(200) NOT NULL,
    telefono VARCHAR(100) NOT NULL
);

CREATE TABLE socio (
	codigo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    dni INT NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    localidad VARCHAR(100)
);

CREATE TABLE prestamo (
	codigo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	fecha DATETIME NOT NULL,
    fecha_devolucion DATE NOT NULL,
    fecha_tope DATE NOT NULL,
    codigo_socio INT NOT NULL,
    FOREIGN KEY (codigo_socio) REFERENCES Socio(codigo)
);

CREATE TABLE libro (
	codigo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    anio_escritura DATE NOT NULL,
    anio_edicion DATE NOT NULL,
    codigo_autor INT NOT NULL,
    codigo_editorial INT NOT NULL,
    FOREIGN KEY (codigo_autor) REFERENCES autor(codigo),
    FOREIGN KEY (codigo_editorial) REFERENCES editorial(codigo)
);
CREATE TABLE volumen (
	codigo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    deteriorado BOOL NOT NULL,
    codigo_libro INT NOT NULL,
    FOREIGN KEY (codigo_libro) REFERENCES Libro(codigo)
);

CREATE TABLE prestamo_x_volumen (
	codigo INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    codigo_prestamo INT NOT NULL,
    codigo_volumen INT NOT NULL,
    FOREIGN KEY (codigo_prestamo) REFERENCES Prestamo(codigo),
    FOREIGN KEY (codigo_volumen) REFERENCES Volumen(codigo)
)



