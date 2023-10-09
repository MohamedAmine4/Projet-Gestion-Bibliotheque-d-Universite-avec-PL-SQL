DROP TRIGGER Trig_Etudiant_Livre ;

DELIMITER $
CREATE TRIGGER Trig_Etudiant_Livre AFTER INSERT
ON Etudiant FOR EACH ROW
BEGIN
-- Les Variables :
DECLARE v_new_CNE VARCHAR(30) DEFAULT 0 ;
DECLARE msg_err VARCHAR(128);
DECLARE v_new_idLiv INT ;
DECLARE v_new_Quantite INT ;
-- Stocker le CNE du nouveau Etudiant dans la variable v_new_CNE : 
SELECT CNE INTO v_new_CNE
FROM Etudiant WHERE NEW.CNE = CNE;
-- Stocker le idLivre du nouveau Etudiant dans la variable v_new_idLiv : 
SELECT idLivre INTO v_new_idLiv 
FROM Livre WHERE NEW.titreEtu = titreLiv ;
-- Stocker la Quantite du nouveau Etudiant dans la variable v_new_Quantite :  
SELECT Quantite INTO v_new_Quantite 
FROM Livre WHERE NEW.titreEtu = titreLiv ;
-- Les Conditions : 
IF v_new_CNE != "0" THEN
     IF v_new_Quantite-NEW.nbLivre < 0 THEN
     -- INSERT INTO Etudiant_Attent VALUES ("v_new_CNE" , "NEW.Nom" , "NEW.Prenom", "NEW.Ville",0,"NEW.titreEtu",NEW.nbLivre) ;
        INSERT INTO Etudiant_Attent VALUES ("A" , "B" , "C", "D",0,"E",34) ;
     END IF;
  UPDATE Livre SET Quantite=Quantite-NEW.nbLivre WHERE NEW.titreEtu=titreLiv;    
  INSERT INTO Emprunter VALUES (v_new_CNE,v_new_idLiv,"2020-10-20","2022-12-01")  ;
END IF;
END;
$
DELIMITER ;


/* TESTER : */
INSERT INTO Etudiant VALUES ("N138930100","Boussoualef","Amine","CASA",1,"Le Petit Prince",3) ;
INSERT INTO Etudiant VALUES ("N138930101","chahbi","Abdessamad","FES",1,"",2) ;