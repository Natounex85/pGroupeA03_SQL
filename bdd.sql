create database myGameList;

use myGameList;

create table users(
    idUser int identity PRIMARY KEY,
    username varchar(30) not null,
    password varchar(120) not null,

    admin bit not null,

    email varchar(80) not null,
    country varchar(50) not null,
    profilePicture varchar(200) not null,

);

create table games(
    idGame int identity primary key,
    title varchar(50) not null,
    platform varchar(50) not null,
    description varchar(500) not null,
    releaseDate date not null,
    multiplayer bit not null,
    idTheme1 int not null,
    idTheme2 int,
    idTheme3 int,
    idCategory1 int not null,
    idCategory2 int,
    idCategory3 int,


    CONSTRAINT fk_usersGames_Theme1 foreign key(idTheme1) references Theme(idTheme),
    CONSTRAINT fk_usersGames_Theme2 foreign key(idTheme2) references Theme(idTheme),
    CONSTRAINT fk_usersGames_Theme3 foreign key(idTheme3) references Theme(idTheme),

    CONSTRAINT fk_usersGames_Category1 foreign key(idCategory1) references Category(idCategory),
    CONSTRAINT fk_usersGames_Category2 foreign key(idCategory2) references Category(idCategory),
    CONSTRAINT fk_usersGames_Category3 foreign key(idCategory3) references Category(idCategory)
);

create table users_games(
    idUser int not null,
    idGame int not null ,

CONSTRAINT fk_usersGames_User foreign key(idUser) references Users(idUser) ON DELETE CASCADE,
CONSTRAINT fk_usersGames_Games foreign key(idGame) references Games(idGame) ON DELETE CASCADE

);

create table theme (
    idTheme int identity Primary Key,
    name varchar(50) not null
)

create table category (
    idCategory int identity Primary Key,
    name varchar(50) not null
)

create table game_pictures(
    idGame int not null,
    url varchar(200) not null

    CONSTRAINT fk_gamePicture_game foreign key(idGame) references Games(idGame)
);