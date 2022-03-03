SELECT * FROM Clienti
SELECT * FROM Comenzi
SELECT * FROM Furnizori
SELECT * FROM Produse_Vanzare
SELECT * FROM Comenzi_produse


--creez coloana Sex
ALTER TABLE Clienti ADD Sex varchar(1);


--modific varchar
ALTER TABLE Clienti ALTER COLUMN nume_client VARCHAR(100);


--sterg coloana Sex
ALTER TABLE Clienti  DROP COLUMN Sex;


--schimb numele tabelului Produse
EXEC sp_rename 'Produse', 'Produse_Vanzare';


--Schimb numele clientilor care au id=2
UPDATE Clienti SET nume_client='IONESCU' WHERE ID_CLIENT=2;
SELECT nume_client FROM Clienti WHERE id_client=2;


--Schimb prenumele clientilor care au numele Negoi
UPDATE Clienti SET prenume_clienti='GEORGE' WHERE nume_client='Negoi';


--Schimb datele comenzilor
update Comenzi
Set data_comanda='2020-12-15'
where id_comanda=2;
update Comenzi
Set data_comanda='2020-12-15'
where id_comanda=3
update Comenzi
Set data_comanda='2020-12-04'
where id_comanda=1
update Comenzi
Set data_comanda='2020-12-04'
where id_comanda=8
update Comenzi
Set data_comanda='2020-12-04'
where id_comanda=5
update Comenzi
Set data_comanda='2018-10-15'
where id_comanda=9
update Comenzi
Set data_comanda='2020-5-9'
where id_comanda=10


--Sterg furnizori care au id intre 11 si 14
DELETE FROM Furnizori
WHERE Id_furnizor IN( SELECT Id_furnizor FROM Furnizori WHERE Id_furnizor BETWEEN 11 AND 14);


--afisez Satrea comenzii, data comenzii, numele clientului si datoriile clientului in functie de id
SELECT stare_comanda, data_comanda, nume_client, datorii_client
FROM Comenzi C, Clienti CL
WHERE C.Id_client=CL.id_client;


--afisez datele din tabela furnizor si pe cele comune din tabela produse_vanzare
SELECT * FROM  Furnizori F
LEFT OUTER JOIN Produse_Vanzare P ON F.Id_furnizor=P.Id_furnizori;


--afisez pretul maxim din tabela Produse_Vanzare
SELECT MAX(pret_produs)PRET_MAXIM FROM Produse_Vanzare;


--Schimb pretul biscuitilor din tabelul Produse_Vanzare cu cel mai mic pret din tabelul Produse_Vanzare
UPDATE Produse_Vanzare
SET pret_produs=(SELECT MIN(pret_produs) FROM Produse_Vanzare)
WHERE descriere_produs='biscuiti'


--Afisez tipul prduselor in functie de pret
SELECT pret_produs, CASE WHEN pret_produs < 5 THEN 'Produse ieftine'
					     WHEN pret_produs between 5 and 17 THEN 'Produse accesibile'
						 WHEN pret_produs > 17 THEN 'Produse scumple'
				    END tip_produs
FROM Produse_Vanzare


--afisez date despre paine si suc
SELECT Id_produs, tva_produs, Id_furnizori
FROM Produse_Vanzare
WHERE descriere_produs='paine'
UNION
SELECT Pret_produs, tva_produs, Id_furnizori
FROM Produse_Vanzare
WHERE descriere_produs='suc';


--afisez cate comenzi s-au livrat, cate nu sau livrat, cate sunt refuzate si cate sunt necunoscute
SELECT stare_comanda, COUNT(*) FROM Comenzi GROUP BY stare_comanda


--afisez numele clientiilor si de cate ori se repeta numele
SELECT nume_client, COUNT(*) FROM Clienti GROUP BY nume_client


--Functie care afiseaza comenziile pentru un id_produs specific
CREATE FUNCTION ComenziInFunctieIdProduse(@id int)
RETURNS TABLE
AS
RETURN(SELECT id_comanda, pret_comanda
		FROM Comenzi_produse inner join Produse_Vanzare ON Comenzi_produse.id_produs=Produse_Vanzare.id_produs
		WHERE Produse_Vanzare.id_produs=@id)

SELECT * FROM ComenziInFunctieIdProduse(1)

DROP FUNCTION ComenziInFunctieIdProduse


--Functie care sa afiseze produsele in functie de pretul ales
CREATE FUNCTION ProduseInFunctieDePret(@p int)
RETURNS TABLE
AS
RETURN(SELECT id_produs, descriere_produs FROM Produse_Vanzare
		WHERE pret_produs=@p)

SELECT * FROM ProduseInFunctieDePret(1)

DROP FUNCTION ProduseInFunctieDePret


--functie care sa fiseze numarul de telefon al unui client in functie de cnp
CREATE FUNCTION CautaNrTelefonDupaCNP(@cnp varchar(100))
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @p VARCHAR(100), @tc VARCHAR(50) = (SELECT telefon_client FROM Clienti WHERE cnp_client = @cnp);
IF exists (SELECT * FROM Clienti WHERE cnp_client = @cnp)
	BEGIN
		SET @p = 'Clientul are numarul de telefon: ' + @tc;
	END
