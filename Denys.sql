create database Den_Illichov character set 'utf8mb4';

use Den_Illichov;

create table users (
	id int auto_increment primary key,
    login varchar (25) not null,
    password varchar (25) not null
);

insert into users values
(null, 'gamer01', 'profi21'),      
(null, 'bobik23', 'toper22'),
(null, 'middle2', 'promaster'),
(null, 'kiler23', 'roofer'),
(null, 'mmonster3', 'kikomo'),
(null, 'qwerty', 'profi21'),
(null, 'zoomer7', 'korgi99'),
(null, 'mustafa', 'rembo93'),
(null, 'goinman', 'lolkek'),
(null, 'moonman', 'cocon23'),
(null, 'noob42', 'merka3'),
(null, 'navi01', 'noobie33'),
(null, 'lolman2', 'promt42'),
(null, 'gooroo2', 'kilmonger2'),
(null, 'rinman2', 'zxcvb1');


create table profiles (
	id int auto_increment primary key,
    first_name varchar (25) not null,
    last_name varchar (25) not null,
    email varchar (25) not null,
    age varchar (25) not null
);

insert into profiles values
(null, 'Sam', 'Green', 'promt@ukr.net', '22'),  
(null, 'Monika', 'White', 'rom22@ukr.net', '25'),  
(null, 'Jon', 'Blue', 'drom1@ukr.net', '21'),  
(null, 'Din', 'Green', 'prom2@ukr.net', '26'),  
(null, 'Sam', 'Marli', 'phot4@ukr.net', '28'),  
(null, 'Den', 'Moon', 'brom@ukr.net', '21'),  
(null, 'Phil', 'Grey', 'grant@ukr.net', '25'),  
(null, 'Nami', 'Gram', 'print@ukr.net', '30'),  
(null, 'Nill', 'Man', 'prot11@ukr.net', '22'),  
(null, 'Daria', 'Green', 'roomi@ukr.net', '26');  


create table games (
	id int auto_increment primary key,
    first_player_id int ,
    second_player_id int
);

insert into games values
(null, 1, 2),
(null, 2, 1),
(null, 3, 4),
(null, 4, 3),
(null, 5, 6),
(null, 6, 5),
(null, 7, 8),
(null, 8, 7),
(null, 9, 10),
(null, 10, 9);

create table game_results (
	id int auto_increment primary key,
    result_value  varchar (10) not null
);

insert into game_results values
(null, 'WIN'),
(null, 'LOSE'),
(null, 'DRAW');

create table achievements (
	id int auto_increment primary key,
    achiev_name varchar (20)
);

insert into achievements values
(null, 'master'),
(null, 'newbie'),
(null, 'perfectly'),
(null, 'fine'),
(null, 'middle');

create table player_achievs (
	id int auto_increment primary key,
    player_id int,
    achiev_id int
);

insert into player_achievs values
(null, 1, 1),
(null, 2, 1),
(null, 2, 2),
(null, 3, 4),
(null, 3, 5),
(null, 3, 2),
(null, 4, 1),
(null, 4, 4),
(null, 5, 2),
(null, 5, 3),
(null, 6, 1),
(null, 6, 4),
(null, 8, 1),
(null, 8, 3),
(null, 8, 5),
(null, 9, 2),
(null, 10, 1),
(null, 10, 5);

create table player_results (
	id int auto_increment primary key,
    player_id int,
    result_id int,
    game_id int
);

insert into player_results values
(null, 1, 3, 1),
(null, 2, 3, 2),
(null, 3, 1, 3),
(null, 4, 2, 4),
(null, 5, 2, 5),
(null, 6, 1, 6),
(null, 7, 3, 7),
(null, 8, 3, 8),
(null, 9, 2, 9),
(null, 10, 1, 10);

delete from users
where id=14;
delete from users
where id=15;

alter table USERS
	add column profiles_id int;
    
update USERS
	set profiles_id = case
						when id = 1 then 1
                        when id = 2 then 2
                        when id = 3 then 3
                        when id = 4 then 4
                        when id = 5 then 5
                        when id = 6 then 6
                        when id = 7 then 7
                        when id = 8 then 8
                        when id = 9 then 9
                        when id = 10 then 10
						else profiles_id
					end;  
                    
update profiles	
	set first_name = 'Bob'
    where id = 5;
    
alter table profiles 
modify age int; 

alter table users
add constraint FK_users_profiles
foreign key (profiles_id)
references profiles (id);

alter table games
add constraint FK_games1_profiles
foreign key (first_player_id)
references profiles (id);

alter table games
add constraint FK_games2_profiles
foreign key (second_player_id)
references profiles (id);	

alter table player_achievs
add constraint FK_player_achievs_profiles
foreign key (player_id)
references profiles (id);

alter table player_achievs
add constraint FK_player_achievs_achievements
foreign key (achiev_id)
references achievements (id);

alter table player_results
add constraint FK_player_id_results_profiles
foreign key (player_id)
references profiles (id);

alter table player_results
add constraint FK_result_id_game_results
foreign key (result_id)
references game_results (id);

alter table player_results 
add constraint FK_game_id_games
foreign key (game_id)
references games (id);


use den_illichov;

select login,
	   first_name,
	   last_name
from users, profiles
where profiles_id = profiles.id;  

select users.login,
	   profiles.first_name,
	   profiles.last_name
from users
join profiles on profiles_id = profiles.id;



select profiles.id,
	   profiles.first_name,
	   profiles.email,
	   achievements.achiev_name
from profiles 
join player_achievs on player_id = profiles.id
join achievements on achiev_id = achievements.id
where profiles.id between 1 and 5;


use Den_Illichov;


select 
	profiles.id,
	profiles.first_name,
	profiles.last_name,
	profiles. email,	
	profiles.age,				
	game_results.result_value		
from profiles, game_results, player_results
where profiles.id = player_results.player_id 
and player_results.result_id = game_results.id
and game_results.id = player_results.result_id
and game_results.id = 1;

       
select  users.login,
		users.password,
        games.id 
from users
join profiles on users.profiles_id  = profiles.id
join games on profiles.id = games.first_player_id;


select 
	profiles.first_name, 
	count(*) as count_of_games
from games 
join profiles on games.second_player_id = profiles.id
group by second_player_id
order by count_of_games desc;


select 
	profiles.first_name,
    profiles.email
from profiles
join (select first_player_id
						from games) as t2 on profiles.id = t2.first_player_id;


                
                
   
       


