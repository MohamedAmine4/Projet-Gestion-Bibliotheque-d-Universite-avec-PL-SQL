create table Etudiant_warning (
   CNE VARCHAR(12) PRIMARY KEY  ,
   Nom VARCHAR(30) ,
   Prenom VARCHAR(30) ,
   Ville VARCHAR(25) ,
   warning INT DEFAULT 0 
)ENGINE=INNODB ;