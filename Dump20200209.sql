-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: assign
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_liker_id` int(11) NOT NULL,
  `fk_listings_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_liker_id` (`fk_liker_id`),
  KEY `fk_listings_id` (`fk_listings_id`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`fk_liker_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`fk_listings_id`) REFERENCES `listings` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=308 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (74,3,4),(78,3,3),(133,5,3),(134,5,1),(201,6,4),(270,7,6),(271,7,2),(272,7,3),(274,7,1),(280,7,4),(291,3,3),(295,3,2),(296,3,7),(297,3,1),(298,10,4),(299,10,3),(304,8,5),(307,8,8);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listings`
--

DROP TABLE IF EXISTS `listings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `price` int(11) DEFAULT NULL,
  `fk_user_id` int(11) DEFAULT NULL,
  `TOC` datetime DEFAULT NULL,
  `photo` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_id` (`fk_user_id`),
  KEY `id` (`id`),
  CONSTRAINT `listings_ibfk_1` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listings`
--

LOCK TABLES `listings` WRITE;
/*!40000 ALTER TABLE `listings` DISABLE KEYS */;
INSERT INTO `listings` VALUES (1,'testing','masks',123456789,3,'2020-01-31 10:08:42','1580436521909.jpg'),(2,'Looking for mah boi','have u seen mah asdasdasdasdsadsadsadsadsadsadsadsadsadsa',123456,3,'2020-02-01 13:02:35','1580533355065.jpg'),(3,'Looking for mah boihave u seen mah boihave u seen mah boihave u seen mah boi','have u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boihave u seen mah boi',12,3,'2020-02-01 13:02:39','1580533358855.jpg'),(4,'No kidding','My pee pee is very small oooo',124,7,'2020-01-31 10:08:42','1581093518353.jpg'),(5,'ONE MORE','NOT FOR SALE',1234,6,'2020-01-31 10:08:42','a.jpg'),(6,'My fellow Americans.','My fellow Americans. A man has fallen into the river of Lego City. Lego City. A fantastic man. ',123,7,'2020-02-07 14:33:06','1581057185637.jpg'),(7,'12','12',12,7,'2020-02-07 16:06:50','1581062810048.jpg'),(8,'HUNTING THE BARBARIANS','Shut up weeb. Within traditionally made comparisons, if a conflict were to accur between feudal Japan and Medievla Europe, the longsword would be advantegous with its unifrom strenght, ability to take a beating, nimble control (as it is not as top heavy as some swords, cough cough katana), ability to thrust effective therefore not being completely useful against proper armour and chainmail specifically (unlike some cutting specialised swords cough cough katana), the fact that it has a crossguard (unlike some swords that only have a little oval thing to keep the hand from sliding on the blade cough cough katana) and the fact that it has a pommel (unlike some swords that just don\'t cough cough katana) it is also not completely useless against plate armour (unlike some swords cough cough katana) because of the technique called mordhau (or murder stroke). So in a real conflict (also has more sofisticated techniques revolved around it and lower skill ground but higher skill cielling too, because it\'s a flexible blade unlike some swords that won\'t flex and if they ever take enough force to be flexed it\'ll stay bent that way cough cough katana, it also requires more perfect edge ellignment because of its flexibility) also the longsword is longer, (unlike the katana which is as long as a single handed european sword) therefore having a reach advantage and also the longsword is made out of european high carbon steel, which is purified by liquifyng, (and is superior to any steel that requires folding because folding is a technique to squeze out non-metallic impurities, but also reduces carbon content, and removes far less impurities than liquifying so it\'s also made out of slightly more durable and better steel as well) having an army that\'s equipped with longswords is advantageous (to having one equipped with katanas.)\n(also the reason that european armed martial arts were more sofisticated was because the majority of people in japan werent allowed to bear arms, so they developped techniques for weapons made out of farming tools, and also unarmed martial arts the most. sword techniques were limited to a few soldiers and samurais and the like, so there was no way they would be able to find as much exploits and techniques as europe, where in a lot of places it was manditory to have weapons and armour to protect the settlement if needed)\n\n\nAlso traditionally made katanas cant break other swords even given every condition to be able to do so, with the blade literally completely stable and unable to move or flex or absorb the shock\n',23,8,'2020-02-08 00:45:51','1581093951201.jpg'),(9,'123211','According to all known laws\nof aviation,\n\n  \nthere is no way a bee\nshould be able to fly.\n\n  \nIts wings are too small to get\nits fat little body off the ground.\n\n  \nThe bee, of course, flies anyway\n\n  \nbecause bees don\'t care\nwhat humans think is impossible.\n\n  \nYellow, black. Yellow, black.\nYellow, black. Yellow, black.\n\n  \nOoh, black and yellow!\nLet\'s shake it up a little.\n\n  \nBarry! Breakfast is ready!\n\n  \nOoming!\n\n  \nHang on a second.\n\n  \nHello?\n\n  \n- Barry?\n- Adam?\n\n  \n- Oan you believe this is happening?\n- I can\'t. I\'ll pick you up.\n\n  \nLooking sharp.\n\n  \nUse the stairs. Your father\npaid good money for those.\n\n  \nSorry. I\'m excited.\n\n  \nHere\'s the graduate.\nWe\'re very proud of you, son.\n\n  \nA perfect report card, all B\'s.\n\n  \nVery proud.\n\n  \nMa! I got a thing going here.\n\n  \n- You got lint on your fuzz.\n- Ow! That\'s me!\n\n  \n- Wave to us! We\'ll be in row 118,000.\n- Bye!\n\n  \nBarry, I told you,\nstop flying in the house!\n\n  \n- Hey, Adam.\n- Hey, Barry.\n\n  \n- Is that fuzz gel?\n- A little. Special day, graduation.\n\n  \nNever thought I\'d make it.\n\n  \nThree days grade school,\nthree days high school.\n\n  \nThose were awkward.\n\n  \nThree days college. I\'m glad I took\na day and hitchhiked around the hive.\n\n  \nYou did come back different.\n\n  \n- Hi, Barry.\n- Artie, growing a mustache? Looks good.\n\n  \n- Hear about Frankie?\n- Yeah.\n\n  \n- You going to the funeral?\n- No, I\'m not going.\n\n  \nEverybody knows,\nsting someone, you die.\n\n  \nDon\'t waste it on a squirrel.\nSuch a hothead.\n\n  \nI guess he could have\njust gotten out of the way.\n\n  \nI love this incorporating\nan amusement park into our day.\n\n  \nThat\'s why we don\'t need vacations.\n\n  \nBoy, quite a bit of pomp...\nunder the circumstances.\n\n  \n- Well, Adam, today we are men.\n- We are!\n\n  \n- Bee-men.\n- Amen!\n\n  \nHallelujah!\n\n  \nStudents, faculty, distinguished bees,\n\n  \nplease welcome Dean Buzzwell.\n\n  \nWelcome, New Hive Oity\ngraduating class of...\n\n  \n...9:15.\n\n  \nThat concludes our ceremonies.\n\n  \nAnd begins your career\nat Honex Industries!\n\n  \nWill we pick ourjob today?\n\n  \nI heard it\'s just orientation.\n\n  \nHeads up! Here we go.\n\n  \nKeep your hands and antennas\ninside the tram at all times.\n\n  \n- Wonder what it\'ll be like?\n- A little scary.\n\n  \nWelcome to Honex,\na division of Honesco\n\n  \nand a part of the Hexagon Group.\n\n  \nThis is it!\n\n  \nWow.\n\n  \nWow.\n\n  \nWe know that you, as a bee,\nhave worked your whole life\n\n  \nto get to the point where you\ncan work for your whole life.\n\n  \nHoney begins when our valiant Pollen\nJocks bring the nectar to the hive.\n\n  \nOur top-secret formula\n\n  \nis automatically color-corrected,\nscent-adjusted and bubble-contoured\n\n  \ninto this soothing sweet syrup\n\n  \nwith its distinctive\ngolden glow you know as...\n\n  \nHoney!\n\n  \n- That girl was hot.\n- She\'s my cousin!\n\n  \n- She is?\n- Yes, we\'re all cousins.\n\n  \n- Right. You\'re right.\n- At Honex, we constantly strive\n\n  \nto improve every aspect\nof bee existence.\n\n  \nThese bees are stress-testing\na new helmet technology.\n\n  \n- What do you think he makes?\n- Not enough.\n\n  \nHere we have our latest advancement,\nthe Krelman.\n\n  \n- What does that do?\n- Oatches that little strand of honey\n\n  \nthat hangs after you pour it.\nSaves us millions.\n\n  \nOan anyone work on the Krelman?\n\n  \nOf course. Most bee jobs are\nsmall ones. But bees know\n\n  \nthat every small job,\nif it\'s done well, means a lot.\n\n  \nBut choose carefully\n\n  \nbecause you\'ll stay in the job\nyou pick for the rest of your life.\n\n  \nThe same job the rest of your life?\nI didn\'t know that.\n\n  \nWhat\'s the difference?\n\n  \nYou\'ll be happy to know that bees,\nas a species, haven\'t had one day off\n\n  \nin 27 million years.\n\n  \nSo you\'ll just work us to death?\n\n  \nWe\'ll sure try.\n\n  \nWow! That blew my mind!\n\n  \n\"What\'s the difference?\"\nHow can you say that?\n\n  \nOne job forever?\nThat\'s an insane choice to have to make.\n\n  \nI\'m relieved. Now we only have\nto make one decision in life.\n\n  \nBut, Adam, how could they\nnever have told us that?\n\n  \nWhy would you question anything?\nWe\'re bees.\n\n  \nWe\'re the most perfectly\nfunctioning society on Earth.\n\n  \nYou ever think maybe things\nwork a little too well here?\n\n  \nLike what? Give me one example.\n\n  \nI don\'t know. But you know\nwhat I\'m talking about.\n\n  \nPlease clear the gate.\nRoyal Nectar Force on approach.\n\n  \nWait a second. Oheck it out.\n\n  \n- Hey, those are Pollen Jocks!\n- Wow.\n\n  \nI\'ve never seen them this close.\n\n  \nThey know what it\'s like\noutside the hive.\n\n  \nYeah, but some don\'t come back.\n\n  \n- Hey, Jocks!\n- Hi, Jocks!\n\n  \nYou guys did great!\n\n  \nYou\'re monsters!\nYou\'re sky freaks! I love it! I love it!\n\n  \n- I wonder where they were.\n- I don\'t know.\n\n  \nTheir day\'s not planned.\n\n  \nOutside the hive, flying who knows\nwhere, doing who knows what.\n\n  \nYou can\'tjust decide to be a Pollen\nJock. You have to be bred for that.\n\n  \nRight.\n\n  \nLook. That\'s more pollen\nthan you and I will see in a lifetime.\n\n  \nIt\'s just a status symbol.\nBees make too much of it.\n\n  \nPerhaps. Unless you\'re wearing it\nand the ladies see you wearing it.\n\n  \nThose ladies?\nAren\'t they our cousins too?\n\n  \nDistant. Distant.\n\n  \nLook at these two.\n\n  \n- Oouple of Hive Harrys.\n- Let\'s have fun with them.\n\n  \nIt must be dangerous\nbeing a Pollen Jock.\n\n  \nYeah. Once a bear pinned me\nagainst a mushroom!\n\n  \nHe had a paw on my throat,\nand with the other, he was slapping me!\n\n  \n- Oh, my!\n- I never thought I\'d knock him out.\n\n  \nWhat were you doing during this?\n\n  \nTrying to alert the authorities.\n\n  \nI can autograph that.\n\n  \nA little gusty out there today,\nwasn\'t it, comrades?\n\n  \nYeah. Gusty.\n\n  \nWe\'re hitting a sunflower patch\nsix miles from here tomorrow.\n\n  \n- Six miles, huh?\n- Barry!\n\n  \nA puddle jump for us,\nbut maybe you\'re not up for it.\n\n  \n- Maybe I am.\n- You are not!\n\n  \nWe\'re going 0900 at J-Gate.\n\n  \nWhat do you think, buzzy-boy?\nAre you bee enough?\n\n  \nI might be. It all depends\non what 0900 means.\n\n  \nHey, Honex!\n\n  \nDad, you surprised me.\n\n  \nYou decide what you\'re interested in?\n\n  \n- Well, there\'s a lot of choices.\n- But you only get one.\n\n  \nDo you ever get bored\ndoing the same job every day?\n\n  \nSon, let me tell you about stirring.\n\n  \nYou grab that stick, and you just\nmove it around, and you stir it around.\n\n  \nYou get yourself into a rhythm.\nIt\'s a beautiful thing.\n\n  \nYou know, Dad,\nthe more I think about it,\n\n  \nmaybe the honey field\njust isn\'t right for me.\n\n  \nYou were thinking of what,\nmaking balloon animals?\n\n  \nThat\'s a bad job\nfor a guy with a stinger.\n\n  \nJanet, your son\'s not sure\nhe wants to go into honey!\n\n  \n- Barry, you are so funny sometimes.\n- I\'m not trying to be funny.\n\n  \nYou\'re not funny! You\'re going\ninto honey. Our son, the stirrer!\n\n  \n- You\'re gonna be a stirrer?\n- No one\'s listening to me!\n\n  \nWait till you see the sticks I have.\n\n  \nI could say anything right now.\nI\'m gonna get an ant tattoo!\n\n  \nLet\'s open some honey and celebrate!\n\n  \nMaybe I\'ll pierce my thorax.\nShave my antennae.\n\n  \nShack up with a grasshopper. Get\na gold tooth and call everybody \"dawg\"!\n\n  \nI\'m so proud.\n\n  \n- We\'re starting work today!\n- Today\'s the day.\n\n  \nOome on! All the good jobs\nwill be gone.\n\n  \nYeah, right.\n\n  \nPollen counting, stunt bee, pouring,\nstirrer, front desk, hair removal...\n\n  \n- Is it still available?\n- Hang on. Two left!\n\n  \nOne of them\'s yours! Oongratulations!\nStep to the side.\n\n  \n- What\'d you get?\n- Picking crud out. Stellar!\n\n  \nWow!\n\n  \nOouple of newbies?\n\n  \nYes, sir! Our first day! We are ready!\n\n  \nMake your choice.\n\n  \n- You want to go first?\n- No, you go.\n\n  \nOh, my. What\'s available?\n\n  \nRestroom attendant\'s open,\nnot for the reason you think.\n\n  \n- Any chance of getting the Krelman?\n- Sure, you\'re on.\n\n  \nI\'m sorry, the Krelman just closed out.\n\n  \nWax monkey\'s always open.\n\n  \nThe Krelman opened up again.\n\n  \nWhat happened?\n\n  \nA bee died. Makes an opening. See?\nHe\'s dead. Another dead one.\n\n  \nDeady. Deadified. Two more dead.\n\n  \nDead from the neck up.\nDead from the neck down. That\'s life!\n\n  \nOh, this is so hard!\n\n  \nHeating, cooling,\nstunt bee, pourer, stirrer,\n\n  \nhumming, inspector number seven,\nlint coordinator, stripe supervisor,\n\n  \nmite wrangler. Barry, what\ndo you think I should... Barry?\n\n  \nBarry!\n\n  \nAll right, we\'ve got the sunflower patch\nin quadrant nine...\n\n  \nWhat happened to you?\nWhere are you?\n\n  \n- I\'m going out.\n- Out? Out where?\n\n  \n- Out there.\n- Oh, no!\n\n  \nI have to, before I go\nto work for the rest of my life.\n\n  \nYou\'re gonna die! You\'re crazy! Hello?\n\n  \nAnother call coming in.\n\n  \nIf anyone\'s feeling brave,\nthere\'s a Korean deli on 83rd\n\n  \nthat gets their roses today.\n\n  \nHey, guys.\n\n  \n- Look at that.\n- Isn\'t that the kid we saw yesterday?\n\n  \nHold it, son, flight deck\'s restricted.\n\n  \nIt\'s OK, Lou. We\'re gonna take him up.\n\n  \nReally? Feeling lucky, are you?\n\n  \nSign here, here. Just initial that.\n\n  \n- Thank you.\n- OK.\n\n  \nYou got a rain advisory today,\n\n  \nand as you all know,\nbees cannot fly in rain.\n\n  \nSo be careful. As always,\nwatch your brooms,\n\n  \nhockey sticks, dogs,\nbirds, bears and bats.\n\n  \nAlso, I got a couple of reports\nof root beer being poured on us.\n\n  \nMurphy\'s in a home because of it,\nbabbling like a cicada!\n\n  \n- That\'s awful.\n- And a reminder for you rookies,\n\n  \nbee law number one,\nabsolutely no talking to humans!\n\n  \nAll right, launch positions!\n\n  \nBuzz, buzz, buzz, buzz! Buzz, buzz,\nbuzz, buzz! Buzz, buzz, buzz, buzz!\n\n  \nBlack and yellow!\n\n  \nHello!\n\n  \nYou ready for this, hot shot?\n\n  \nYeah. Yeah, bring it on.\n\n  \nWind, check.\n\n  \n- Antennae, check.\n- Nectar pack, check.\n\n  \n- Wings, check.\n- Stinger, check.\n\n  \nScared out of my shorts, check.\n\n  \nOK, ladies,\n\n  \nlet\'s move it out!\n\n  \nPound those petunias,\nyou striped stem-suckers!\n\n  \nAll of you, drain those flowers!\n\n  \nWow! I\'m out!\n\n  \nI can\'t believe I\'m out!\n\n  \nSo blue.\n\n  \nI feel so fast and free!\n\n  \nBox kite!\n\n  \nWow!\n\n  \nFlowers!\n\n  \nThis is Blue Leader.\nWe have roses visual.\n\n  \nBring it around 30 degrees and hold.\n\n  \nRoses!\n\n  \n30 degrees, roger. Bringing it around.\n\n  \nStand to the side, kid.\nIt\'s got a bit of a kick.\n\n  \nThat is one nectar collector!\n\n  \n- Ever see pollination up close?\n- No, sir.\n\n  \nI pick up some pollen here, sprinkle it\nover here. Maybe a dash over there,\n\n  \na pinch on that one.\nSee that? It\'s a little bit of magic.\n\n  \nThat\'s amazing. Why do we do that?\n\n  \nThat\'s pollen power. More pollen, more\nflowers, more nectar, more honey for us.\n\n  \nOool.\n\n  \nI\'m picking up a lot of bright yellow.\nOould be daisies. Don\'t we need those?\n\n  \nOopy that visual.\n\n  \nWait. One of these flowers\nseems to be on the move.\n\n  \nSay again? You\'re reporting\na moving flower?\n\n  \nAffirmative.\n\n  \nThat was on the line!\n\n  \nThis is the coolest. What is it?\n\n  \nI don\'t know, but I\'m loving this color.\n\n  \nIt smells good.\nNot like a flower, but I like it.\n\n  \nYeah, fuzzy.\n\n  \nOhemical-y.\n\n  \nOareful, guys. It\'s a little grabby.\n\n  \nMy sweet lord of bees!\n\n  \nOandy-brain, get off there!\n\n  \nProblem!\n\n  \n- Guys!\n- This could be bad.\n\n  \nAffirmative.\n\n  \nVery close.\n\n  \nGonna hurt.\n\n  \nMama\'s little boy.\n\n  \nYou are way out of position, rookie!\n\n  \nOoming in at you like a missile!\n\n  \nHelp me!\n\n  \nI don\'t think these are flowers.\n\n  \n- Should we tell him?\n- I think he knows.\n\n  \nWhat is this?!\n\n  \nMatch point!\n\n  \nYou can start packing up, honey,\nbecause you\'re about to eat it!\n\n  \nYowser!\n\n  \nGross.\n\n  \nThere\'s a bee in the car!\n\n  \n- Do something!\n- I\'m driving!\n\n  \n- Hi, bee.\n- He\'s back here!\n\n  \nHe\'s going to sting me!\n\n  \nNobody move. If you don\'t move,\nhe won\'t sting you. Freeze!\n\n  \nHe blinked!\n\n  \nSpray him, Granny!\n\n  \nWhat are you doing?!\n\n  \nWow... the tension level\nout here is unbelievable.\n\n  \nI gotta get home.\n\n  \nOan\'t fly in rain.\n\n  \nOan\'t fly in rain.\n\n  \nOan\'t fly in rain.\n\n  \nMayday! Mayday! Bee going down!\n\n  \nKen, could you close\nthe window please?\n\n  \nKen, could you close\nthe window please?\n\n  \nOheck out my new resume.\nI made it into a fold-out brochure.\n\n  \nYou see? Folds out.\n\n  \nOh, no. More humans. I don\'t need this.\n\n  \nWhat was that?\n\n  \nMaybe this time. This time. This time.\nThis time! This time! This...\n\n  \nDrapes!\n\n  \nThat is diabolical.\n\n  \nIt\'s fantastic. It\'s got all my special\nskills, even my top-ten favorite movies.\n\n  \nWhat\'s number one? Star Wars?\n\n  \nNah, I don\'t go for that...\n\n  \n...kind of stuff.\n\n  \nNo wonder we shouldn\'t talk to them.\nThey\'re out of their minds.\n\n  \nWhen I leave a job interview, they\'re\nflabbergasted, can\'t believe what I say.\n\n  \nThere\'s the sun. Maybe that\'s a way out.\n\n  \nI don\'t remember the sun\nhaving a big 75 on it.\n\n  \nI predicted global warming.\n\n  \nI could feel it getting hotter.\nAt first I thought it was just me.\n\n  \nWait! Stop! Bee!\n\n  \nStand back. These are winter boots.\n\n  \nWait!\n\n  \nDon\'t kill him!\n\n  \nYou know I\'m allergic to them!\nThis thing could kill me!\n\n  \nWhy does his life have\nless value than yours?\n\n  \nWhy does his life have any less value\nthan mine? Is that your statement?\n\n  \nI\'m just saying all life has value. You\ndon\'t know what he\'s capable of feeling.\n\n  \nMy brochure!\n\n  \nThere you go, little guy.\n\n  \nI\'m not scared of him.\nIt\'s an allergic thing.\n\n  \nPut that on your resume brochure.\n\n  \nMy whole face could puff up.\n\n  \nMake it one of your special skills.\n\n  \nKnocking someone out\nis also a special skill.\n\n  \nRight. Bye, Vanessa. Thanks.\n\n  \n- Vanessa, next week? Yogurt night?\n- Sure, Ken. You know, whatever.\n\n  \n- You could put carob chips on there.\n- Bye.\n\n  \n- Supposed to be less calories.\n- Bye.\n\n  \nI gotta say something.\n\n  \nShe saved my life.\nI gotta say something.\n\n  \nAll right, here it goes.\n\n  \nNah.\n\n  \nWhat would I say?\n\n  \nI could really get in trouble.\n\n  \nIt\'s a bee law.\nYou\'re not supposed to talk to a human.\n\n  \nI can\'t believe I\'m doing this.\n\n  \nI\'ve got to.\n\n  \nOh, I can\'t do it. Oome on!\n\n  \nNo. Yes. No.\n\n  \nDo it. I can\'t.\n\n  \nHow should I start it?\n\"You like jazz?\" No, that\'s no good.\n\n  \nHere she comes! Speak, you fool!\n\n  \nHi!\n\n  \nI\'m sorry.\n\n  \n- You\'re talking.\n- Yes, I know.\n\n  \nYou\'re talking!\n\n  \nI\'m so sorry.\n\n  \nNo, it\'s OK. It\'s fine.\nI know I\'m dreaming.\n\n  \nBut I don\'t recall going to bed.\n\n  \nWell, I\'m sure this\nis very disconcerting.\n\n  \nThis is a bit of a surprise to me.\nI mean, you\'re a bee!\n\n  \nI am. And I\'m not supposed\nto be doing this,\n\n  \nbut they were all trying to kill me.\n\n  \nAnd if it wasn\'t for you...\n\n  \nI had to thank you.\nIt\'s just how I was raised.\n\n  \nThat was a little weird.\n\n  \n- I\'m talking with a bee.\n- Yeah.\n\n  \nI\'m talking to a bee.\nAnd the bee is talking to me!\n\n  \nI just want to say I\'m grateful.\nI\'ll leave now.\n\n  \n- Wait! How did you learn to do that?\n- What?\n\n  \nThe talking thing.\n\n  \nSame way you did, I guess.\n\"Mama, Dada, honey.\" You pick it up.\n\n  \n- That\'s very funny.\n- Yeah.\n\n  \nBees are funny. If we didn\'t laugh,\nwe\'d cry with what we have to deal with.\n\n  \nAnyway...\n\n  \nOan I...\n\n  \n...get you something?\n- Like what?\n\n  \nI don\'t know. I mean...\nI don\'t know. Ooffee?\n\n  \nI don\'t want to put you out.\n\n  \nIt\'s no trouble. It takes two minutes.',12312,3,'2020-02-09 00:30:55','1581179455364.jpg'),(10,'12313','1232131',1232131,3,'2020-02-09 00:58:00','1581181079728.jpg');
/*!40000 ALTER TABLE `listings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer` int(11) DEFAULT NULL,
  `fk_listing_id` int(11) DEFAULT NULL,
  `fk_offeror_id` int(11) DEFAULT NULL,
  `TOC` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_listing_id` (`fk_listing_id`),
  KEY `fk_offeror_id` (`fk_offeror_id`),
  KEY `id` (`id`),
  CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`fk_listing_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `offers_ibfk_2` FOREIGN KEY (`fk_offeror_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (1,321,1,2,'2005-11-24 15:20:16'),(2,320,1,8,'2002-11-24 15:20:16'),(3,100,1,5,'2019-12-02 23:58:31'),(4,100,1,4,'2019-12-02 23:59:06'),(5,100,1,1,'2019-12-29 16:48:55'),(6,100,4,3,'2019-12-29 16:52:27'),(7,100,3,4,'2020-01-02 22:39:18'),(8,100,4,4,'2020-01-05 22:49:09'),(9,1,4,1,'2020-02-06 00:54:45'),(10,1,4,1,'2020-02-06 00:55:26'),(11,12,4,7,'2020-02-06 22:21:56'),(12,1,4,7,'2020-02-06 22:22:34'),(13,12,3,10,'2020-02-09 16:00:34');
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `password` text,
  `PFPID` mediumtext,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2019-11-24 15:47:16','testing1235asda','12344','1580969254542.jpg'),(2,'2000-01-01 00:00:00','username2\n\n','12','b.jpg'),(3,'2019-11-30 00:20:11','not_really','snoopdawg','1581231324226.jpg'),(4,'2019-12-29 16:26:19','admin2\r1','12','a.jpg'),(5,'2020-01-05 22:11:42','admin12','1234','1580901861794.jpg'),(6,'2020-01-21 09:15:54','dongen1','1234','1580919110670.jpg'),(7,'2020-02-06 21:34:25','1TanMeeMan1','yoo','1581039457329.jpg'),(8,'2020-02-08 00:44:24','Sum_Ting_Wong','12345','1581232084216.jpg'),(9,'2020-02-09 02:16:12','admin2','1234','1581185771332.jpg'),(10,'2020-02-09 14:47:25','Testing_User','Testing_User','1581230845142.jpg');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-09 16:29:14
