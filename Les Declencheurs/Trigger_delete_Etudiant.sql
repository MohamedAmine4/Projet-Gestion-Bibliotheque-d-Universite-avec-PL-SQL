DROP TRIGGER Trig_delete_Etudiant ;

DELIMITER $
CREATE TRIGGER Trig_delete_Etudiant before DELETE
ON Etudiant FOR EACH ROW
BEGIN
-- Les Variables :
DECLARE v_new_CNE VARCHAR(30) DEFAULT 0 ;
DECLARE v_new_CNE_warning VARCHAR(30) DEFAULT 0 ;
DECLARE msg_err VARCHAR(128);
DECLARE v_new_idLiv INT ;
DECLARE v_new_Quantite INT ;
-- Les Dates :
DECLARE v_dateDe DATE ;
DECLARE v_dateRe DATE ;
SELECT DATE_FORMAT(now(), "%Y-%m-%d") INTO v_dateDe ;
SELECT date_add(now(), interval 30 day) INTO v_dateRe ;
SELECT dateRetour INTO v_dateRe FROM Emprunter WHERE old.CNE=CNE ;

-- Stocker le CNE du nouveau Etudiant dans la variable v_new_CNE : 
SELECT CNE INTO v_new_CNE
FROM Etudiant WHERE old.CNE = CNE ;
-- Stocker le CNE du L'Etudiant Warning dans la variable v_new_CNE_warning : 
SELECT CNE INTO v_new_CNE_warning 
FROM Etudiant_Warning WHERE old.CNE = CNE ;
-- Stocker le idLivre du nouveau Etudiant dans la variable v_new_idLiv : 
SELECT idLivre INTO v_new_idLiv 
FROM Livre WHERE old.titreEtu = titreLiv ;
-- Stocker la Quantite du nouveau Etudiant dans la variable v_new_Quantite :  
SELECT Quantite INTO v_new_Quantite 
FROM Livre WHERE old.titreEtu = titreLiv ;

-- Les Conditions : 
IF v_new_CNE != "0" THEN
        UPDATE livre SET Quantite=v_new_Quantite + old.nbLivre  WHERE old.titreEtu=titreLiv;
        DELETE FROM Emprunter WHERE old.CNE=CNE ; 
-- IF DATEDIFF(now(),v_dateRe) < 0 THEN 
   IF DATEDIFF("2010-01-01","2010-01-05") < 0 THEN  
       IF v_new_CNE_waRNING = "0" THEN
          INSERT INTO Etudiant_warning VALUES (v_new_CNE , old.Nom , old.Prenom, old.Ville,-1) ;
       END IF;
        IF v_new_CNE_waRNING != "0" THEN
          UPDATE Etudiant_Warning SET warning=warning-1 WHERE old.CNE=CNE ;
        END IF;
    END IF;
END IF;
END;
$
DELIMITER ;


/* TESTER : */
INSERT INTO Etudiant VALUES ("N138930101","Chahbi","Abdessamad","CASA",0,"Le Petit Prince",980) ;
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
