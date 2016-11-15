DROP TABLE HP_SCHOOL CASCADE CONSTRAINTS;
DROP TABLE HP_HOUSE CASCADE CONSTRAINTS;
DROP TABLE HP_HOUSE_CHARACTERISTIC CASCADE CONSTRAINTS;
DROP TABLE HP_CHARACTER CASCADE CONSTRAINTS;
DROP TABLE HP_LANGUAGE CASCADE CONSTRAINTS;
DROP TABLE HP_BOOK_APPEARED_IN CASCADE CONSTRAINTS;
DROP TABLE HP_MOVIE_APPEARED_IN CASCADE CONSTRAINTS;
DROP TABLE HP_CHARACTER_PARENT CASCADE CONSTRAINTS;
DROP TABLE HP_HUMAN CASCADE CONSTRAINTS;
DROP TABLE HP_MUGGLE CASCADE CONSTRAINTS;
DROP TABLE HP_WIZARD CASCADE CONSTRAINTS;
DROP TABLE HP_WIZARD_PROTECTS_MUGGLE CASCADE CONSTRAINTS;
DROP TABLE HP_WIZARD_PROTECTS_WIZARD CASCADE CONSTRAINTS;
DROP TABLE HP_CREATURE CASCADE CONSTRAINTS;
DROP TABLE HP_WIZARD_OWNS_CREATURE CASCADE CONSTRAINTS;
DROP TABLE HP_TEXT CASCADE CONSTRAINTS;
DROP TABLE HP_ENCHANTED_ITEM CASCADE CONSTRAINTS;
DROP TABLE HP_CHARACTER_ENCHANTED_ITEM CASCADE CONSTRAINTS;
DROP TABLE HP_SPELL CASCADE CONSTRAINTS;
DROP TABLE HP_CHARACTER_SPELL CASCADE CONSTRAINTS;
DROP TABLE HP_NOTABLE_FOOD CASCADE CONSTRAINTS;
DROP TABLE HP_WHERE_TO_OBTAIN_FOOD CASCADE CONSTRAINTS;
DROP TABLE HP_CHARACTER_FOOD CASCADE CONSTRAINTS;
DROP TABLE HP_POTION CASCADE CONSTRAINTS;
DROP TABLE HP_POTION_INGREDIENT CASCADE CONSTRAINTS;
DROP TABLE HP_POTION_RECIPE CASCADE CONSTRAINTS;
DROP TABLE HP_WIZARD_MAKES_POTION CASCADE CONSTRAINTS;
DROP TABLE HP_POTION_EFFECT CASCADE CONSTRAINTS;
DROP TABLE HP_GROUP CASCADE CONSTRAINTS;
DROP TABLE HP_GROUP_WIZARD_AFFILIATION CASCADE CONSTRAINTS;



CREATE TABLE HP_SCHOOL
    (School_Name             VARCHAR(50)        NOT NULL,
    School_Number_of_Houses    INTEGER,
    School_Region            VARCHAR(50),
    Constraint HP_SCHOOL_PK
        Primary Key    (School_Name)
    );

NSERT INTO HP_SCHOOL (School_Name, School_Number_Of_Houses, School_Region)
    VALUES ('Hogwarts', 4, 'United Kingdom');
NSERT INTO HP_SCHOOL (School_Name, School_Number_Of_Houses, School_Region)
    VALUES ('Durmstrang', 1, 'Eastern Europe');
NSERT INTO HP_SCHOOL (School_Name, School_Number_Of_Houses, School_Region)
    VALUES ('Beauxbatons', 1, 'France');

CREATE TABLE HP_HOUSE
      (House_Name             VARCHAR(50)     NOT NULL,
      House_Symbol             VARCHAR(50),
      Wizard_Name_In_Charge     VARCHAR(50),
      School_Name_Belongs_To     VARCHAR(50),
      Constraint HP_HOUSE_PK
          Primary Key (House_Name),
      Constraint HP_HOUSE_FK1 Foreign Key (School_Name_Belongs_To)
          References HP_SCHOOL (School_Name)
      );

CREATE TABLE HP_HOUSE_CHARACTERISTIC
      (House_Name             VARCHAR(50)     NOT NULL,
      House_Characteristic     VARCHAR(50)     NOT NULL,
      Constraint HP_HOUSE_CHARACTERISTIC_PK
          Primary Key (House_Name,House_Characteristic),
      Constraint HP_HOUSE_CHARACTERISTIC_FK1 Foreign Key (House_Name)
          References HP_HOUSE (House_Name)
      );

