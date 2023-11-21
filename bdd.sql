create database myGameList;

use myGameList;

-- Procédure pour ajouter un jeu à la table "Games" & "Games_Platforms"
CREATE PROCEDURE InsertGameWithPlatforms
    @idGame INT,
    @theme1 INT,
    @theme2 INT,
    @theme3 INT,
    @category1 INT,
    @category2 INT,
    @category3 INT,
    @platforms VARCHAR(100),
    @title VARCHAR(50),
    @description VARCHAR(500),
    @releaseDate DATE,
    @multiplayerOnline BIT,
    @multiplayerOffline BIT
AS
BEGIN
    SET NOCOUNT ON;

    SET IDENTITY_INSERT games ON;

    INSERT INTO Games (
        idGame,
        idTheme1,
        idTheme2,
        idTheme3,
        idCategory1,
        idCategory2,
        idCategory3,
        title,
        description,
        releaseDate,
        multiplayerOnline,
        multiplayerOffline
    )
    VALUES (
        @idGame,
        @theme1,
        @theme2,
        @theme3,
        @category1,
        @category2,
        @category3,
        @title,
        @description,
        @releaseDate,
        @multiplayerOnline,
        @multiplayerOffline
    );

    SET IDENTITY_INSERT platforms OFF;

    -- Insérer dans la table "game_platforms"
    INSERT INTO game_platforms (idGame, idPlatform)
    SELECT @idGame, value
    FROM STRING_SPLIT(@platforms, ',');
END;

DROP PROCEDURE InsertGameWithPlatforms;

create table users(
    idUser int identity PRIMARY KEY,
    username varchar(30) not null,
    password varchar(120) not null,

    admin bit not null,

    email varchar(80) not null,
    country varchar(50) not null,
    profilePicture varchar(300) not null,
);

create table Statuts(
    idStatut int identity Primary Key,
    name varchar(50) not null,
);

create table themes (
    idTheme int identity Primary Key,
    name varchar(50) not null
);

create table categories (
    idCategory int identity Primary Key,
    name varchar(50) not null
);

create table platforms (
    idPlatform int identity Primary Key,
    name varchar(100) not null
);

create table games(
    idGame int identity primary key,

    idTheme1 int not null,
    idTheme2 int,
    idTheme3 int,

    idCategory1 int not null,
    idCategory2 int,
    idCategory3 int,

    title varchar(50) not null,
    description varchar(500) not null,
    releaseDate date not null,
    multiplayerOnline bit not null,
    multiplayerOffline bit not null,

    CONSTRAINT fk_games_Theme1 foreign key(idTheme1) references Themes(idTheme),
    CONSTRAINT fk_games_Theme2 foreign key(idTheme2) references Themes(idTheme),
    CONSTRAINT fk_games_Theme3 foreign key(idTheme3) references Themes(idTheme),

    CONSTRAINT fk_games_Category1 foreign key(idCategory1) references Categories(idCategory),
    CONSTRAINT fk_games_Category2 foreign key(idCategory2) references Categories(idCategory),
    CONSTRAINT fk_games_Category3 foreign key(idCategory3) references Categories(idCategory)
);

create table users_games(
    idUser int not null,
    idGame int not null,
    idStatut int not null,
    rate int,

    CONSTRAINT fk_usersGames_User foreign key(idUser) references Users(idUser) ON DELETE CASCADE,
    CONSTRAINT fk_usersGames_Games foreign key(idGame) references Games(idGame) ON DELETE CASCADE,

    CONSTRAINT fk_usersGames_Statut foreign key(idStatut) references Statuts(idStatut) ON DELETE CASCADE
);

create table game_platforms(
    idGame int not null,
    idPlatform int not null,

    CONSTRAINT fk_gamePlatforms_Game foreign key(idGame) references Games(idGame) ON DELETE CASCADE,
    CONSTRAINT fk_gamePlatforms_Platform foreign key(idPlatform) references Platforms(idPlatform) ON DELETE CASCADE,
);

create table game_pictures(
    idGame int not null,
    url varchar(200) not null

    CONSTRAINT fk_gamePicture_game foreign key(idGame) references Games(idGame)
);

DELETE FROM users WHERE idUser > 0;

