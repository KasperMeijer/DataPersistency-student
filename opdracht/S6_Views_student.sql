-- ------------------------------------------------------------------------
-- Data & Persistency
-- Opdracht S6: Views
--
-- (c) 2020 Hogeschool Utrecht
-- Tijmen Muller (tijmen.muller@hu.nl)
-- André Donk (andre.donk@hu.nl)
-- ------------------------------------------------------------------------


-- S6.1.
--
-- 1. Maak een view met de naam "deelnemers" waarmee je de volgende gegevens uit de tabellen inschrijvingen en uitvoering combineert:
--    inschrijvingen.cursist, inschrijvingen.cursus, inschrijvingen.begindatum, uitvoeringen.docent, uitvoeringen.locatie
create or replace view deelnemers as
select
    i.cursist,
    i.cursus,
    i.begindatum,
    u.docent,
    u.locatie
from inschrijvingen i
         join uitvoeringen u on i.cursus = u.cursus and i.begindatum = u.begindatum;

-- https://i.imgur.com/ei4KPM8.png

-- 2. Gebruik de view in een query waarbij je de "deelnemers" view combineert met de "personeels" view (behandeld in de les):
--     CREATE OR REPLACE VIEW personeel AS
-- 	     SELECT mnr, voorl, naam as medewerker, afd, functie
--       FROM medewerkers;

create or replace view deelnemers_personeel as
select distinct * from personeel
       join deelnemers on deelnemers.cursist = personeel.mnr

-- https://i.imgur.com/579LaN5.png

-- 3. Is de view "deelnemers" updatable ? Waarom ?
-- Nee, de view komt uit twee tabellen, kunt alleen aanpassen als de data uit 1 tabel komt


-- S6.2.
--
-- 1. Maak een view met de naam "dagcursussen". Deze view dient de gegevens op te halen: 
--      code, omschrijving en type uit de tabel curssussen met als voorwaarde dat de lengte = 1. Toon aan dat de view werkt. 
create or replace view dagcursussen as
select code, omschrijving, type from cursussen
where lengte = 1

-- https://i.imgur.com/DLuoyef.png

-- 2. Maak een tweede view met de naam "daguitvoeringen".
--    Deze view dient de uitvoeringsgegevens op te halen voor de "dagcurssussen" (gebruik ook de view "dagcursussen"). Toon aan dat de view werkt
create or replace view daguitvoeringen as
select * from uitvoeringen
where cursus in (select code from dagcursussen)

-- https://i.imgur.com/hu1xliK.png

-- 3. Verwijder de views en laat zien wat de verschillen zijn bij DROP view <viewnaam> CASCADE en bij DROP view <viewnaam> RESTRICT
-- Bij CASCADE worden alle views die afhankelijk zijn van de view die je wilt verwijderen ook verwijderd
-- Bij RESTRICT wordt de view niet verwijderd als er nog views zijn die afhankelijk zijn van de view die je wilt verwijderen