-- Titles
CREATE TABLE Titles(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(124) NOT NULL,
    subtitle VARCHAR(124) NULL,
    description VARCHAR(255) NULL,
    tag_search VARCHAR(255) NULL,

    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP with TIME ZONE NULL
);

-- Authors
CREATE TABLE Authors(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(124) NOT NULL,
    birth_date TIMESTAMP with TIME ZONE NOT NULL,
    death_date TIMESTAMP with TIME ZONE NULL,
    origin VARCHAR(64) NOT NULL,
    background VARCHAR(255) NULL,
    description VARCHAR(255) NULL,
    
    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP with TIME ZONE NULL
);

-- Categories
CREATE TABLE Categories(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    
    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP with TIME ZONE NULL
);


-- Publisher
CREATE TABLE Publisher(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    federation_id VARCHAR(124) NOT NULL,
    country VARCHAR(64) NOT NULL,
    city VARCHAR(64) NOT null,
    
    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP with TIME ZONE NULL
);

-- Editions
CREATE TYPE edition_status as ENUM ('Active', 'Borrowed', 'Sold', 'Donated', 'Deleted');
CREATE TABLE Editions(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    publish_id INT NOT NULL,
    title_id INT NOT NULL,
    language VARCHAR(64) NOT NULL,
    translator VARCHAR(255) NULL,
    edition_year INT NOT NULL,
    edition_version VARCHAR(64) NOT NULL,
    isbn VARCHAR(14) NOT NULL UNIQUE,
    status edition_status NOT NULL DEFAULT 'Active',
 

    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP with TIME ZONE NULL,

    FOREIGN KEY (publish_id) REFERENCES Publisher (id),
    FOREIGN KEY (title_id) REFERENCES Titles (id)
);

-- Collections
CREATE TABLE Collections (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    publish_id INT NOT NULL,
    description VARCHAR(64) NOT null,
    tag_search varchar(255) NULL,
    
    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP with TIME ZONE NULL,

    FOREIGN KEY (publish_id) REFERENCES Publisher (id)
);



------------------ AUX TABLES -------------------------

-- AUX TABLE TITLE -> AUTHOR
CREATE TABLE TITLES_AUTHORS(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title_id INT NOT NULL,
    author_id INT NOT NULL,
    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),

    FOREIGN KEY (title_id) REFERENCES Titles (id),
    FOREIGN KEY (author_id) REFERENCES Authors (id)
);

-- AUX TABLE TITLE -> Category
CREATE TABLE TITLES_CATEGORIES(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title_id INT NOT NULL,
    category_id INT NOT NULL,
    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),
    
    FOREIGN KEY (title_id) REFERENCES Titles (id),
    FOREIGN KEY (category_id) REFERENCES Categories (id)
);

-- AUX TABLE TITLE -> Collections
CREATE TABLE TITLES_COLLECTIONS(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title_id INT NOT NULL,
    collection_id INT NOT NULL,

    created_at TIMESTAMP with TIME ZONE NOT NULL DEFAULT NOW(),
    
    FOREIGN KEY (title_id) REFERENCES Titles (id),
    FOREIGN KEY (collection_id) REFERENCES Collections (id)
);