INSERT INTO users VALUES
('William', 'MotDePasseSecret', 0, 'test1@test.com', 'Belgique', 'pp1.png'),
('Jason', 'MotDePasseSecret', 0, 'test2@test.com', 'France', 'pp2.png'),
('Nathan', 'MotDePasseSecret', 0, 'test3@test.com', 'Espagne', 'pp3.png'),
('Rinel', 'MotDePasseSecret', 0, 'test4@test.com', 'Canada', 'pp4.png'),
('Quentin', 'MotDePasseSecret', 0, 'test5@test.com', 'Pays-Bas', 'pp5.png');

SET IDENTITY_INSERT platforms ON;
INSERT INTO platforms(idPlatform, name) VALUES
(3, 'Linux'), (4, 'Nintendo 64'), (5, 'Wii'), (6, 'PC (Microsoft Windows)'), (7, 'PlayStation'), (8, 'PlayStation 2'), (9, 'PlayStation 3'), (11, 'Xbox'), (12, 'Xbox 360'), (13, 'DOS'), (14, 'Mac'), (15, 'Commodore C64/128/MAX'), (16, 'Amiga'), (18, 'Nintendo Entertainment System'), (19, 'Super Nintendo Entertainment System'), (20, 'Nintendo DS'), (21, 'Nintendo GameCube'), (22, 'Game Boy Color'), (23, 'Dreamcast'), (24, 'Game Boy Advance'),
(25, 'Amstrad CPC'), (26, 'ZX Spectrum'), (27, 'MSX'), (29, 'Sega Mega Drive/Genesis'), (30, 'Sega 32X'), (32, 'Sega Saturn'), (33, 'Game Boy'), (34, 'Android'), (35, 'Sega Game Gear'), (37, 'Nintendo 3DS'), (38, 'PlayStation Portable'), (39, 'iOS'), (41, 'Wii U'), (42, 'N-Gage'), (44, 'Tapwave Zodiac'), (46, 'PlayStation Vita'), (47, 'Virtual Console'), (48, 'PlayStation 4'), (49, 'Xbox One'), (50, '3DO Interactive Multiplayer'), (51, 'Family Computer Disk System'), (52, 'Arcade'),
(53, 'MSX2'), (55, 'Legacy Mobile Device'), (57, 'WonderSwan'), (58, 'Super Famicom'), (59, 'Atari 2600'), (60, 'Atari 7800'), (61, 'Atari Lynx'), (62, 'Atari Jaguar'), (63, 'Atari ST/STE'), (64, 'Sega Master System/Mark III'), (65, 'Atari 8-bit'), (66, 'Atari 5200'), (67, 'Intellivision'), (68, 'ColecoVision'), (69, 'BBC Microcomputer System'), (70, 'Vectrex'), (71, 'Commodore VIC-20'), (72, 'Ouya'), (73, 'BlackBerry OS'), (74, 'Windows Phone'), (75, 'Apple II'),
(77, 'Sharp X1'), (78, 'Sega CD'), (79, 'Neo Geo MVS'), (80, 'Neo Geo AES'), (82, 'Web browser'), (84, 'SG-1000'), (85, 'Donner Model 30'), (86, 'TurboGrafx-16/PC Engine'), (87, 'Virtual Boy'), (88, 'Odyssey'), (89, 'Microvision'), (90, 'Commodore PET'), (91, 'Bally Astrocade'), (93, 'Commodore 16'), (94, 'Commodore Plus/4'), (95, 'PDP-1'), (96, 'PDP-10'), (97, 'PDP-8'), (98, 'DEC GT40'), (99, 'Family Computer'),
(101, 'Ferranti Nimrod Computer'), (102, 'EDSAC'), (103, 'PDP-7'), (104, 'HP 2100'), (105, 'HP 3000'), (106, 'SDS Sigma 7'), (107, 'Call-A-Computer time-shared mainframe computer system'), (108, 'PDP-11'), (109, 'CDC Cyber 70'), (110, 'PLATO'), (111, 'Imlac PDS-1'), (112, 'Microcomputer'), (113, 'OnLive Game System'), (114, 'Amiga CD32'), (115, 'Apple IIGS'), (116, 'Acorn Archimedes'), (117, 'Philips CD-i'), (118, 'FM Towns'), (119, 'Neo Geo Pocket'), (120, 'Neo Geo Pocket Color'),
(121, 'Sharp X68000'), (122, 'Nuon'), (123, 'WonderSwan Color'), (124, 'SwanCrystal'), (125, 'PC-8800 Series'), (126, 'TRS-80'), (127, 'Fairchild Channel F'), (128, 'PC Engine SuperGrafx'), (129, 'Texas Instruments TI-99'), (130, 'Nintendo Switch'), (131, 'Nintendo PlayStation'), (132, 'Amazon Fire TV'), (133, 'Odyssey 2 / Videopac G7000'), (134, 'Acorn Electron'), (135, 'Hyper Neo Geo 64'), (136, 'Neo Geo CD'), (137, 'New Nintendo 3DS'), (138, 'VC 4000'), (139, '1292 Advanced Programmable Video System'),
(140, 'AY-3-8500'), (141, 'AY-3-8610'), (142, 'PC-50X Family'), (143, 'AY-3-8760'), (144, 'AY-3-8710'), (145, 'AY-3-8603'), (146, 'AY-3-8605'), (147, 'AY-3-8606'), (148, 'AY-3-8607'), (149, 'PC-9800 Series'), (150, 'Turbografx-16/PC Engine CD'), (151, 'TRS-80 Color Computer'), (152, 'FM-7'), (153, 'Dragon 32/64'), (154, 'Amstrad PCW'), (155, 'Tatung Einstein'), (156, 'Thomson MO5'), (157, 'NEC PC-6000 Series'), (158, 'Commodore CDTV'), (159, 'Nintendo DSi'), (161, 'Windows Mixed Reality'),
(162, 'Oculus VR'), (163, 'SteamVR'), (164, 'Daydream'), (165, 'PlayStation VR'), (166, 'Pokémon mini'), (167, 'PlayStation 5'), (169, 'Xbox Series X|S'), (170, 'Google Stadia'), (203, 'DUPLICATE Stadia'), (236, 'Exidy Sorcerer'), (237, 'Sol-20'), (238, 'DVD Player'), (239, 'Blu-ray Player'), (240, 'Zeebo'), (274, 'PC-FX'),
(306, 'Satellaview'), (307, 'Game & Watch'), (308, 'Playdia'), (309, 'Evercade'), (339, 'Sega Pico'), (372, 'OOParts'), (373, 'Sinclair ZX81'), (374, 'Sharp MZ-2200'), (375, 'Epoch Cassette Vision'), (376, 'Epoch Super Cassette Vision'), (377, 'Plug & Play'), (378, 'Gamate'), (379, 'Game.com'), (380, 'Casio Loopy'), (381, 'Playdate'), (382, 'Intellivision Amico'), (384, 'Oculus Quest'), (385, 'Oculus Rift'), (386, 'Meta Quest 2'), (387, 'Oculus Go'), (388, 'Gear VR'), (389, 'AirConsole'), (390, 'PlayStation VR2'),
(405, 'Windows Mobile'), (406, 'Sinclair QL'), (407, 'HyperScan'), (408, 'Mega Duck/Cougar Boy'), (409, 'Legacy Computer'), (410, 'Atari Jaguar CD'), (411, 'Handheld Electronic LCD'), (412, 'Leapster'), (413, 'Leapster Explorer/LeadPad Explorer'), (414, 'LeapTV'), (415, 'Watara/QuickShot Supervision'), (416, 'Nintendo 64DD'), (417, 'Palm OS'), (438, 'Arduboy'), (439, 'V.Smile'), (440, 'Visual Memory Unit / Visual Memory System'), (441, 'PocketStation'), (471, 'Meta Quest 3');
SET IDENTITY_INSERT platforms OFF;