ELSE
	BEGIN
		SET @p = 'Nu exista clientul cu CNP-ul: ' + @cnp;
	END
RETURN @p
END

SELECT dbo.[CautaNrTelefonDupaCNP]('a.popescu')
SELECT dbo.[CautaNrTelefonDupaCNP]('c.ioana')

DROP FUNCTION CautaNrTelefonDupaCNP


--Trigger pt a adauga furnizori noi in tabelul Furnizori_noi
SELECT * INTO Furnizori_noi FROM Furnizori
SELECT * FROM Furnizori_noi

CREATE TRIGGER Trigger1 ON Furnizori_noi FOR INSERT
AS
DECLARE @ID_F INT, @NF VARCHAR(100), @AF VARCHAR(100), @DCF INT
SELECT @ID_F = Id_furnizor, @NF = nume_furnizor, @AF = adresa_furnizor, @DCF = datorie_catre_furnizor
FROM Furnizori_noi
PRINT 'Se insereaza furnizorul cu numele ' + @NF +' si cu adresa: ' + @AF

INSERT into Furnizori_noi(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor) values(11,'Dorna', 'Cluj-Napoca', 154);
INSERT into Furnizori_noi(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor) values(12,'Milka', 'Alba-Iulia', 900);

DROP TRIGGER Trigger1


--Trigger pt a adauga clienti noi in tabelul Clienti_noi care nu au datorii mai mari de 200 de lei 
SELECT * INTO Clienti_noi FROM Clienti
SELECT * FROM Clienti_noi

CREATE TRIGGER Trigger2 ON Clienti_noi FOR INSERT
AS
DECLARE @IC INT, @NC VARCHAR(100), @PN VARCHAR(100), @CNP VARCHAR(100), @ADR VARCHAR(100), @TC VARCHAR(100), @DC INT
SELECT @IC = id_client, @NC = nume_client, @PN = prenume_clienti, @CNP = cnp_client, @ADR = adresa_client, @TC = telefon_client, @DC = datorii_client
FROM Clienti_noi
IF @DC > 200
	BEGIN
		PRINT 'Nu acceptam Clienti cu datorii mai mari de 100 de lei!!';
		ROLLBACK;
	END
ELSE
	BEGIN
		PRINT 'Clientul a fost intrdus'
	END

Insert Clienti_noi (id_client, nume_client ,prenume_clienti, cnp_client,adresa_client,telefon_client,datorii_client)values(13,'Braba','Vicentiu','bvicentiu','str.Cosbuc,nr.109,bl 11,sc.A,ap.1',0743982132,200);
Insert Clienti_noi (id_client, nume_client ,prenume_clienti, cnp_client,adresa_client,telefon_client,datorii_client)values(14,'Sigarteu','Virgil','svirgil','str.Iris,nr.7',0712321894,30);
Insert Clienti_noi (id_client, nume_client ,prenume_clienti, cnp_client,adresa_client,telefon_client,datorii_client)values(14,'Neamt','Laura','nlaura','str.Andrei Saguna,nr.1',0753421762,900);

DROP TRIGGER Trigger2


--cursor care afisaza numele produselor si pretul acestora:
DECLARE CursorProduse CURSOR
fOR SELECT descriere_produs, pret_produs
FROM Produse_Vanzare
DECLARE @DescriereP varchar(50), @PretP varchar(50)
OPEN CursorProduse
fetch NEXT FROM CursorProduse INTO @DescriereP, @PretP
WHILE @@FETCH_STATUS=0
BEGIN
	PRINT @DescriereP + ' -> ' + @PretP + ' lei'
	FETCH NEXT FROM CursorProduse INTO @DescriereP, @PretP
END

CLOSE CursorProduse
DEALLOCATE CursorProduse


--procedura care arata la cine a fost livrata comanda
CREATE PROCEDURE PoceduraComandaLivrata
AS
DECLARE @IdC INT, @DataC date, @StareC VARCHAR(50), @ModC VARCHAR(50)
DECLARE CursorC CURSOR FOR SELECT id_client, data_comanda, stare_comanda, modplata_comanda FROM Comenzi WHERE stare_comanda = 'livrat'
OPEN CursorC
FETCH NEXT FROM CursorC INTO @IdC, @DataC, @StareC, @ModC
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT 'Comanda din data de: ' + convert(VARCHAR(50),@DataC) + ' a fost livrata clientului cu Id-ul: ' + convert(VARCHAR(50), @IdC) + ' cu metoda de plata: '+ @ModC
	FETCH NEXT FROM CursorC INTO @IdC,  @DataC, @StareC, @ModC
END
CLOSE CursorC
DEALLOCATE CursorC

EXEC PoceduraComandaLivrata
DROP PROCEDURE PoceduraComandaLivrata


--view unde sunt mai multi furnizori
CREATE VIEW FURNIZ AS(SELECT Id_furnizor, COUNT(nume_furnizor) AS CNT FROM Furnizori
GROUP BY Id_furnizor
HAVING COUNT(nume_furnizor)<2);

SELECT * FROM FURNIZ


