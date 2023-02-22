CREATE TABLE Person (
	id int PRIMARY KEY AUTO_INCREMENT,
	firstName varchar(255),
	lastName varchar(255),
	email varchar(255),
	gender varchar(255),
	phoneNumber varchar(255),
	password varchar(255)
);
CREATE TABLE Club (
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(255)
);
CREATE TABLE Team (
	id int PRIMARY KEY AUTO_INCREMENT,
	clubId int,
	teamName varchar(255)
);
CREATE TABLE TeamStaff (
	PersonId int,
	TeamId int,
	role varchar(255)
);
CREATE TABLE TeamPlayer (PersonId int, TeamId int);
CREATE TABLE Training (
	id int PRIMARY KEY AUTO_INCREMENT,
	TeamId int,
	date datetime,
	location varchar(255)
);
CREATE TABLE PlayerTraining (PersonId int, TrainingId int);
CREATE TABLE Game (
	id int PRIMARY KEY AUTO_INCREMENT,
	LeagueId int,
	homeTeam int,
	awayTeam int,
	homeScore int,
	awayScore int,
	date datetime,
	location varchar(255)
);
CREATE TABLE League (
	id int PRIMARY KEY AUTO_INCREMENT,
	leagueName varchar(255),
	federation varchar(255)
);
CREATE TABLE PlayerGame (
	PersonId int,
	GameId int,
	goals int,
	assist int,
	yellowCard int,
	redCard int
);
CREATE TABLE News (
	id int PRIMARY KEY AUTO_INCREMENT,
	PersonId int,
	TeamId int,
	title varchar(255),
	content varchar(255),
	published datetime
);
CREATE TABLE GameSummary (
	GameId int,
	PersonId int,
	content varchar(255)
);
ALTER TABLE Team
ADD FOREIGN KEY (clubId) REFERENCES Club (id);
ALTER TABLE TeamStaff
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE TeamStaff
ADD FOREIGN KEY (TeamId) REFERENCES Team (id);
ALTER TABLE TeamPlayer
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE TeamPlayer
ADD FOREIGN KEY (TeamId) REFERENCES Team (id);
ALTER TABLE Training
ADD FOREIGN KEY (TeamId) REFERENCES Team (id);
ALTER TABLE PlayerTraining
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE PlayerTraining
ADD FOREIGN KEY (TrainingId) REFERENCES Training (id);
ALTER TABLE Game
ADD FOREIGN KEY (LeagueId) REFERENCES League (id);
ALTER TABLE Game
ADD FOREIGN KEY (homeTeam) REFERENCES Team (id);
ALTER TABLE Game
ADD FOREIGN KEY (awayTeam) REFERENCES Team (id);
ALTER TABLE PlayerGame
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE PlayerGame
ADD FOREIGN KEY (GameId) REFERENCES Game (id);
ALTER TABLE News
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
ALTER TABLE News
ADD FOREIGN KEY (TeamId) REFERENCES Team (id);
ALTER TABLE GameSummary
ADD FOREIGN KEY (GameId) REFERENCES Game (id);
ALTER TABLE GameSummary
ADD FOREIGN KEY (PersonId) REFERENCES Person (id);
-- INSERT TEST DATA
-- Clubs
INSERT INTO Club (name) VALUES ('FC Barcelona');
INSERT INTO Club (name) VALUES ('Real Madrid');
INSERT INTO Club (name) VALUES ('Manchester United');
INSERT INTO Club (name) VALUES ('Liverpool');
INSERT INTO Club (name) VALUES ('Chelsea');

-- Teams
INSERT INTO Team (clubId, teamName) VALUES (1, 'FC Barcelona A');
INSERT INTO Team (clubId, teamName) VALUES (1, 'FC Barcelona B');
INSERT INTO Team (clubId, teamName) VALUES (2, 'Real Madrid A');
INSERT INTO Team (clubId, teamName) VALUES (2, 'Real Madrid B');
INSERT INTO Team (clubId, teamName) VALUES (3, 'Manchester United A');
INSERT INTO Team (clubId, teamName) VALUES (3, 'Manchester United B');
INSERT INTO Team (clubId, teamName) VALUES (4, 'Liverpool A');
INSERT INTO Team (clubId, teamName) VALUES (4, 'Liverpool B');
INSERT INTO Team (clubId, teamName) VALUES (5, 'Chelsea A');

-- Leagues
INSERT INTO League (leagueName, federation) VALUES ('La Liga', 'Spanish Football Federation');
INSERT INTO League (leagueName, federation) VALUES ('Premier League', 'English Football Federation');
INSERT INTO League (leagueName, federation) VALUES ('Bundesliga', 'German Football Federation');
INSERT INTO League (leagueName, federation) VALUES ('Serie A', 'Italian Football Federation');
INSERT INTO League (leagueName, federation) VALUES ('Ligue 1', 'French Football Federation');

