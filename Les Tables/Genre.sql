create table Genre (
   idGenre INT PRIMARY KEY  ,
   nomGenre VARCHAR(30) ,
   idLivre INT ,
   CONSTRAINT fk_idLiivre FOREIGN KEY (idLivre) REFERENCES Livre(idLivre)
)ENGINE=INNODB ;