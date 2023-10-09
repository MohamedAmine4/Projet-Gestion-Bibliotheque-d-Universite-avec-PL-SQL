/*Table Etudiant : */
create table Etudiant (
   CNE VARCHAR(12) PRIMARY KEY  ,
   Nom VARCHAR(30) ,
   Prenom VARCHAR(30) ,
   Ville VARCHAR(25) ,
   score INT DEFAULT 0 ,
   titreEtu VARCHAR(30) 
)ENGINE=INNODB ;

/*Table Livre : */
create table Livre (
   idLivre INT PRIMARY KEY  ,
   idGenre INT ,
   dateCreation DATE ,
   titreLiv VARCHAR(30) ,
   nombrePage INT(25) ,
   Quantite INT(30) ,
 CONSTRAINT fk_idGenre FOREIGN KEY (idGenre) REFERENCES Genre(idGenre)   
)ENGINE=INNODB ;

/*Table Emprunter : */
create table Emprunter (
   CNE VARCHAR(12) ,
   idLivre INT ,   
   dateDebut DATE ,
   dateRetour DATE ,
    CONSTRAINT pk_cne_idlivre PRIMARY KEY (CNE,idLivre) ,
   CONSTRAINT fk_CNE FOREIGN KEY (CNE) REFERENCES Etudiant(CNE) , 
   CONSTRAINT fk_idLivre FOREIGN KEY (idLivre) REFERENCES Livre(idLivre) 
)ENGINE=INNODB ;

/*Table Auteur : */
create table Auteur (
   idAuteur INT PRIMARY KEY  ,
   Nom VARCHAR(30) ,
   Prenom VARCHAR(30) ,
   dateNaissance DATE 
)ENGINE=INNODB ;

/*Table Ecrire : */
create table Ecrire (
     idLivre INT ,
     idAuteur INT ,
   CONSTRAINT fk_idLivrre FOREIGN KEY (idLivre) REFERENCES Livre(idLivre) ,
   CONSTRAINT fk_idAuteur FOREIGN KEY (idAuteur) REFERENCES Auteur(idAuteur) ,
   CONSTRAINT pk_idlivre_idauteur PRIMARY KEY (idLivre,idAuteur)
)ENGINE=INNODB ;

/*Table Genre : */
create table Genre (
   idGenre INT PRIMARY KEY  ,
   nomGenre VARCHAR(30) 
)ENGINE=INNODB ;

/*Table Etudiant_Attent : */
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

/*Table Etudiant_Warning : */
create table Etudiant_Warning (
   CNE VARCHAR(12) PRIMARY KEY  ,
   Nom VARCHAR(30) ,
   Prenom VARCHAR(30) ,
   Ville VARCHAR(25) ,
   warning INT DEFAULT 0 
)ENGINE=INNODB ;

