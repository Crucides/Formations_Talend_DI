-- Table postes
CREATE TABLE poste (
    id_poste SERIAL PRIMARY KEY,
    intitule VARCHAR(100) NOT NULL,
    niveau VARCHAR(50),
    salaire_base NUMERIC(10, 2) CHECK (salaire_base >= 0),
    date_create TIMESTAMP,
    date_modif TIMESTAMP
);


-- Table departement
CREATE TABLE departement (
    id_departement SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    localisation VARCHAR(200),
    id_responsable INTEGER,
    date_create TIMESTAMP,
    date_modif TIMESTAMP
);


-- Table employe
CREATE TABLE employe (
    id_employe SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_naissance INTEGER,
    numero_secu VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE,
    telephone VARCHAR(20),
    email_entreprise VARCHAR(255),
    id_departement INTEGER REFERENCES departement(id_departement) ON DELETE SET NULL,
    id_poste INTEGER REFERENCES postes(id_poste) ON DELETE SET NULL,
    date_create TIMESTAMP,
    date_modif TIMESTAMP
);


-- Ajout de la contrainte FK pour departement.responsable
ALTER TABLE departement
ADD CONSTRAINT fk_departement_responsable 
FOREIGN KEY (id_responsable) REFERENCES employe(id_employe) ON DELETE SET NULL;

-- Table contrat
CREATE TABLE contrat (
    id_contrat SERIAL PRIMARY KEY,
    id_employe INTEGER NOT NULL REFERENCES employe(id_employe) ON DELETE CASCADE,
    type_contrat VARCHAR(50) NOT NULL CHECK (type_contrat IN ('CDI', 'CDD', 'Stage', 'Alternance', 'Interim')),
    date_debut DATE NOT NULL,
    date_fin DATE,
    salaire NUMERIC(10, 2) NOT NULL CHECK (salaire > 0),
    statut VARCHAR(50),
    date_create TIMESTAMP,
    date_modif TIMESTAMP,
    CONSTRAINT chk_dates_contrat CHECK (date_fin IS NULL OR date_fin >= date_debut)
);