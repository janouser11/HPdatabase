-- Harry Potter Database SQL Script
-- @Authors: Charles Harrill, Greg Eskridge and Alex Janousek



CREATE TABLE HP_SCHOOL
(
School_Name      VARCHAR(50),
Number_of_Houses INTEGER NOT NULL,
School_Region    VARCHAR(),
Constraint HP_SCHOOL_PK Primary Key (School_Name)
);


CREATE TABLE HP_CHARACTER
(
Character_Name      VARCHAR(50),
Level_Of_Impact     VARCHAR(50),
  Check(Level_Of_Impact IN('All Books', 'MostBooks', 'Less Than Half of Books', 'One Chapter', 'Referenced')),
Human CHAR(1),
Creature CHAR(1),
School_Name_Visited VARCHAR(50),
House_Name_Belongs  VARCHAR(50),
Constraint HP_CHARACTER_PK Primary Key (Character_Name)
);


CREATE TABLE HP_LANGUAGE
(
Language_Name  VARCHAR(50) NOT NULL,
Character_Name VARCHAR(50) NOT NULL,
Constraint HP_LANGUAGE_PK Primary Key (Language_Name, Character_Name)
);

CREATE TABLE HP_GROUP
(
Group_Name VARCHAR(50),
Purpose VARCHAR(50),
Ethical_Orientation VARCHAR(50),
Wizard_Name VARCHAR(50),
Constraint HP_GROUP Primary Key (Group_Name)

);

CREATE TABLE HP_GROUP_WIZARD_AFFILIATION
(
Group_Name VARCHAR(50),
Wizard_Name VARCHAR(50),
Constraint HP_GROUP_WIZARD_AFFILIATION Primary Key (Group_Name, Wizard_Name)
);

CREATE TABLE HP_POTION_RECIPE_ID
(
  -- Do we want string or numerical ID?
Potion_Recipe_Id VARCHAR(),
Potion_Name VARCHAR(50),
Ingredient_Name VARCHAR(50),
Constraint HP_POTION_RECIPE_ID Primary Key (Potion_Recipe_Id, Potion_Name, Ingredient_Name)
);

CREATE TABLE HP_POTION_INGREDIENT
(
Potion_Ingredient_Name VARCHAR(50),
Location_Found VARCHAR(50),
Constraint HP_POTION_INGREDIENT Primary Key (Potion_Ingredient_Name)
);
