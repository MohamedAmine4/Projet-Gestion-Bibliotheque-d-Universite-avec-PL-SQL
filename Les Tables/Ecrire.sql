create table Ecrire (
     idLivre INT ,
     idAuteur INT ,
   CONSTRAINT fk_idLivrre FOREIGN KEY (idLivre) REFERENCES Livre(idLivre) ,
   CONSTRAINT fk_idAuteur FOREIGN KEY (idAuteur) REFERENCES Auteur(idAuteur) ,
   CONSTRAINT pk_idlivre_idauteur PRIMARY KEY (idLivre,idAuteur)
)ENGINE=INNODB ;