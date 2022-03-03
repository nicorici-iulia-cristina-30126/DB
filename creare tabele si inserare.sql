create database Proiect1

create table Clienti
(
	id_client int NOT NULL primary key,
	nume_client varchar(50) NOT NULL,
	prenume_clienti varchar(50) NOT NULL,
	cnp_client varchar(50) NOT NULL,
	adresa_client varchar(50) NOT NULL,
	telefon_client varchar(50) NOT NULL,
	datorii_client integer null
)

create table Comenzi
(
	id_comanda int NOT NULL primary key,
	data_comanda date NOT NULL,
	stare_comanda varchar(50) NOT NULL,
	modplata_comanda varchar(50) NOT NULL,
	id_client int REFERENCES clienti(id_client)
)

CREATE TABLE Furnizori
(
	Id_furnizor int NOT NULL PRIMARY KEY,
	nume_furnizor varchar(100) NOT NULL,
	adresa_furnizor varchar(100) NOT NULL,
	datorie_catre_furnizor int
)
CREATE TABLE Produse
(
	id_produs int NOT NULL PRIMARY KEY,
	descriere_produs varchar(100) NOT NULL,
	pret_produs int NOT NULL,
	tva_produs int NULL,
	Id_furnizori int REFERENCES Furnizori(id_furnizor)
)
CREATE TABLE Comenzi_produse
(
	id_comanda int NOT NULL,
	pret_comanda int NOT NULL,
	id_produs int NOT NULL,
	CONSTRAINT Fk_produse FOREIGN KEY(id_produs)
	REFERENCES Produse(id_produs),
	CONSTRAINT Fk_comenzi FOREIGN KEY(id_comanda)
	REFERENCES Comenzi(id_comanda)
)

Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(1,'Cord', 'Targoviste', 200);
Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(2,'Astoria', 'Gaesti', 0);
Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(3,'Manoil', 'Targoviste', 0);
Insert into FURNIZORI(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(4,'Central', 'Targoviste', 0);
Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(5,'Elit', 'Targoviste', 120);
Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(6,'Grandi', 'Targoviste', 80);
Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(7,'Orbit', 'Targoviste', 0);
Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(8,'2Smart', 'Targoviste', 0);
Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(9,'Giusto', 'Targoviste', 0);
Insert into Furnizori(Id_furnizor , nume_furnizor, adresa_furnizor, datorie_catre_furnizor)
values(10,'Velpitar', 'Targoviste', 20);

Insert into Clienti (id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(1,'Popescu','Andreea','pandreea','str.Mihai Eminescu,nr.2,bl 22,sc.C,ap.5',0742317745,0);
Insert into Clienti(id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(2,'Ionescu','Maria','imaria','str.Lalelelor,nr.7,bl.7,ap.41',0751236743,100);
Insert into Clienti (id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(3,'Pop','Cosmin','pcosmin','str.Victoriei,nr3,bl.A3,ap.21',0761234543,200);
Insert into Clienti (id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(4,'Ivan','Oana','ioana','str.Pacii,nr.4',0251123456,0);
Insert into Clienti (id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(5,'Popescu','Dragos','pdragos','str.Datinei,bl.B21,ap.30',0732143564,100);
Insert into Clienti (id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(6,'Negoi','Mihaela','nmihaela','str.Principala,nr.7,bl.7,ap.41',0727114404,20);
Insert into Clienti (id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(7,'Negoi','Danut','dnegoi','str. Constantinescu,nr3,bl.A3,ap.21',0731278369,0);
Insert into Clienti(id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(8,'Popescu','Adelina','a.popescu','str.Jupiter,nr.4',0251123456,0);
Insert into Clienti (id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(9,'Sandu','Mihaela','s.mihaela','str.Oletnitei,bl.B21,ap.30',0732143564,0);
Insert into Clienti(id_client , nume_client ,prenume_clienti ,cnp_client,adresa_client,telefon_client,datorii_client    )
values(10,'Vasile','Maria','mvasile','str.Oltenitei,bl.B21,ap.30',0732143564,0);

Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (1, GetDate(), 'livrat', 'cash',1);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (2, GetDate(), 'nelivrat', 'N\A',5);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (3, GetDate(), 'necunoscut', 'cash',4);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (4, GetDate(), 'refuzat', 'N\A',3);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (5, GetDate(), 'livrat', 'cash',2);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (6, GetDate(), 'livrat', 'cash',6);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (7, GetDate(), 'livrat', 'cash',8);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (8, GetDate(), 'livrat', 'cash',7);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (9, GetDate(), 'livrat', 'cash',9);
Insert into Comenzi(id_comanda,data_comanda, stare_comanda, modplata_comanda,id_client) values (10, GetDate(), 'livrat', 'cash',10);


insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (1, 'paine', 1, 0.09, 10);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (2, 'suc', 5, 0.09, 9);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (3, 'prajitura', 1, 0.09, 8);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (4, 'guma', 2.5, 0.09, 7);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (5, 'carnati', 22, 0.09, 6);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (6, 'salam', 20, 0.09, 5);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (7, 'tigari', 18, 0.19, 4);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (8, 'bere', 3, 0.19, 3);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (9, 'corn', 2, 0.09, 2);
insert into Produse(id_produs, descriere_produs, pret_produs, tva_produs, Id_furnizori) values (10, 'biscuiti', 14, 0.09, 1);

insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (1,10,1);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (2,16,4);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (3,24,1);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (4,1167,4);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (5,156,5);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (6,27,2);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (7,14,9);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (8,582,10);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (9,105,1);
insert into Comenzi_produse( id_comanda, pret_comanda, id_produs) values (10,100,3);