SET IDENTITY_INSERT categories ON;
INSERT INTO categories(idCategory, name)  VALUES
(2, 'Point-and-click'),(4, 'Fighting'),(5, 'Shooter'),(7, 'Music'),(8, 'Platform'),(9, 'Puzzle'),(10, 'Racing'),(11, 'Real Time Strategy (RTS)'),(12, 'Role-playing (RPG)'),(13, 'Simulator'),
(14, 'Sport'),(15, 'Strategy'),(16, 'Turn-based strategy (TBS)'),(24, 'Tactical'),(25, 'Hack and slash/Beat em up'),(26, 'Quiz/Trivia'),(30, 'Pinball'),(31, 'Adventure'),(32, 'Indie'),(33, 'Arcade'),
(34, 'Visual Novel'),(35, 'Card & Board Game'),(36, 'MOBA');
SET IDENTITY_INSERT categories OFF;

SET IDENTITY_INSERT themes ON;
INSERT INTO themes(idTheme, name) VALUES
(1, 'Action'), (17, 'Fantasy'), (18, 'Science fiction'), (19, 'Horror'), (20, 'Thriller'), (21, 'Survival'), (22, 'Historical'), (23, 'Stealth'), (27, 'Comedy'), (28, 'Business'), (31, 'Drama'), (32, 'Non-fiction'), (33, 'Sandbox'), (34, 'Educational'), (35, 'Kids'), (38, 'Open world'), (39, 'Warfare'), (40, 'Party'), (41, '4X (explore, expand, exploit, and exterminate)'), (42, 'Erotic'), (43, 'Mystery'), (44, 'Romance');
SET IDENTITY_INSERT themes OFF;

