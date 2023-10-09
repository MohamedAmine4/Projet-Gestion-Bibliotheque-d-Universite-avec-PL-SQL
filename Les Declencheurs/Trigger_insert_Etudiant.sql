DROP TRIGGER Trig_insert_Etudiant ;

DELIMITER $
CREATE TRIGGER Trig_insert_Etudiant AFTER INSERT
ON Etudiant FOR EACH ROW
BEGIN
-- Les Variables :
DECLARE v_new_CNE VARCHAR(30) DEFAULT 0 ;
DECLARE msg_err VARCHAR(128);
DECLARE v_new_idLiv INT DEFAULT 0 ;
DECLARE v_new_Quantite INT ;
-- Les Dates :
DECLARE v_dateDe DATE ;
DECLARE v_dateRe DATE ;
SELECT DATE_FORMAT(now(), "%Y-%m-%d") INTO v_dateDe ;
SELECT date_add(now(), interval 30 day) INTO v_dateRe ;

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
           UPDATE livre SET Quantite=v_new_Quantite WHERE NEW.titreEtu=titreLiv;
           INSERT INTO Etudiant_Attent VALUES (v_new_CNE , NEW.Nom , NEW.Prenom, NEW.Ville,0,NEW.titreEtu,NEW.nbLivre,now()) ;
      END IF;
   IF v_new_Quantite-NEW.nbLivre >= 0 THEN
      UPDATE Livre SET Quantite=Quantite-NEW.nbLivre WHERE NEW.titreEtu=titreLiv;
      INSERT INTO Emprunter VALUES (v_new_CNE,v_new_idLiv,v_dateDe,v_dateRe)  ;
   END IF;
 IF v_new_idLiv = 0 THEN
      SET msg_err = concat("Le Titre de ce Livre n'existe pas dans la Bibliotheque ");
      SIGNAL sqlstate '45000' set message_text = msg_err , mysql_errno=8000;
 END IF;
END IF;
END;
$
DELIMITER ;


/* TESTER : */
INSERT INTO Etudiant VALUES ("N138930100","Boussoualef","Amine","CASA",1,"Le Petit Prince",3) ;
INSERT INTO Etudiant VALUES ("N138930102","chahbi","Abdessamad","FES",0,"Le Petit Prince",9000) ;
INSERT INTO Etudiant VALUES ("N138930101","chahbi","Abdessamad","FES",1,"",2) ;
DELETE FROM Etudiant WHERE CNE="N138930100" ;

SELECT * from Etudiant ;
SELECT * from Emprunter ;
SELECT * from Etudiant_Attent ;
SELECT * from Etudiant_Warning ;
SELECT * from livre ;

delete from Emprunter ;
delete from Etudiant ;
delete from Etudiant_Attent ;
delete from Etudiant_Warning ;

/*Les declencheurs : */
DROP TRIGGER Trig_insert_Etudiant ;
DROP TRIGGER Trig_delete_Etudiant ;