-- Person
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Samuel","Stephenson","stephenson_samuel@yahoo.ca","M","1-846-666-0318","sed"),
  ("Buckminster","Cooley","cbuckminster9377@outlook.com","M","(554) 324-0782","at,"),
  ("Dante","Carney","carney.dante@protonmail.ca","M","1-411-849-1434","Aliquam"),
  ("Lyle","Peck","pecklyle136@yahoo.ca","M","(368) 940-7437","orci."),
  ("Brandon","Moss","brandon.moss@hotmail.couk","M","1-819-568-5664","ornare"),
  ("Wing","Davidson","davidson.wing@yahoo.ca","M","(623) 761-8815","Nam"),
  ("Giacomo","Richard","g.richard@yahoo.com","M","(694) 726-6322","magna."),
  ("Nigel","Baldwin","nigel_baldwin2655@hotmail.net","M","(588) 687-2368","gravida."),
  ("Hilel","Larson","h-larson9766@icloud.com","M","(741) 933-3102","nonummy"),
  ("Graiden","Vincent","g-vincent3825@aol.net","M","1-666-608-6130","sem.");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Damian","Chase","chase_damian9625@hotmail.net","M","(218) 842-8229","elit,"),
  ("Ezra","Dunn","dezra1660@aol.ca","M","(727) 262-5712","vitae"),
  ("Mohammad","Burns","mohammad.burns647@hotmail.net","M","(365) 961-3373","fringilla"),
  ("Tate","Manning","m-tate@outlook.org","M","1-340-719-0529","amet"),
  ("Camden","Smith","c.smith@icloud.com","M","1-201-151-6576","Integer"),
  ("Russell","Young","r-young@yahoo.com","M","(540) 785-6885","molestie"),
  ("Caleb","Meyer","m_caleb7145@hotmail.ca","M","1-276-931-9613","Suspendisse"),
  ("Hamilton","Green","hgreen@outlook.couk","M","1-349-649-7763","posuere,"),
  ("Barrett","Wiley","wiley_barrett1527@aol.com","M","(707) 475-5843","ultrices"),
  ("Garrison","Rocha","garrison-rocha@hotmail.org","M","1-236-512-8478","Nam");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Raymond","Gates","rgates@icloud.couk","M","(574) 345-5395","in"),
  ("Keith","Hogan","hogan.keith1251@icloud.edu","M","(370) 582-4231","In"),
  ("Caleb","Whitley","w_caleb@hotmail.ca","M","(491) 676-7183","Nullam"),
  ("Otto","Spears","s_otto9245@icloud.com","M","(958) 846-4260","ligula."),
  ("Fitzgerald","Villarreal","villarreal_fitzgerald@icloud.net","M","1-305-481-7426","ornare,"),
  ("Beck","Cherry","b_cherry3805@yahoo.org","M","1-404-889-6238","dis"),
  ("Dylan","Wise","wise.dylan@outlook.couk","M","1-273-665-1930","dapibus"),
  ("Francis","Swanson","swanson-francis437@google.couk","M","(932) 922-6116","auctor,"),
  ("Troy","Mcintosh","m.troy323@protonmail.ca","M","1-104-439-8093","Donec"),
  ("Austin","Olsen","olsenaustin6771@aol.edu","M","1-653-250-4789","lobortis");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Malik","Lawrence","malik.lawrence@google.edu","M","1-823-712-6494","augue"),
  ("Zachary","Chase","c-zachary6851@yahoo.org","M","1-293-941-4677","semper."),
  ("Peter","Mayer","m-peter9520@google.ca","M","1-884-976-3304","libero"),
  ("Buckminster","Mayer","mayer_buckminster@google.org","M","1-837-342-3439","lorem,"),
  ("Lawrence","Harvey","harvey-lawrence@hotmail.com","M","1-768-459-5736","sit"),
  ("Xander","Wood","wood-xander@yahoo.org","M","1-360-264-6732","metus."),
  ("Ethan","Ford","e-ford@hotmail.com","M","(253) 615-8513","placerat."),
  ("Ciaran","Parker","pciaran175@outlook.org","M","(794) 576-1524","nisl."),
  ("Plato","Barton","p-barton4700@outlook.org","M","(664) 865-8717","fermentum"),
  ("Carlos","Le","carlos_le6268@icloud.org","M","(470) 241-2543","Nunc");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Brody","Bridges","b_brody@icloud.com","M","(587) 880-4912","tincidunt"),
  ("Arden","Cameron","acameron@outlook.org","M","(484) 430-1487","non,"),
  ("Hashim","Browning","hashim.browning8153@icloud.ca","M","1-749-482-1366","rhoncus."),
  ("Elvis","Dominguez","dominguezelvis9888@outlook.ca","M","(368) 660-5115","metus"),
  ("Caleb","Hernandez","c-hernandez3668@yahoo.org","M","(212) 900-5766","Aliquam"),
  ("Ignatius","Franks","franksignatius8572@yahoo.com","M","1-446-624-3777","Aliquam"),
  ("Jarrod","Bolton","jbolton1250@google.edu","M","1-223-588-5361","arcu."),
  ("Carson","Nunez","cnunez@aol.couk","M","1-832-672-7461","eu"),
  ("Xenos","Farmer","xenosfarmer@hotmail.ca","M","1-486-137-0516","taciti"),
  ("Raymond","Roman","r-roman@hotmail.couk","M","1-383-322-3397","velit");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Phelan","Snyder","p.snyder8453@yahoo.com","M","1-425-468-1427","semper"),
  ("Jermaine","Madden","madden-jermaine60@google.ca","M","1-206-808-4251","enim"),
  ("Melvin","Finch","f.melvin3718@hotmail.ca","M","(832) 475-1716","convallis"),
  ("Leo","Weber","lweber494@yahoo.net","M","1-984-869-6214","sit"),
  ("Mohammad","Levy","levymohammad@aol.net","M","1-675-166-3433","non"),
  ("Norman","Herring","n-herring905@hotmail.net","M","(675) 342-6463","dictum"),
  ("Talon","Ryan","t.ryan4803@google.com","M","(718) 642-4535","diam."),
  ("Dalton","Fuller","daltonfuller@google.net","M","(741) 355-1248","nibh"),
  ("Derek","Phelps","phelpsderek@aol.edu","M","(873) 134-2205","lectus"),
  ("Boris","Wade","w_boris3791@outlook.edu","M","(294) 482-1788","neque");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("August","Carr","acarr@hotmail.edu","M","(672) 396-9868","magna."),
  ("Linus","Rosales","r_linus@icloud.couk","M","(672) 473-7666","libero."),
  ("Griffith","Rice","griffithrice9786@google.edu","M","1-712-627-5832","a"),
  ("Aaron","Trujillo","t-aaron@yahoo.net","M","1-376-166-9278","in,"),
  ("Roth","Banks","r_banks@outlook.net","M","1-481-284-6665","sociis"),
  ("Talon","Meadows","t_meadows7005@outlook.com","M","(858) 844-8814","Proin"),
  ("Baxter","Avila","baxteravila@yahoo.couk","M","(524) 316-3538","tellus."),
  ("Barrett","Le","l.barrett3103@google.com","M","(821) 385-2248","et,"),
  ("Derek","Thompson","thompson_derek@google.couk","M","(784) 702-8444","semper"),
  ("Ryan","Foley","r-foley@outlook.ca","M","1-330-277-2247","amet");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Yasir","Glass","yasir.glass@google.org","M","1-598-872-2676","egestas."),
  ("Mark","Schneider","schneider.mark1097@google.com","M","(438) 252-3034","lacus."),
  ("Eagan","Leon","e_leon800@protonmail.net","M","1-457-688-2469","semper"),
  ("Otto","Stanton","ostanton@aol.edu","M","(871) 514-6294","urna"),
  ("Drew","Clements","clementsdrew5675@yahoo.ca","M","(501) 256-0057","Curabitur"),
  ("Malachi","Oliver","olivermalachi@yahoo.org","M","1-445-670-6154","Curabitur"),
  ("Steel","Grant","steel-grant9746@aol.couk","M","(431) 751-5703","commodo"),
  ("Oscar","Valdez","o.valdez@protonmail.net","M","1-546-257-8777","diam"),
  ("Alec","Stuart","alec_stuart@hotmail.org","M","(602) 374-0926","neque."),
  ("Coby","Salazar","cobysalazar8154@google.edu","M","(752) 400-7413","lectus");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Upton","Miranda","miranda_upton@protonmail.couk","M","(731) 304-5133","primis"),
  ("Ciaran","Garza","ciaran.garza6895@google.couk","M","(565) 595-1434","adipiscing"),
  ("Felix","Kaufman","felixkaufman@outlook.com","M","(205) 253-9711","ac"),
  ("Chester","Cunningham","c-chester@google.net","M","(457) 185-6478","elit."),
  ("Odysseus","Jordan","ojordan@outlook.edu","M","(557) 535-7937","nisl."),
  ("Alan","Meadows","m_alan@google.org","M","(461) 552-4701","dictum"),
  ("Garth","Buck","g_buck8785@aol.org","M","(282) 219-7188","non,"),
  ("Yoshio","Barnes","b_yoshio9383@aol.couk","M","1-383-731-1787","magna."),
  ("Daniel","Knowles","knowles.daniel@icloud.ca","M","1-517-481-6833","velit."),
  ("Keegan","Summers","s-keegan2903@google.org","M","1-638-562-4168","arcu.");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Xenos","Hale","x_hale@outlook.org","M","1-264-302-8792","nunc"),
  ("Preston","Morse","mpreston180@hotmail.org","M","1-965-216-2695","Quisque"),
  ("Mason","Bush","bush.mason@protonmail.ca","M","1-777-567-6434","fringilla"),
  ("Edward","Mcclure","emcclure@yahoo.org","M","(481) 409-8157","tempor"),
  ("Peter","Anderson","peter_anderson@hotmail.ca","M","(491) 218-3902","primis"),
  ("Zachary","Marks","marks-zachary@aol.couk","M","(358) 554-2514","conubia"),
  ("Kelly","Morgan","k.morgan5376@aol.couk","M","1-468-893-8552","ridiculus"),
  ("Xanthus","Guerra","gxanthus9342@google.net","M","(537) 634-9235","Morbi"),
  ("Octavius","Leon","octaviusleon5551@yahoo.couk","M","(446) 467-8479","natoque"),
  ("Quentin","Madden","mquentin5889@outlook.org","M","(118) 154-6567","natoque");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Jeremy","Boyer","jboyer@yahoo.edu","M","1-576-734-7855","Nullam"),
  ("Yasir","Romero","y.romero6850@hotmail.org","M","(374) 558-6263","dapibus"),
  ("Ishmael","Howe","ishmael-howe@icloud.couk","M","(266) 472-8758","Ut"),
  ("Abbot","Garza","garza-abbot4449@yahoo.org","M","1-229-338-0620","Proin"),
  ("Quinn","Dalton","q.dalton6198@protonmail.couk","M","1-706-951-8570","lorem"),
  ("Ferdinand","Norman","f_norman7980@protonmail.couk","M","1-419-558-8785","natoque"),
  ("Andrew","Pugh","pughandrew@yahoo.couk","M","1-770-492-8058","ornare"),
  ("Brenden","Castaneda","brenden.castaneda@hotmail.net","M","1-371-747-1098","sit"),
  ("Kenyon","Kidd","kidd_kenyon135@yahoo.net","M","1-873-508-7252","ipsum"),
  ("Burton","Palmer","palmer_burton@protonmail.com","M","(749) 665-8563","nonummy");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Hall","Paul","paul_hall@hotmail.couk","M","(267) 261-2504","ac,"),
  ("Channing","Chase","c-chase@icloud.com","M","1-662-727-8353","Suspendisse"),
  ("Todd","Andrews","tandrews8141@protonmail.couk","M","1-291-179-2543","tincidunt"),
  ("Jelani","Contreras","c-jelani3311@hotmail.edu","M","(726) 204-5180","amet"),
  ("Zephania","Duke","duke.zephania5000@hotmail.net","M","(733) 141-7486","iaculis"),
  ("Kane","Ayers","k.ayers@aol.net","M","(874) 479-2883","consequat"),
  ("Nicholas","Vincent","n.vincent5676@outlook.com","M","(622) 373-7823","Mauris"),
  ("Kennan","Mcfadden","kmcfadden7798@yahoo.edu","M","1-828-198-6855","accumsan"),
  ("Abdul","Alford","a_alford@protonmail.edu","M","(215) 343-4600","malesuada"),
  ("Cairo","Maxwell","maxwell.cairo@aol.net","M","(434) 134-5454","Quisque");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Henry","Holman","holman_henry@google.org","M","1-731-223-2795","rhoncus."),
  ("Allistair","Hebert","hallistair9993@yahoo.ca","M","(660) 261-9294","elementum,"),
  ("Ignatius","Wolf","wolf_ignatius6431@protonmail.net","M","(376) 593-6344","mus."),
  ("Yuli","Mullen","m.yuli179@google.com","M","1-663-324-3363","velit"),
  ("Caesar","Pearson","caesar.pearson@outlook.net","M","1-624-903-6178","tellus"),
  ("Maxwell","Bridges","m_bridges@outlook.com","M","(587) 148-1538","malesuada"),
  ("Elton","Mills","elton.mills6544@icloud.edu","M","(794) 725-5863","leo."),
  ("Wang","Lopez","lwang@hotmail.edu","M","1-166-440-1310","ipsum."),
  ("Randall","O'brien","obrien.randall@protonmail.com","M","(566) 358-9753","dignissim"),
  ("Carson","Andrews","andrews.carson699@hotmail.edu","M","1-833-527-6752","ante");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Nigel","Goodman","nigelgoodman@google.org","M","1-705-313-3575","blandit"),
  ("Clinton","Huffman","clintonhuffman@yahoo.couk","M","(768) 874-1423","libero"),
  ("Wylie","Vang","w-vang4500@hotmail.ca","M","(659) 812-8575","dis"),
  ("Thor","Roberson","roberson_thor8778@hotmail.com","M","1-813-679-6532","tempor"),
  ("Jin","Gill","j_gill@yahoo.ca","M","(358) 592-4878","consequat"),
  ("Baker","Hunter","bhunter@protonmail.com","M","1-715-525-9695","nisl"),
  ("Silas","Schmidt","s.schmidt6810@aol.edu","M","(174) 361-1534","enim."),
  ("Basil","Melendez","melendez-basil2969@yahoo.org","M","(545) 327-0840","eget"),
  ("Lucas","Santos","l-santos@protonmail.net","M","(158) 628-2467","tellus."),
  ("Robert","Shepard","shepard_robert@outlook.net","M","1-743-835-5936","adipiscing");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Paki","Montgomery","montgomery-paki8545@google.couk","M","(786) 372-6171","euismod"),
  ("Jason","Bentley","j-bentley3905@aol.com","M","(662) 425-2251","lacus."),
  ("Grady","Morrow","grady_morrow3125@yahoo.ca","M","(171) 318-0175","non"),
  ("Ryan","Villarreal","ryanvillarreal@icloud.ca","M","1-617-624-7835","Cum"),
  ("Hall","Clements","h-clements6453@protonmail.couk","M","(763) 741-0703","faucibus"),
  ("Micah","Ruiz","ruiz.micah@hotmail.edu","M","(639) 542-7596","Quisque"),
  ("Sean","Ramos","sean_ramos@yahoo.ca","M","(864) 559-4260","eget"),
  ("Francis","Bass","bass-francis690@icloud.net","M","1-405-533-0468","enim"),
  ("Macon","Bennett","bennett-macon@hotmail.net","M","1-430-581-5480","dictum"),
  ("Nissim","Simpson","simpson-nissim608@google.couk","M","(468) 229-5166","luctus");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Elvis","Wood","elviswood@yahoo.edu","M","(294) 898-8573","molestie"),
  ("Camden","Black","b.camden@icloud.edu","M","(447) 466-2389","dui."),
  ("Conan","Bradley","c_bradley@google.couk","M","1-667-226-9496","ornare"),
  ("Owen","Zamora","zowen@outlook.couk","M","1-184-202-7772","placerat"),
  ("Zachery","Buckley","buckleyzachery@icloud.org","M","(165) 818-1256","Morbi"),
  ("Paul","O'brien","p-obrien5853@google.ca","M","1-482-155-9715","velit."),
  ("Warren","Tyson","tysonwarren@hotmail.couk","M","1-835-218-7114","tempus"),
  ("Cole","Brady","cole-brady@icloud.net","M","(828) 687-9877","eu,"),
  ("Kuame","Ramos","r.kuame@icloud.org","M","1-622-201-6836","egestas."),
  ("Wade","Dunlap","dunlapwade@hotmail.couk","M","(477) 765-1218","sociis");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Talon","Powers","t_powers@protonmail.org","M","(918) 365-2664","et"),
  ("Anthony","Lucas","alucas2475@aol.com","M","1-671-866-2885","egestas"),
  ("Simon","Sweet","sweet_simon@aol.edu","M","1-328-974-8343","odio."),
  ("Magee","Dalton","m_dalton@protonmail.org","M","(490) 712-7807","mauris."),
  ("Paul","Rojas","rojas_paul9040@hotmail.couk","M","(924) 471-4266","iaculis"),
  ("Austin","Bond","austinbond@google.edu","M","1-823-722-3377","Vivamus"),
  ("Phillip","Adkins","padkins@icloud.couk","M","1-526-836-4623","vulputate,"),
  ("Jeremy","Knowles","j_knowles885@hotmail.edu","M","(865) 755-5213","risus."),
  ("Solomon","Hays","hays.solomon@aol.net","M","(755) 558-4207","iaculis"),
  ("Alexander","Benton","alexanderbenton1619@hotmail.com","M","1-452-331-7994","pharetra");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Ryan","Banks","rbanks@aol.com","M","1-546-246-2165","velit."),
  ("Theodore","Bass","b-theodore@icloud.edu","M","1-620-532-3158","eu"),
  ("Carlos","Bishop","bishopcarlos@hotmail.org","M","1-418-265-1387","mollis"),
  ("Oscar","Michael","michaeloscar8323@yahoo.net","M","(143) 811-4392","id"),
  ("Travis","Raymond","t-raymond@hotmail.org","M","(635) 558-6634","nibh."),
  ("Brett","Whitley","bwhitley8114@aol.edu","M","(939) 664-7534","facilisi."),
  ("Rigel","Shaw","shaw-rigel5717@yahoo.net","M","1-715-478-1671","nunc."),
  ("Nero","Buck","buck_nero@yahoo.ca","M","1-763-776-3585","neque"),
  ("Cade","Harrell","harrell-cade@icloud.edu","M","(657) 913-7485","tortor."),
  ("Russell","Hughes","h_russell@icloud.couk","M","(132) 976-1757","neque");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Asher","Holt","h_asher5174@outlook.edu","M","(180) 775-4382","Aenean"),
  ("Hyatt","Savage","shyatt2877@aol.edu","M","(278) 583-2468","pede"),
  ("Grant","Bridges","g_bridges8139@icloud.net","M","1-660-855-2257","tortor"),
  ("Orson","Wilder","wilder.orson@protonmail.net","M","1-293-655-4748","sed"),
  ("Moses","Huff","h_moses4684@aol.org","M","(672) 144-6281","arcu."),
  ("Baxter","Hines","hines-baxter@protonmail.couk","M","(527) 455-9444","odio."),
  ("Jerome","Whitney","jwhitney280@google.net","M","(480) 433-2144","sagittis"),
  ("Devin","Schroeder","dschroeder717@outlook.com","M","1-226-204-6687","aliquet."),
  ("Andrew","Moses","moses-andrew@icloud.ca","M","(879) 736-2251","erat"),
  ("Thor","Mack","thor.mack@hotmail.com","M","(416) 234-6905","sit");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Allen","Lang","a.lang@google.edu","M","1-312-346-7085","venenatis"),
  ("Kennan","Sweet","ksweet@google.couk","M","1-423-231-7524","fermentum"),
  ("Barrett","Combs","combs-barrett3235@hotmail.org","M","1-356-710-1567","dui."),
  ("Dexter","Schwartz","schwartz-dexter6446@google.edu","M","(294) 678-9050","dictum"),
  ("Barry","Talley","b_talley9207@aol.net","M","(421) 428-6061","Nunc"),
  ("Jin","Fulton","jin-fulton8018@google.org","M","(511) 472-7872","neque."),
  ("Ray","Lang","r-lang898@yahoo.ca","M","(784) 498-1405","vitae,"),
  ("Amery","Chang","chang-amery@hotmail.org","M","(144) 537-2180","mauris"),
  ("Keefe","Eaton","keefe-eaton@yahoo.com","M","1-321-669-0786","Maecenas"),
  ("Donovan","Glenn","donovan_glenn@protonmail.net","M","(355) 651-8262","vulputate");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Lee","Valencia","l_valencia6350@yahoo.com","M","(272) 873-9690","Integer"),
  ("Steven","Austin","s-austin@yahoo.couk","M","(711) 962-8166","Aliquam"),
  ("August","Riddle","riddle.august@icloud.edu","M","(258) 214-8243","sollicitudin"),
  ("Walker","Hensley","walker_hensley@outlook.org","M","(789) 784-6662","ut,"),
  ("Trevor","Hayden","trevor_hayden3430@yahoo.com","M","1-836-774-9043","erat,"),
  ("Vladimir","Giles","vladimir_giles@outlook.couk","M","(614) 285-7064","mauris"),
  ("Sawyer","Hensley","hensley-sawyer4703@yahoo.ca","M","1-927-483-8552","et"),
  ("Neville","Coleman","coleman.neville2565@hotmail.net","M","1-973-348-4175","laoreet,"),
  ("Armando","Alvarez","a.alvarez@icloud.com","M","(568) 818-7281","Sed"),
  ("Stewart","Hendricks","hendricks-stewart4804@hotmail.couk","M","1-578-537-4516","accumsan");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Philip","Foreman","f.philip8129@google.net","M","(784) 489-3720","ligula."),
  ("Rahim","Hayes","hayesrahim@protonmail.couk","M","(673) 315-4436","Sed"),
  ("Caldwell","Weaver","weaver_caldwell4302@aol.ca","M","1-851-850-3274","porta"),
  ("Axel","Bryan","baxel@google.net","M","1-702-671-8584","lacus."),
  ("Holmes","Hurley","hurley_holmes@google.ca","M","1-175-369-3541","convallis"),
  ("Beck","Kidd","beckkidd@outlook.couk","M","(440) 606-4734","Nullam"),
  ("Lawrence","Pate","lawrencepate5560@protonmail.org","M","(849) 815-4532","et"),
  ("Akeem","Hoffman","a_hoffman8679@hotmail.ca","M","(574) 477-1392","sapien"),
  ("Kasper","Travis","ktravis@protonmail.couk","M","1-494-472-2735","felis"),
  ("Igor","Stuart","igor.stuart@hotmail.org","M","1-226-284-4331","pede,");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Vernon","Snow","v.snow3988@icloud.net","M","1-552-553-5825","nec,"),
  ("Hasad","Blevins","h_blevins1746@google.net","M","(630) 131-0612","scelerisque"),
  ("Linus","Pate","l.pate@outlook.com","M","(511) 588-1363","hendrerit."),
  ("Clayton","Nielsen","n-clayton3899@hotmail.edu","M","1-360-684-1972","ipsum."),
  ("Merritt","Christensen","merritt_christensen2977@hotmail.com","M","1-981-569-5655","eu"),
  ("Beck","Waters","beck-waters5105@hotmail.com","M","1-342-758-3830","cursus"),
  ("Maxwell","Patel","mpatel9356@yahoo.edu","M","1-519-590-3348","vulputate"),
  ("Hedley","Hodge","hodge-hedley5480@hotmail.net","M","1-375-841-3756","ornare,"),
  ("Davis","Merrill","dmerrill@icloud.edu","M","1-341-481-5161","ligula."),
  ("Myles","Crosby","myles.crosby@outlook.org","M","(250) 586-6176","volutpat");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Nathaniel","Hughes","hughesnathaniel@protonmail.couk","M","(986) 203-4139","lorem"),
  ("Neil","William","nwilliam5539@outlook.edu","M","(266) 527-3826","pellentesque,"),
  ("Drew","Ford","forddrew@outlook.ca","M","(532) 625-7492","sem."),
  ("Rashad","Chang","rashadchang@hotmail.com","M","(961) 232-4134","eu"),
  ("Samuel","Perry","s.perry2255@aol.couk","M","(786) 911-5686","nibh"),
  ("Jermaine","Riggs","j-riggs@outlook.com","M","(448) 665-4848","nulla."),
  ("Roth","Cruz","cruz-roth6651@outlook.ca","M","1-586-789-5780","mauris"),
  ("Jordan","Mcgee","mcgee.jordan@icloud.couk","M","1-417-514-1876","pretium"),
  ("Moses","Benton","m.benton@yahoo.edu","M","(767) 741-5191","felis"),
  ("Nolan","Olsen","o-nolan8846@hotmail.com","M","1-355-434-1840","Integer");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Holmes","Head","head_holmes@hotmail.org","M","(578) 873-6095","pharetra"),
  ("Jesse","Everett","jeverett@google.couk","M","(311) 715-8540","mi,"),
  ("Alvin","Haynes","haynes_alvin1048@yahoo.edu","M","(923) 439-8341","nunc"),
  ("Yasir","Lester","y_lester@yahoo.org","M","(184) 816-4882","vulputate"),
  ("Matthew","Fisher","matthew.fisher@icloud.edu","M","1-152-684-3832","nunc."),
  ("Colin","Dennis","colin-dennis@protonmail.couk","M","(244) 275-6207","Maecenas"),
  ("Kennan","Mcknight","mcknightkennan1175@aol.org","M","1-705-853-5549","dui,"),
  ("Damian","Warner","warner_damian2467@yahoo.org","M","1-854-523-3616","nec,"),
  ("Xander","Richardson","xander_richardson6653@google.ca","M","1-267-616-3467","ut"),
  ("Ralph","Tanner","rtanner7541@yahoo.net","M","(550) 144-4234","sit");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Nolan","Stokes","stokes-nolan@hotmail.ca","M","1-384-928-8414","scelerisque"),
  ("Leonard","Hatfield","leonardhatfield3439@hotmail.com","M","(468) 746-4226","semper,"),
  ("Ciaran","Buck","buck.ciaran5523@hotmail.edu","M","(880) 685-9113","at"),
  ("Keaton","Hebert","hebert_keaton7383@yahoo.net","M","1-282-153-3162","non"),
  ("Gannon","Pennington","pennington-gannon5905@outlook.ca","M","1-232-821-5084","bibendum."),
  ("Herman","Whitney","h-whitney@yahoo.com","M","(296) 307-3246","sem,"),
  ("Asher","Lambert","alambert5548@protonmail.ca","M","(865) 954-9771","nec,"),
  ("Theodore","Peterson","p_theodore@yahoo.net","M","1-407-876-1226","nec"),
  ("Barry","Calderon","bcalderon1932@aol.org","M","(421) 664-5412","vulputate,"),
  ("Akeem","Long","long-akeem9536@icloud.couk","M","1-243-283-0267","elit,");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Dominic","Browning","d-browning5165@hotmail.net","M","1-639-418-4865","faucibus"),
  ("August","Gallagher","gallagher_august@hotmail.net","M","1-372-391-7413","ut"),
  ("Macon","Allen","maconallen2305@outlook.ca","M","(316) 681-8245","ultrices"),
  ("Burton","Chaney","c_burton9359@hotmail.net","M","(674) 821-4504","ridiculus"),
  ("Zeph","O'Neill","oneill_zeph9110@aol.net","M","(783) 631-4897","augue"),
  ("Gavin","Ward","gward@hotmail.ca","M","1-794-341-9652","sodales"),
  ("Armand","Barr","barr-armand@icloud.edu","M","(635) 517-1544","dignissim"),
  ("Allistair","Stevens","stevens-allistair7723@aol.org","M","1-214-586-6285","primis"),
  ("Giacomo","Franks","giacomo-franks4901@icloud.ca","M","(302) 588-5483","risus,"),
  ("Dean","Hardy","dhardy@yahoo.edu","M","(331) 961-4538","Aliquam");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Ivor","Lindsey","l_ivor@google.ca","M","(764) 887-1647","sociosqu"),
  ("Beau","Shepard","bshepard@yahoo.net","M","1-653-993-7315","purus"),
  ("Lamar","Garrison","garrisonlamar9261@icloud.ca","M","1-221-552-4283","Sed"),
  ("Duncan","Wise","dwise4873@google.ca","M","1-774-747-4558","auctor"),
  ("Jakeem","Dotson","jakeem.dotson@protonmail.org","M","(573) 215-5281","lectus"),
  ("Lucas","Blackwell","lucasblackwell@outlook.com","M","1-543-722-9512","magnis"),
  ("Benedict","Acevedo","acevedobenedict@aol.net","M","1-714-236-1675","eu"),
  ("Kuame","Mcfarland","m.kuame8983@hotmail.org","M","(433) 231-5326","Nam"),
  ("Ian","Wyatt","ian.wyatt7461@aol.com","M","(748) 653-6652","cursus,"),
  ("Phelan","Holt","h_phelan@hotmail.ca","M","1-839-344-2855","erat");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Reuben","Britt","britt.reuben9308@google.ca","M","(749) 216-6553","bibendum"),
  ("Hoyt","Mccoy","m.hoyt607@protonmail.net","M","1-615-158-6442","non"),
  ("Marsden","Weber","marsden_weber2597@google.org","M","1-751-270-0420","mollis"),
  ("Steel","Gibbs","steelgibbs9906@icloud.com","M","(447) 664-2348","Integer"),
  ("Maxwell","Hurley","hurley_maxwell@protonmail.com","M","(519) 963-5727","fringilla"),
  ("Nasim","Tate","nasim_tate@icloud.ca","M","(487) 806-6762","ipsum"),
  ("Timon","Tillman","tillman_timon@hotmail.net","M","1-849-758-4252","lacus."),
  ("Dean","Griffin","d.griffin6906@hotmail.edu","M","1-667-267-9713","fringilla"),
  ("Randall","Emerson","emerson-randall7102@outlook.couk","M","1-333-487-3328","parturient"),
  ("Mufutau","Acevedo","m.acevedo@protonmail.net","M","1-377-437-5664","lacus.");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Kyle","Chandler","c.kyle1246@icloud.edu","M","1-462-717-8696","metus."),
  ("Jason","Green","green.jason@yahoo.couk","M","1-225-846-3326","nisl."),
  ("Louis","Davis","l_davis5642@hotmail.org","M","1-887-379-8219","pede"),
  ("Judah","Bonner","jbonner@icloud.com","M","(886) 452-3343","elit"),
  ("Curran","Mercer","mcurran3586@protonmail.net","M","(867) 546-9351","odio"),
  ("Jacob","Cabrera","jacob_cabrera@google.com","M","(212) 452-7475","laoreet"),
  ("Nash","Torres","ntorres7943@protonmail.couk","M","1-765-956-6023","metus."),
  ("Seth","Norris","sethnorris9428@google.com","M","1-781-834-7162","Maecenas"),
  ("Jameson","Goodman","gjameson5075@icloud.com","M","1-173-752-6552","augue"),
  ("Ian","Gamble","i.gamble@outlook.edu","M","(406) 867-2397","Mauris");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Hoyt","Maxwell","maxwell.hoyt@google.edu","M","1-456-187-4315","amet"),
  ("Dieter","Mann","mann.dieter5521@google.ca","M","(244) 570-7171","nec"),
  ("Abel","Wallace","a.wallace@protonmail.net","M","(832) 762-1281","ac,"),
  ("Xenos","Gregory","x.gregory9361@hotmail.edu","M","(466) 633-7132","arcu."),
  ("Erasmus","Webster","e-webster@aol.couk","M","(631) 288-4332","consequat"),
  ("Tucker","Livingston","t.livingston@yahoo.couk","M","(878) 514-0824","luctus."),
  ("Darius","Hahn","darius-hahn@protonmail.com","M","(963) 352-6226","fames"),
  ("Davis","Marks","dmarks@hotmail.com","M","1-142-255-3157","vestibulum"),
  ("Demetrius","Ramsey","ramseydemetrius@yahoo.edu","M","1-392-691-7338","vitae"),
  ("Russell","Booth","b_russell4030@aol.ca","M","1-777-643-7121","dignissim");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Asher","Garrison","agarrison8364@aol.com","M","1-204-676-7322","sit"),
  ("Burke","Nixon","b-nixon@icloud.com","M","(314) 882-4822","scelerisque"),
  ("Lyle","Mcintyre","mcintyrelyle@google.net","M","1-555-376-0383","erat,"),
  ("Ignatius","Moreno","morenoignatius9496@google.com","M","(671) 684-6495","fringilla"),
  ("Dante","Franklin","franklindante@icloud.net","M","1-530-737-6348","tellus,"),
  ("Craig","Kennedy","c_kennedy6872@yahoo.ca","M","1-361-722-0337","ipsum"),
  ("Levi","Flynn","lflynn@protonmail.org","M","(575) 921-7044","nulla"),
  ("Tanner","Sharpe","sharpe_tanner@outlook.couk","M","1-625-622-1265","molestie"),
  ("Holmes","Justice","h_justice@outlook.couk","M","(951) 864-8157","non"),
  ("Alfonso","Rosario","rosario.alfonso@icloud.ca","M","(369) 234-0816","ligula.");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Brandon","Glenn","glennbrandon2459@aol.org","M","(301) 949-4163","diam."),
  ("Jeremy","Becker","jbecker1008@aol.com","M","(706) 670-1657","ut"),
  ("Wallace","Price","p_wallace1158@yahoo.com","M","1-237-138-7244","Nullam"),
  ("Amal","Gibson","gibson-amal@google.edu","M","(555) 291-3394","eleifend."),
  ("Ulric","Townsend","t-ulric@outlook.edu","M","(212) 741-3114","massa"),
  ("Brennan","Jenkins","b_jenkins@aol.couk","M","(146) 783-7722","quam,"),
  ("John","Mullins","mullins-john3496@icloud.net","M","1-846-368-6611","pellentesque."),
  ("Brett","Dotson","dotson-brett@yahoo.couk","M","1-741-370-5502","nascetur"),
  ("Seth","Glover","sethglover3467@yahoo.couk","M","(817) 858-6225","tortor,"),
  ("Baker","Barrera","bbaker@icloud.edu","M","(564) 739-4437","torquent");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Adam","Gaines","gaines.adam@google.ca","M","(680) 272-3228","dictum"),
  ("Xenos","Vinson","vinson-xenos@icloud.com","M","1-215-740-7042","mauris"),
  ("Colton","Orr","orr_colton3979@hotmail.edu","M","(995) 583-8653","enim."),
  ("Jason","Ford","jford@hotmail.org","M","(580) 451-9689","tempor"),
  ("Jackson","Bates","batesjackson9@aol.net","M","1-986-781-5541","tortor"),
  ("Dane","Lester","danelester@protonmail.ca","M","1-667-839-8597","ultrices"),
  ("Owen","Peterson","powen724@hotmail.org","M","(386) 348-8218","non,"),
  ("Devin","Ortiz","o_devin@google.com","M","1-852-624-7564","a,"),
  ("Edan","Castillo","e-castillo3076@aol.ca","M","1-238-135-7444","lorem."),
  ("Herrod","O'brien","h_obrien@yahoo.edu","M","1-246-133-9314","lorem,");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Cairo","Macias","macias-cairo5004@google.couk","M","1-212-412-2326","eros"),
  ("Demetrius","Hodge","hodge-demetrius800@protonmail.net","M","1-822-584-5691","nisi"),
  ("Thor","Morton","thor.morton@icloud.ca","M","(342) 231-3436","morbi"),
  ("Judah","Hooper","j-hooper@yahoo.org","M","(534) 228-7665","gravida"),
  ("Hammett","Delacruz","hammett-delacruz3302@yahoo.net","M","1-969-215-4155","Donec"),
  ("Ross","Dalton","ross.dalton2267@icloud.org","M","(932) 674-4013","justo"),
  ("Amos","Atkinson","atkinson.amos@hotmail.net","M","(626) 172-2551","faucibus"),
  ("Hedley","Lynch","hedley_lynch@protonmail.com","M","1-726-101-8324","aliquam"),
  ("Grady","Sutton","g-sutton@outlook.net","M","(356) 810-4535","ac"),
  ("Dustin","Garcia","dgarcia@hotmail.couk","M","(744) 793-0525","ornare,");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Hu","Myers","h.myers@protonmail.couk","M","1-403-946-8228","In"),
  ("Armando","Schneider","s_armando5326@outlook.edu","M","1-124-832-7947","massa."),
  ("Adam","Hyde","hadam4501@yahoo.ca","M","1-834-459-3463","Nulla"),
  ("Asher","Ferrell","ferrell-asher@icloud.couk","M","1-178-688-7471","ornare."),
  ("Stone","Potter","s_potter1499@outlook.org","M","(534) 644-7767","erat."),
  ("Christopher","Bryant","bryant_christopher9785@hotmail.net","M","1-664-691-4659","ante."),
  ("Macaulay","Barlow","b.macaulay9419@aol.edu","M","1-507-777-1772","tristique"),
  ("Nathaniel","Wolfe","n.wolfe@hotmail.net","M","(866) 876-4529","pellentesque"),
  ("Hedley","Duncan","hedley-duncan9937@protonmail.couk","M","1-742-354-8282","adipiscing"),
  ("Craig","Drake","c_drake122@yahoo.net","M","1-521-879-3614","vel");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Xanthus","Atkinson","x_atkinson@aol.ca","M","1-838-784-1504","massa."),
  ("Tanner","Weiss","t-weiss7836@icloud.couk","M","(322) 352-8585","eget"),
  ("Geoffrey","Hancock","geoffrey-hancock@hotmail.edu","M","(337) 968-7664","tincidunt"),
  ("Oren","Sweet","s-oren9909@google.net","M","(317) 116-3347","quam."),
  ("Ignatius","Conley","conley.ignatius3285@hotmail.com","M","(646) 704-6152","dolor"),
  ("Herrod","Bruce","h.bruce8306@yahoo.ca","M","1-882-678-5637","elit,"),
  ("Uriah","Quinn","quriah9620@icloud.edu","M","(680) 681-6143","molestie"),
  ("Wade","Barron","wbarron7885@aol.ca","M","(427) 575-9251","Nunc"),
  ("Alden","Collier","a_collier@outlook.edu","M","1-816-781-8891","hendrerit."),
  ("Kato","Guthrie","g.kato@aol.net","M","1-952-446-2532","dui.");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Jakeem","Guerra","jakeem_guerra2431@outlook.couk","M","(258) 397-4495","fringilla"),
  ("Abel","Bryant","a_bryant@hotmail.couk","M","(936) 132-0146","Ut"),
  ("Todd","Morton","t-morton3279@outlook.edu","M","(291) 517-2084","nisi."),
  ("Lawrence","King","lking@aol.net","M","(894) 324-1367","Nam"),
  ("Deacon","Griffin","d-griffin8495@outlook.com","M","(548) 278-1681","eu"),
  ("Charles","Pickett","charlespickett@google.com","M","1-522-861-1361","Sed"),
  ("Ahmed","Forbes","a_forbes7320@protonmail.org","M","1-171-536-7016","dolor."),
  ("Amal","Browning","browning-amal@icloud.ca","M","(539) 238-6664","augue."),
  ("Addison","Fox","addison.fox@outlook.edu","M","(673) 883-8283","dignissim"),
  ("Gil","Garrett","garrettgil2302@yahoo.org","M","(637) 335-8213","nisl.");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Carson","Cline","cline-carson@protonmail.ca","M","1-881-318-5766","Vivamus"),
  ("Baxter","Barton","b_baxter@icloud.couk","M","(684) 762-0463","arcu."),
  ("Deacon","Gross","d.gross@aol.ca","M","1-268-142-3293","Integer"),
  ("Quinn","Carr","q_carr8598@outlook.couk","M","(482) 727-3623","amet"),
  ("Quentin","Roberts","robertsquentin@google.net","M","1-247-874-8143","magnis"),
  ("Logan","Mcknight","l_mcknight2638@hotmail.org","M","(786) 170-6411","dis"),
  ("Joshua","Battle","battle.joshua4058@aol.net","M","1-591-332-7786","ornare"),
  ("Rogan","Arnold","r-arnold@aol.net","M","1-535-496-4535","sociis"),
  ("Jonah","Roberson","j.roberson@protonmail.couk","M","1-627-276-9196","Etiam"),
  ("Richard","Curtis","curtis-richard@yahoo.edu","M","1-650-445-0099","habitant");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Brent","Guthrie","guthrie-brent9361@aol.edu","M","(482) 831-6523","porttitor"),
  ("Beau","Webster","b_webster3774@aol.net","M","1-625-162-5200","pretium"),
  ("Declan","Hull","d-hull@yahoo.net","M","(874) 622-0809","eros"),
  ("Jermaine","Crane","cranejermaine@icloud.couk","M","1-472-537-4574","vel"),
  ("Harlan","Cole","h.cole@icloud.org","M","1-385-741-2676","Curabitur"),
  ("Emery","Yang","yangemery@hotmail.couk","M","1-815-960-6618","Integer"),
  ("Cadman","Barron","c-barron@icloud.org","M","1-285-503-9457","rhoncus"),
  ("Wing","White","wwing@aol.couk","M","(248) 623-5787","non"),
  ("Carter","Figueroa","carter.figueroa8527@google.couk","M","1-671-639-0346","nec"),
  ("Xanthus","Porter","p_xanthus5357@icloud.ca","M","(583) 415-9374","lorem,");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Cadman","Soto","c.soto@yahoo.couk","M","1-158-317-8544","nunc."),
  ("Thor","Cantrell","t-cantrell4675@aol.com","M","1-654-618-2451","erat"),
  ("Robert","Mckenzie","mrobert1413@aol.net","M","(561) 741-5745","enim"),
  ("Palmer","Vang","p.vang1009@protonmail.com","M","(434) 215-0676","Nam"),
  ("Quinlan","Glenn","q.glenn6758@google.net","M","1-481-812-9612","nunc"),
  ("Zachary","Colon","c-zachary986@google.org","M","(964) 596-3547","sed"),
  ("Merrill","Bennett","b.merrill5005@google.com","M","(246) 694-8273","lectus"),
  ("Dennis","Wilcox","w_dennis9514@protonmail.ca","M","1-755-695-6875","tellus,"),
  ("Hamish","Sanders","sanders-hamish942@protonmail.org","M","(683) 947-4631","congue"),
  ("Wing","Saunders","w.saunders4662@google.net","M","1-311-444-3441","et");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Gannon","Stephens","s.gannon@outlook.com","M","1-584-758-9624","senectus"),
  ("Finn","Bennett","bennett_finn@hotmail.edu","M","1-897-387-7886","lobortis,"),
  ("Drew","Johnson","drew-johnson@yahoo.org","M","(552) 543-9732","quis"),
  ("Sawyer","Guzman","sawyer.guzman1705@icloud.net","M","1-588-962-0261","vel"),
  ("Prescott","Cleveland","cleveland.prescott@outlook.couk","M","1-684-312-0728","Duis"),
  ("Emerson","Collier","c-emerson2477@google.com","M","1-222-757-0326","ipsum"),
  ("Flynn","Bean","bean_flynn358@google.com","M","1-517-122-9437","magna"),
  ("Cain","Briggs","b.cain@outlook.com","M","1-627-256-1101","non"),
  ("Felix","Powell","felixpowell9485@aol.org","M","(444) 438-6872","tellus."),
  ("Valentine","Rodriguez","rodriguez.valentine@protonmail.couk","M","(873) 642-4812","tempus");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Axel","Tran","t_axel5626@hotmail.org","M","1-438-808-8081","Quisque"),
  ("Alden","Rosales","a_rosales6287@icloud.net","M","(686) 248-1030","placerat,"),
  ("Murphy","Buchanan","b_murphy@google.com","M","1-236-976-2549","odio"),
  ("Arthur","Rowland","rowland_arthur@google.com","M","(703) 417-2265","Nullam"),
  ("Phillip","Hobbs","p.hobbs5722@icloud.couk","M","1-417-315-9075","Donec"),
  ("Vaughan","Meyers","m-vaughan4482@yahoo.couk","M","1-759-226-8388","Vestibulum"),
  ("Fletcher","Kirk","f.kirk@google.com","M","1-534-425-9304","eget"),
  ("Adrian","May","may-adrian@google.net","M","(474) 445-0718","natoque"),
  ("Duncan","Craft","craftduncan@yahoo.ca","M","(553) 646-1865","facilisis"),
  ("Quinn","Bruce","bquinn@hotmail.edu","M","1-242-412-9131","velit.");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Ferris","Mays","mays.ferris@yahoo.org","M","(537) 577-1521","velit."),
  ("Damian","Day","d_day7537@yahoo.couk","M","(181) 428-7410","lobortis"),
  ("Quentin","Mason","q_mason7467@google.edu","M","1-715-242-5115","tincidunt"),
  ("Branden","Benson","branden.benson6783@icloud.org","M","1-733-774-2715","non"),
  ("Abbot","Brooks","b_abbot9429@protonmail.com","M","1-378-582-5298","Donec"),
  ("Gary","Leach","garyleach@hotmail.ca","M","1-945-453-9923","turpis"),
  ("Calvin","Craft","c.calvin8807@yahoo.net","M","(509) 913-2049","sit"),
  ("Dante","Espinoza","d-espinoza4088@protonmail.com","M","(944) 458-4682","luctus"),
  ("Xenos","Nelson","nelson-xenos@icloud.org","M","1-666-139-8767","non"),
  ("Asher","Morales","asher-morales2861@hotmail.ca","M","(193) 676-0468","pharetra.");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Edan","Lawson","e_lawson537@aol.org","M","(871) 517-5384","eu"),
  ("Timothy","Vargas","t.vargas@aol.couk","M","1-323-686-6547","sapien."),
  ("Thane","Clemons","t-clemons@outlook.org","M","(572) 817-9461","Mauris"),
  ("Elvis","Salas","salas.elvis1070@google.org","M","(567) 121-5132","urna."),
  ("Gregory","Rhodes","r_gregory328@icloud.ca","M","1-169-843-6411","in"),
  ("Steel","Hooper","hsteel@hotmail.org","M","1-803-687-5118","ut,"),
  ("Allen","Avery","a_avery8497@yahoo.net","M","(603) 314-2335","facilisis."),
  ("Garrett","Kane","g-kane5967@yahoo.net","M","1-313-723-2177","lobortis"),
  ("Victor","May","m.victor430@hotmail.net","M","(726) 264-0668","facilisis"),
  ("Linus","Mcgowan","l-mcgowan3165@google.couk","M","(415) 878-3236","eleifend,");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Lamar","Phillips","lamar_phillips@aol.org","M","1-775-204-3157","dolor"),
  ("Yardley","Hodge","h_yardley@yahoo.com","M","(231) 983-8167","feugiat."),
  ("Colin","Horn","c-horn8128@google.edu","M","(147) 388-3837","eget,"),
  ("Elton","Davidson","e_davidson226@hotmail.net","M","(792) 104-2016","risus."),
  ("Eaton","Bowman","e.bowman7035@hotmail.com","M","(203) 740-6884","arcu."),
  ("Keane","Roberson","roberson_keane7863@hotmail.couk","M","1-813-913-4913","libero"),
  ("Thor","Barker","thor.barker@google.edu","M","1-193-714-3115","eu,"),
  ("Bradley","Willis","b.willis@hotmail.org","M","(528) 851-7028","cubilia"),
  ("Akeem","Berg","a.berg7843@yahoo.com","M","1-426-771-0529","augue"),
  ("Cedric","Mendez","mendez_cedric2702@icloud.org","M","(772) 814-8199","egestas");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Lucas","Cox","cox-lucas9824@protonmail.couk","M","1-255-870-6648","Lorem"),
  ("Andrew","Graves","graves_andrew893@hotmail.ca","M","(261) 398-8698","tincidunt"),
  ("Berk","Robinson","berk_robinson4426@google.ca","M","1-721-390-1176","euismod"),
  ("Reese","Hudson","r-hudson@icloud.edu","M","(438) 518-7274","nunc"),
  ("Kyle","Lyons","kyle-lyons6529@yahoo.ca","M","1-343-413-1983","euismod"),
  ("Noble","Oliver","n_oliver2862@protonmail.edu","M","(262) 736-4026","tristique"),
  ("Price","Bond","bond-price@yahoo.couk","M","(743) 708-4783","tristique"),
  ("Valentine","Buckner","b.valentine4360@aol.edu","M","(553) 836-6624","malesuada"),
  ("Wallace","Sharp","sharpwallace7099@aol.org","M","(918) 376-7595","interdum"),
  ("Daquan","Vance","vance_daquan4216@yahoo.couk","M","1-745-114-7426","metus");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Peter","Hensley","hensleypeter@yahoo.couk","M","(478) 648-4777","diam."),
  ("Rudyard","Reid","reid-rudyard2386@google.com","M","(643) 427-8858","quis,"),
  ("Roth","Bishop","rbishop@yahoo.couk","M","(769) 631-8575","adipiscing"),
  ("Lawrence","Harvey","h_lawrence@aol.com","M","(701) 558-2300","lorem"),
  ("Raymond","Wilder","wilder-raymond@hotmail.net","M","1-281-274-5024","ullamcorper,"),
  ("Thaddeus","Roy","thaddeus_roy7657@yahoo.com","M","1-394-497-1723","diam."),
  ("Adrian","Wong","wong_adrian@google.ca","M","1-413-823-2612","Vivamus"),
  ("Steven","Pickett","spickett4296@icloud.org","M","(858) 246-1023","cursus"),
  ("Giacomo","Solomon","g_solomon@google.edu","M","1-442-509-6625","convallis"),
  ("Macon","Patrick","maconpatrick4941@aol.org","M","(227) 235-4852","tortor");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Lyle","Mcintyre","mcintyre.lyle5501@icloud.net","M","1-472-712-1863","leo,"),
  ("Tanner","Scott","tanner.scott@yahoo.couk","M","1-688-240-2524","Nulla"),
  ("Edan","Hutchinson","hutchinson-edan1233@yahoo.com","M","1-362-526-8145","vel"),
  ("Neil","Torres","n-torres@icloud.org","M","(372) 567-3288","eget"),
  ("Leroy","Pratt","lpratt2027@protonmail.ca","M","(536) 873-4107","rhoncus."),
  ("Nehru","James","n_james@protonmail.com","M","(886) 226-1263","Lorem"),
  ("Victor","Small","small_victor4105@hotmail.com","M","(577) 272-5419","vitae"),
  ("Silas","Burnett","s.burnett@hotmail.net","M","(358) 629-5866","Maecenas"),
  ("Griffin","Mckinney","mckinneygriffin@google.com","M","(547) 445-6545","Integer"),
  ("Beau","Hoffman","beau-hoffman8699@hotmail.edu","M","(558) 688-1552","aliquet");
INSERT INTO Person (firstName,lastName,email,gender,phoneNumber,password)
VALUES
  ("Erich","Hess","ehess@outlook.edu","M","(133) 202-5228","non,"),
  ("Kato","Macdonald","k.macdonald107@aol.edu","M","1-335-497-9637","vulputate"),
  ("Felix","Bryan","bryan-felix1578@google.net","M","(982) 355-2690","odio"),
  ("Robert","Roberts","rroberts9836@hotmail.net","M","(227) 272-1515","tellus,"),
  ("Tucker","Robinson","r.tucker@protonmail.net","M","1-663-186-9471","egestas"),
  ("Dante","Acosta","dacosta@icloud.org","M","1-406-678-3822","ac"),
  ("Brent","Vazquez","vazquez_brent@yahoo.couk","M","(373) 576-7720","ut"),
  ("Leroy","Boone","l.boone@aol.edu","M","(163) 221-1028","ipsum"),
  ("Allistair","Pugh","a-pugh6490@yahoo.couk","M","(333) 364-2726","feugiat"),
  ("Garrison","Donaldson","g-donaldson@protonmail.com","M","(424) 378-3037","Curabitur");
