create table Emprunter (
   CNE VARCHAR(12) ,
   idLivre INT ,   
   dateDebut DATE ,
   dateRetour DATE ,
    CONSTRAINT pk_cne_idlivre PRIMARY KEY (CNE,idLivre) ,
   CONSTRAINT fk_CNE FOREIGN KEY (CNE) REFERENCES Etudiant(CNE) , 
   CONSTRAINT fk_idLivre FOREIGN KEY (idLivre) REFERENCES Livre(idLivre) 
)ENGINE=INNODB ;