-- DONNÉES
EXEC InsertGameWithPlatforms @idGame=1,@theme1=1,@theme2=17,@theme3=23,@category1=5,@category2=13,@category3=31,@platforms='6',@title='Thief II: The Metal Age',@description='The ultimate thief is back! Tread softly as you make your way through 15 new complex, non-linear levels full of loot to steal and guards to outsmart. Improved enemy AI, new gadgets and a riveting story will draw you into the world of Thief II: The Metal Age, a place of powerful new technologies, fanatical religions and corruption.',@releaseDate='2000-02-29',@multiplayerOnline=0,@multiplayerOffline=0;
EXEC InsertGameWithPlatforms @idGame=2,@theme1=1,@theme2=17,@theme3=23,@category1=13,@category2=31,@category3=NULL,@platforms='6',@title='Thief',@description='Thief is a first-person stealth game that likes the dark. You sneak through the ruins of haunted cathedrals, subterranean ruins, and forbidding prisons, in a dark and sinister city - heavily inspired by Steampunk and the Dark Ages. Garrett finds an ally in the shadows, as he steals for money and uncovers the hidden agendas of allies and enemies. The story that unravels is one of deception and revenge.',@releaseDate='1998-11-30',@multiplayerOnline=0,@multiplayerOffline=0;
EXEC InsertGameWithPlatforms @idGame=3,@theme1=1,@theme2=17,@theme3=23,@category1=5,@category2=13,@category3=31,@platforms='6,11',@title='Thief: Deadly Shadows',@description='In the third instalment of the Thief series, master-thief Garrett is contacted by Keeper Artemus with a mission to steal two valuable artefacts. At the same time, Garrett learns about a prophecy: the coming of a Dark Age. He embarks upon a journey to unravel a mystery that threatens the existence of the order of Keepers. Is it possible that there is a traitor in their midst? The stealth and thievery game, Thief: Deadly Shadows comes with a number of improvements over two previous parts. Released in 2004, it left behind the aging Dark Engine, using a heavily modified Unreal engine instead. Realistic lighting effects have been implemented: each character and object now casts its own shadow. A third person\u0027s view has been made available in addition to the standard first person perspective. The stealth system that made Thief: The Dark Project and Thief 2: The Metal Age famous is still in place. You have to stick to the shadows and avoid making noise, as guards will react to anything suspicious. It is also the first game of the series that introduced free roaming. The City, divided into several unlockable districts, is yours to explore. You can interact with the city\u0027s inhabitants: pickpocket, steal, or even mug them for loot.',@releaseDate='2004-05-24',@multiplayerOnline=0,@multiplayerOffline=0;
EXEC InsertGameWithPlatforms @idGame=4,@theme1=1,@theme2=23,@theme3=33,@category1=5,@category2=31,@category3=NULL,@platforms='6,9,12,14,48,49',@title='Thief (2014)',@description='There is a rising tide of fear in The City. Hatred saturates every stone and whilst the rich prosper, the less fortunate face misery and repression. Ravaged with sickness and famine, they wait for something to change. Into this shadowy world steps Garrett, THE master thief in Thief, a reinvention of a franchise that helped define an entire genre of games. This first-person adventure features intelligent design that allows players to take full control, with freedom to choose their path through the game\u0027s levels and how they approach and overcome each challenge.',@releaseDate='2014-02-26',@multiplayerOnline=0,@multiplayerOffline=0;

-- SUPPRIMER
DROP TABLE themes;
drop table categories;
drop table users;
drop table game_pictures;
drop table game_platforms;
drop table users_games;
DROP TABLE games;
DROP TABLE platforms;

-- AFFICHER
SELECT * FROM categories;
SELECT * FROM platforms;
SELECT * FROM themes;
SELECT * FROM games;
select * from game_platforms;
select * from platforms where idPlatform = 6;