CREATE TABLE HP_CHARACTER
    (Character_Name         VARCHAR(50)        NOT NULL,
    Character_Level_Of_Impact    VARCHAR(50)
        Check(Character_Level_Of_Impact IN('All Books', 'Most Books', 'Less Than
            Half of Books', 'One Book', 'One Chapter', 'Referenced')),
    Character_Human            CHAR(1)
        Check (Character_Human IN('Y', 'N')),
    Character_Creature        CHAR(1)
        Check (Character_Creature IN('Y', 'N')),
    School_Name_Visited        VARCHAR(50),
    Constraint HP_CHARACTER_PK
        Primary Key (Character_Name),
    Constraint HP_CHARACTER_FK1 Foreign Key (School_Name_Visited)
        References HP_SCHOOL (School_Name)
    );

CREATE TABLE HP_LANGUAGE
    (Language_Name        VARCHAR(50)     NOT NULL,
    Character_Name        VARCHAR(50)     NOT NULL,
    Constraint HP_LANGUAGE_PK
        Primary Key    (Language_Name, Character_Name),
    Constraint HP_LANGUAGE_FK1 Foreign Key (Character_Name)
        References HP_CHARACTER (Character_Name)
    );

CREATE TABLE HP_BOOK_APPEARED_IN
    (Book_Number         INTEGER         NOT NULL,
    Character_Name        VARCHAR(50)        NOT NULL,
    Constraint HP_BOOK_APPEARED_IN_PK
        Primary Key (Book_Number, Character_Name),
    Constraint HP_BOOK_APPEARED_IN_FK1 Foreign Key (Character_Name)
        References HP_CHARACTER (Character_Name)
    );

CREATE TABLE HP_MOVIE_APPEARED_IN
    (Movie_Number        INTEGER         NOT NULL,
    Character_Name        VARCHAR(50)     NOT NULL,
    Constraint HP_MOVIE_APPEARED_IN_PK
        Primary Key    (Movie_Number, Character_Name),
    Constraint HP_MOVIE_APPEARED_IN_FK1 Foreign Key (Character_Name)
        References HP_CHARACTER (Character_Name)
    );

CREATE TABLE HP_CHARACTER_PARENT
    (Child_Name        VARCHAR(50)        NOT NULL,
    Parent_Name        VARCHAR(50)        NOT NULL,
    Constraint HP_CHARACTER_PARENT_PK
        Primary Key (Child_Name, Parent_Name),
    Constraint HP_CHARACTER_PARENT_FK1 Foreign Key (Child_Name)
        References HP_CHARACTER (Character_Name),
    Constraint HP_CHARACTER_PARENT_FK2 Foreign Key (Parent_Name)
        References HP_CHARACTER (Character_Name)
    );

CREATE TABLE HP_HUMAN
    (Human_Name         VARCHAR(50)        NOT NULL,
    Human_Profession    VARCHAR(50),
    Human_Type            CHAR(1)
        Check (Human_Type IN('M', 'W')),
    Constraint HP_HUMAN_PK
        Primary Key (Human_Name),
    Constraint HP_HUMAN_FK1 Foreign Key    (Human_Name)
        References HP_CHARACTER (Character_Name)
    );

CREATE TABLE HP_MUGGLE
    (Muggle_Name        VARCHAR(50)        NOT NULL,
    Muggle_Citizenship    VARCHAR(50),
    Constraint HP_MUGGLE_PK
        Primary Key    (Muggle_Name),
    Constraint HP_MUGGLE_FK1 Foreign Key (Muggle_Name)
        References HP_HUMAN (Human_Name)
    );

CREATE TABLE HP_WIZARD
    (Wizard_Name         VARCHAR(50)        NOT NULL,
    Wizard_Wand_Type    VARCHAR(50),
    Wizard_Patronus        VARCHAR(50),
    Wizard_Familiar_Type    VARCHAR(50),
        Check (Wizard_Familiar_Type IN('Cat', 'Toad', 'Owl', 'Snake', 'Phoenix')),
    House_Name_Belongs_To     VARCHAR(50),
    School_Name_Attended VARCHAR(50),
    Constraint HP_WIZARD_PK
        Primary Key (Wizard_Name),
    Constraint HP_WIZARD_FK1 Foreign Key (Wizard_Name)
        References HP_HUMAN (Human_Name),
    Constraint HP_WIZARD_FK2 Foreign Key (House_Name_Belongs_To)
        References HP_HOUSE (House_Name),
    Constraint HP_WIZARD_FK3 Foreign Key (School_Name_Attended)
        References HP_SCHOOL (School_Name)
    );

ALTER TABLE HP_HOUSE
    Add Constraint HP_HOUSE_FK2 Foreign Key (Wizard_Name_In_Charge)
    References HP_WIZARD (Wizard_Name);

CREATE TABLE HP_WIZARD_PROTECTS_MUGGLE
    (Wizard_Name         VARCHAR(50)        NOT NULL,
    Muggle_Name         VARCHAR(50)        NOT NULL,
    Chapter_Last_Protected_By     VARCHAR(20),
    Constraint    HP_WIZARD_PROTECTS_MUGGLE_PK
        Primary Key (Wizard_Name, Muggle_Name),
    Constraint HP_WIZARD_PROTECTS_MUGGLE_FK1 Foreign Key (Wizard_Name)
        References HP_WIZARD (Wizard_Name),
    Constraint HP_WIZARD_PROTECTS_MUGGLE_FK2 Foreign Key (Muggle_Name)
        References HP_MUGGLE (Muggle_Name)
    );

CREATE TABLE HP_WIZARD_PROTECTS_WIZARD
    (Wizard_Name         VARCHAR(50)        NOT NULL,
    Protector_Name        VARCHAR(50)        NOT NULL,
    Chapter_Last_Protected_By     VARCHAR(50),
    Constraint HP_WIZARD_PROTECTS_WIZARD_PK
        Primary Key (Wizard_Name, Protector_Name),
    Constraint HP_WIZARD_PROTECTS_WIZARD_FK1 Foreign Key (Wizard_Name)
        References HP_WIZARD (Wizard_Name),
    Constraint HP_WIZARD_PROTECTS_WIZARD_FK2 Foreign Key (Protector_Name)
        References HP_WIZARD (Wizard_Name)
    );

CREATE TABLE HP_CREATURE
      (Creature_Name         VARCHAR(50)     NOT NULL,
      Creature_Species     VARCHAR(50),
      Constraint HP_CREATURE_PK
          Primary Key (Creature_Name),
      Constraint HP_CREATURE_FK1 Foreign Key (Creature_Name)
          References HP_CHARACTER (Character_Name)
      );

CREATE TABLE HP_WIZARD_OWNS_CREATURE
    (Wizard_Name   VARCHAR(50)  NOT NULL,
        Creature_Name VARCHAR(50)  NOT NULL,
        Chapter_Last_Owned VARCHAR(20),
        Constraint HP_WIZARD_OWNS_CREATURE_PK
         Primary Key (Wizard_Name, Creature_Name),
        Constraint HP_WIZARD_OWNS_CREATURE_FK1 Foreign Key (Wizard_Name)
         References HP_WIZARD (Wizard_Name),
        Constraint HP_WIZARD_OWNS_CREATURE_FK2 Foreign Key (Creature_Name)
         References HP_Creature (Creature_Name)
        );

CREATE TABLE HP_TEXT
    (Text_Title            VARCHAR(50)        NOT    NULL,
    Text_Author            VARCHAR(50),
    Text_Subject_Matter    VARCHAR(50),
    Text_Style            VARCHAR(50)
        Check(Text_Style IN('Poetry', 'Prose', 'Textbook', 'Journal')),
    Character_Name_Read VARCHAR(50),
    Wizard_Name_Enchanted    VARCHAR(50),
    Constraint HP_TEXT_PK
        Primary Key (Text_Title),
    Constraint HP_TEXT_FK1 Foreign Key (Character_Name_Read)
        References HP_CHARACTER (Character_Name),
    Constraint HP_TEXT_FK2 Foreign Key (Wizard_Name_Enchanted)
        References HP_WIZARD (Wizard_Name)
    );

CREATE TABLE HP_ENCHANTED_ITEM
    (Item_Name             VARCHAR(50)        NOT NULL,
    Item_Enchantment    VARCHAR(50),
    Item_Type            VARCHAR(50),
    Constraint    HP_ENCHANTED_ITEM_PK
        Primary Key (Item_Name)
    );

CREATE TABLE HP_CHARACTER_ENCHANTED_ITEM
    (Character_Name     VARCHAR(50)        NOT NULL,
    Item_Name            VARCHAR(50)        NOT NULL,
    Chapter_Last_Owned    VARCHAR(20),
    Constraint HP_CHARACTER_ENC_ITEM_PK
        Primary Key (Character_Name, Item_Name),
    Constraint HP_CHARACTER_ENC_ITEM_FK1 Foreign Key (Character_Name)
        References HP_CHARACTER (Character_Name),
    Constraint HP_CHARACTER_ENC_ITEM_FK2 Foreign Key (Item_Name)
        References HP_ENCHANTED_ITEM (Item_Name)
    );

CREATE TABLE HP_SPELL
    (Spell_Name            VARCHAR(50)        NOT NULL,
    Spell_Type            VARCHAR(50),
    Spell_Result        VARCHAR(50),
    Spell_Method_Of_Casting    VARCHAR(100),
    Constraint HP_SPELL_PK
        Primary Key (Spell_Name)
    );

CREATE TABLE HP_CHARACTER_SPELL
    (Character_Name     VARCHAR(50)        NOT NULL,
    Spell_Name            VARCHAR(50)        NOT NULL,
    Chapter_Of_Last_Casting    VARCHAR(20),
    Constraint HP_CHARACTER_SPELL_PK
        Primary Key (Character_Name, Spell_Name),
    Constraint HP_CHARACTER_SPELL_FK1 Foreign Key (Character_Name)
        References HP_CHARACTER (Character_Name),
    Constraint HP_CHARACTER_SPELL_FK2 Foreign Key (Spell_Name)
        References HP_SPELL (Spell_Name)
    );

CREATE TABLE HP_NOTABLE_FOOD
    (Food_Name            VARCHAR(50)        NOT NULL,
    Food_Enchantment    VARCHAR(50),
    Food_Type            VARCHAR(50),
    Constraint HP_NOTABLE_FOOD_PK
        Primary Key (Food_Name)
    );

CREATE TABLE HP_WHERE_TO_OBTAIN_FOOD
    (Food_Name             VARCHAR(50)        NOT NULL,
    Food_Location        VARCHAR(50)        NOT NULL,
    Constraint HP_WHERE_TO_OBTAIN_FOOD_PK
        Primary Key (Food_Name, Food_Location),
    Constraint HP_WHERE_TO_OBTAIN_FOOD_FK1 Foreign Key (Food_Name)
        References HP_NOTABLE_FOOD (Food_Name)
    );

CREATE TABLE HP_CHARACTER_FOOD
    (Character_Name     VARCHAR(50)        NOT NULL,
    Food_Name             VARCHAR(50)        NOT NULL,
    Chapter_Last_Eaten_By VARCHAR(20),
    Constraint HP_CHARACTER_FOOD_PK
        Primary Key (Character_Name, Food_Name),
    Constraint HP_CHARACTER_FOOD_FK1 Foreign Key (Character_Name)
        References HP_CHARACTER (Character_Name),
    Constraint HP_CHARACTER_FOOD_FK2 Foreign Key (Character_Name)
        References HP_NOTABLE_FOOD (Food_Name)
    );

CREATE TABLE HP_POTION
      (Potion_Name         VARCHAR(50)     NOT NULL,
      Wizard_Name_Inventor VARCHAR(50),
      Constraint HP_POTION_PK
          Primary Key (Potion_Name),
      Constraint HP_POTION_FK1 Foreign Key (Wizard_Name_Inventor)
          References HP_WIZARD (Wizard_Name)
      );

CREATE TABLE HP_POTION_INGREDIENT
      (Potion_Ingredient_Name VARCHAR(50)     NOT NULL,
      Potion_Ingred_Loc_Found VARCHAR(50),
      Constraint HP_POTION_INGREDIENT_PK
          Primary Key (Potion_Ingredient_Name)
      );

CREATE TABLE HP_POTION_RECIPE
      (Potion_Recipe_Id     INTEGER         NOT NULL,
       Potion_Name         VARCHAR(50)     NOT NULL,
       Potion_Ingredient_Name     VARCHAR(50) NOT NULL,
       Constraint HP_POTION_RECIPE_PK
           Primary Key (Potion_Recipe_Id, Potion_Name, Potion_Ingredient_Name),
       Constraint HP_POTION_INGREDIENT_FK1 Foreign Key (Potion_Name)
           References HP_POTION (Potion_Name),
       Constraint HP_POTION_INGREDIENT_FK2 Foreign Key (Potion_Ingredient_Name)
           References HP_POTION_INGREDIENT (Potion_Ingredient_Name)
      );

CREATE TABLE HP_WIZARD_MAKES_POTION
      (Wizard_Name         VARCHAR(50)     NOT NULL,
      Potion_Name         VARCHAR(50)     NOT NULL,
      Last_Chapter_Made_By VARCHAR(50),
      Constraint HP_WIZARD_MAKES_POTION_PK
          Primary Key (Wizard_Name,Potion_Name),
      Constraint HP_WIZARD_MAKES_POTION_FK1 Foreign Key (Wizard_Name)
          References HP_WIZARD (Wizard_Name),
      Constraint HP_WIZARD_MAKES_POTION_FK2 Foreign Key (Potion_Name)
          References HP_POTION (Potion_Name)
      );

CREATE TABLE HP_POTION_EFFECT
      (Potion_Name         VARCHAR(50)     NOT NULL,
      Potion_Effect         VARCHAR(50)     NOT NULL,
      Constraint HP_POTION_EFFECT_PK
          Primary Key (Potion_Name,Potion_Effect),
      Constraint HP_POTION_EFFECT_FK1 Foreign Key (Potion_Name)
          References HP_POTION (Potion_Name)
      );

CREATE TABLE HP_GROUP
      (Group_Name         VARCHAR(50)     NOT NULL,
      Group_Purpose         VARCHAR(50),
      Group_Ethical_Orientation VARCHAR(50)
          Check (Group_Ethical_Orientation IN ('Good', 'Evil', 'Neutral')),
      Wizard_Name_Leader     VARCHAR(50),
      Constraint HP_GROUP_PK
          Primary Key (Group_Name),
      Constraint HP_GROUP_FK1 Foreign Key (Wizard_Name_Leader)
          References HP_WIZARD (Wizard_Name)
      );

CREATE TABLE HP_GROUP_WIZARD_AFFILIATION
      (Group_Name         VARCHAR(50)     NOT NULL,
      Wizard_Name         VARCHAR(50)     NOT NULL,
      Constraint HP_GROUP_WIZARD_AFFIL_PK
          Primary Key (Group_Name, Wizard_Name),
      Constraint HP_GROUP_WIZARD_AFFIL_FK1 Foreign Key (Group_Name)
          References HP_GROUP (Group_Name),
      Constraint HP_GROUP_WIZARD_AFFIL_FK2 Foreign Key (Wizard_Name)
          References HP_WIZARD (Wizard_Name)
      );

INSERT INTO HP_SCHOOL (School_Name, School_Number_Of_Houses, School_Region)
    VALUES ('Hogwarts', 4, 'United Kingdom');
INSERT INTO HP_CHARACTER (Character_Name, Character_Level_Of_Impact, Character_Human, Character_Creature, School_Name_Visited)
    VALUES('Harry Potter', 'All Books', 'Y', 'N', 'Hogwarts');

      INSERT INTO HP_MOVIE_APPEARED_IN VALUES (1, 'Harry Potter');
      INSERT INTO HP_MOVIE_APPEARED_IN VALUES (2, 'Harry Potter');
      INSERT INTO HP_MOVIE_APPEARED_IN VALUES (3, 'Harry Potter');
      INSERT INTO HP_MOVIE_APPEARED_IN VALUES (4, 'Harry Potter');
      INSERT INTO HP_MOVIE_APPEARED_IN VALUES (5, 'Harry Potter');
      INSERT INTO HP_MOVIE_APPEARED_IN VALUES (6, 'Harry Potter');
      INSERT INTO HP_MOVIE_APPEARED_IN VALUES (7, 'Harry Potter');
      INSERT INTO HP_MOVIE_APPEARED_IN VALUES (8, 'Harry Potter');

select * from HP_CHARACTER;​
