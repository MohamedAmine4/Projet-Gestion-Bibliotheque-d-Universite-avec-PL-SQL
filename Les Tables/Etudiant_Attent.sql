create table Etudiant_Attent (
   CNE VARCHAR(12) PRIMARY KEY  ,
   Nom VARCHAR(30) ,
   Prenom VARCHAR(30) ,
   Ville VARCHAR(25) ,
   score INT DEFAULT 0 ,
   titreEtu VARCHAR(30) ,
   nbLivre INT ,
   dateReservation DATE 
)ENGINE=INNODB ;