#Harry Potter Database SQL Script



CREATE TABLE HP_SCHOOL (

School_Name      VARCHAR(50),
Number_of_Houses INTEGER NOT NULL,
School_Region    VARCHAR(),
  Constraint HP_SCHOOL_PK Primary Key (School_Name)

);


CREATE TABLE HP_CHARACTER (
Character_Name VARCHAR(50),
Level_Of_Impact VARCHAR(50),
  Check(Level_Of_Impact IN('All Books', 'MostBooks', 'Less Than Half of Books', 'One Chapter', 'Referenced')),
Human CHAR(1),
Creature CHAR(1),
School_Name_Visited VARCHAR(50),
House_Name_Belongs VARCHAR(50),
Constraint HP_CHARACTER_PK Primary Key (Character_Name));


CREATE TABLE HP_LANGUAGE
(Language_Name VARCHAR(50) NOT NULL,
Character_Name VARCHAR(50) NOT NULL,
Constraint HP_LANGUAGE_PK Primary Key (Language_Name, Character_Name)
);
