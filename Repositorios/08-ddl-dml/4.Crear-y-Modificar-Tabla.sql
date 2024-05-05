# crear tablas
DROP TABLE IF EXISTS rol;
CREATE TABLE rol (
  id int NOT NULL AUTO_INCREMENT,
  rol varchar(100) NOT NULL,
  PRIMARY KEY (id)
) 

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  id int NOT NULL AUTO_INCREMENT,
  nombre varchar(45) NOT NULL,
  apellido varchar(45) NOT NULL,
  email varchar(45) NOT NULL,
  PRIMARY KEY (id)
)

DROP TABLE IF EXISTS carrera;
CREATE TABLE carrera (
  id int NOT NULL AUTO_INCREMENT,
  titulo varchar(45) NOT NULL,
  descripcion varchar(100) NOT NULL,
  rol_id int NOT NULL,
  
  PRIMARY KEY (id,rol_id),
  KEY fk_carrera_rol_idx (rol_id),
  CONSTRAINT fk_carrera_rol FOREIGN KEY (rol_id) REFERENCES rol (id)
);


