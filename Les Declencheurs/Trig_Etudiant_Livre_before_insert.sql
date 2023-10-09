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

-- IF v_new_CNE = 0 THEN
-- SET msg_err = concat('Ce Etudiant est deja existe dans la Table Etudiant : ',v_new_CNE);
-- SIGNAL sqlstate '45000' set message_text = msg_err , mysql_errno=8000;
-- END IF;

IF v_new_CNE != "0" THEN
    -- IF v_new_Quantite-NEW.nbLivre < 0 THEN
    --   INSERT INTO Etudiant_Attent VALUES ("v_new_CNE" , "NEW.Nom" , "NEW.Prenom", "NEW.Ville",0,"NEW.titreEtu",NEW.nbLivre) ;
    -- END IF; 
      IF v_new_Quantite-NEW.nbLivre < 0 THEN
           UPDATE livre SET Quantite=v_new_Quantite WHERE NEW.titreEtu=titreLiv;
           INSERT INTO Etudiant_Attent VALUES (v_new_CNE , NEW.Nom , NEW.Prenom, NEW.Ville,0,NEW.titreEtu,NEW.nbLivre,now()) ;
         --   UPDATE Etudiant SET SCORE=0 WHERE NEW.CNE = CNE;      
        --   SET msg_err = concat('Le nombre de livre demander est superieur a la quantite ');
        --  SIGNAL sqlstate '45000' set message_text = msg_err , mysql_errno=8000;
      END IF;
  IF v_new_Quantite-NEW.nbLivre >= 0 THEN
    UPDATE Livre SET Quantite=Quantite-NEW.nbLivre WHERE NEW.titreEtu=titreLiv;
    INSERT INTO Emprunter VALUES (v_new_CNE,v_new_idLiv,v_dateDe,v_dateRe)  ;
  END IF;
END IF;
END;
$
DELIMITER ;



/* TESTER : */
INSERT INTO Etudiant VALUES ("N138930100","Boussoualef","Amine","CASA",1,"Le Petit Prince",3) ;
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
DROP TRIGGER Trig_Etudiant_Livre ;
DROP TRIGGER Trig_delete_Etudiant ;






DROP TRIGGER Trig_Etudiant_Livre_update ;

DELIMITER $
CREATE TRIGGER Trig_Etudiant_Livre_update AFTER UPDATE
ON Etudiant FOR EACH ROW
BEGIN
-- Les Variables :
DECLARE v_new_CNE VARCHAR(30) DEFAULT 0 ;
DECLARE msg_err VARCHAR(128);
DECLARE v_new_idLiv INT ;
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

-- IF v_new_CNE = 0 THEN
-- SET msg_err = concat('Ce Etudiant est deja existe dans la Table Etudiant : ',v_new_CNE);
-- SIGNAL sqlstate '45000' set message_text = msg_err , mysql_errno=8000;
-- END IF;

IF v_new_CNE != "0" THEN
      IF v_new_Quantite-NEW.nbLivre < 0 THEN
           UPDATE Etudiant SET SCORE=0 WHERE NEW.CNE = CNE;      
      END IF;
END IF;
END;
$
DELIMITER ;














