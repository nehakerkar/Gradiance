/*
SQLyog Trial v12.01 (64 bit)
MySQL - 5.6.21-log : Database - gradiance
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`gradiance` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `gradiance`;

/*Table structure for table `answers` */

DROP TABLE IF EXISTS `answers`;

CREATE TABLE `answers` (
  `answerid` int(11) NOT NULL DEFAULT '0',
  `questionid` int(11) NOT NULL,
  `parameterid` int(11) NOT NULL,
  `answertext` varchar(100) NOT NULL,
  `explanation` varchar(100) DEFAULT NULL,
  `answertype` varchar(5) NOT NULL,
  PRIMARY KEY (`answerid`),
  KEY `FKanswersquestions` (`questionid`,`parameterid`),
  CONSTRAINT `FKanswersquestions` FOREIGN KEY (`questionid`, `parameterid`) REFERENCES `questions` (`questionid`, `parameterid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `answers` */

insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11001,5401,1,'Correct ans 1,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11002,5401,1,'Correct ans 2,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11003,5401,1,'Incorrect ans, 3','short explanation 3','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11004,5401,1,'Incorrect ans, 4','short explanation 4','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11005,5401,1,'Incorrect ans, 5','short explanation 5','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11006,5401,1,'Incorrect ans, 6','short explanation 6','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11007,5402,1,'Correct ans 1,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11008,5402,1,'Correct ans 2,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11009,5402,1,'Correct ans 3,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11010,5402,1,'Incorrect ans,4','short explanation 4','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11011,5402,1,'Incorrect ans,5','short explanation 5','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11012,5402,1,'Incorrect ans,6','short explanation 6','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11013,5402,1,'Incorrect ans,7','short explanation 7','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11014,5402,1,'Incorrect ans,8','short explanation 8','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11015,5403,1,'Correct ans1v1,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11016,5403,1,'Correct ans2v1,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11017,5403,1,'Correct ans3v1,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11018,5403,1,'Incorrect ans,4v1','short explanation 4','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11019,5403,1,'Incorrect ans,5v1','short explanation 5','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11020,5403,1,'Incorrect ans,6v1','short explanation 6','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11021,5403,1,'Incorrect ans,7v1','short explanation 7','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11022,5403,1,'Incorrect ans,8v1','short explanation 8','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11023,5403,2,'Correct ans1v2,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11024,5403,2,'Correct ans2v2,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11025,5403,2,'Correct ans3v2,','','true');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11026,5403,2,'Incorrect ans,4v2','short explanation 4','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11027,5403,2,'Incorrect ans,5v2','short explanation 5','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11028,5403,2,'Incorrect ans,6v2','short explanation 6','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11029,5403,2,'Incorrect ans,7v2','short explanation 7','false');
insert  into `answers`(`answerid`,`questionid`,`parameterid`,`answertext`,`explanation`,`answertype`) values (11030,5403,2,'Incorrect ans,8v2','short explanation 8','false');

/*Table structure for table `bonus` */

DROP TABLE IF EXISTS `bonus`;

CREATE TABLE `bonus` (
  `eid` int(11) NOT NULL,
  `bcount` int(11) NOT NULL DEFAULT '5',
  `bpoints` int(11) NOT NULL DEFAULT '5',
  PRIMARY KEY (`eid`),
  CONSTRAINT `FKbonusexercises ` FOREIGN KEY (`eid`) REFERENCES `exercises` (`exerciseid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bonus` */

insert  into `bonus`(`eid`,`bcount`,`bpoints`) values (54001,1,3);
insert  into `bonus`(`eid`,`bcount`,`bpoints`) values (54002,1,4);

/*Table structure for table `chapter` */

DROP TABLE IF EXISTS `chapter`;

CREATE TABLE `chapter` (
  `isbnnum` varchar(20) NOT NULL DEFAULT '',
  `chapterid` int(11) NOT NULL DEFAULT '0',
  `chaptername` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`isbnnum`,`chapterid`),
  CONSTRAINT `FKchaptertextbook` FOREIGN KEY (`isbnnum`) REFERENCES `textbook` (`isbnnum`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `chapter` */

insert  into `chapter`(`isbnnum`,`chapterid`,`chaptername`) values ('0072465638',5401,'Introduction to database design');
insert  into `chapter`(`isbnnum`,`chapterid`,`chaptername`) values ('0072465638',5402,'SQL: Queries, Constraints, Triggers');
insert  into `chapter`(`isbnnum`,`chapterid`,`chaptername`) values ('0072465638',5403,'Storing data: Disks and Files');
insert  into `chapter`(`isbnnum`,`chapterid`,`chaptername`) values ('0471605212',1001,'Primary File Organisations');
insert  into `chapter`(`isbnnum`,`chapterid`,`chaptername`) values ('0471605212',1002,'Tree Structures');

/*Table structure for table `course` */

DROP TABLE IF EXISTS `course`;

CREATE TABLE `course` (
  `token` varchar(20) NOT NULL DEFAULT '',
  `courseid` varchar(20) DEFAULT NULL,
  `semester` varchar(20) DEFAULT NULL,
  `coursestartdate` date NOT NULL,
  `courseenddate` date NOT NULL,
  `maxenrolled` int(11) NOT NULL,
  `numenrolled` int(11) NOT NULL check (numenrolled <= maxenrolled),
  `courselevel` varchar(20) NOT NULL,
  PRIMARY KEY (`token`),
  KEY `FKcoursecourselist` (`courseid`),
  CONSTRAINT `FKcoursecourselist` FOREIGN KEY (`courseid`) REFERENCES `courselist` (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `course` */

insert  into `course`(`token`,`courseid`,`semester`,`coursestartdate`,`courseenddate`,`maxenrolled`,`numenrolled`,`courselevel`) values ('CSC440FALL14','CSC440','Fall2014','2014-08-27','2014-12-12',5,3,'Undergrad');
insert  into `course`(`token`,`courseid`,`semester`,`coursestartdate`,`courseenddate`,`maxenrolled`,`numenrolled`,`courselevel`) values ('CSC540FALL14','CSC540','Fall2014','2014-08-25','2014-12-10',5,3,'Grad');
insert  into `course`(`token`,`courseid`,`semester`,`coursestartdate`,`courseenddate`,`maxenrolled`,`numenrolled`,`courselevel`) values ('CSC541FALL14','CSC541','Fall2014','2013-08-25','2013-12-06',5,3,'Grad');

/*Table structure for table `courselist` */

DROP TABLE IF EXISTS `courselist`;

CREATE TABLE `courselist` (
  `courseid` varchar(20) NOT NULL DEFAULT '',
  `coursename` varchar(30) NOT NULL,
  PRIMARY KEY (`courseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `courselist` */

insert  into `courselist`(`courseid`,`coursename`) values ('CSC440','Database Systems');
insert  into `courselist`(`courseid`,`coursename`) values ('CSC540','Database Systems');
insert  into `courselist`(`courseid`,`coursename`) values ('CSC541','Advanced Data Structures');

/*Table structure for table `difficultylevel` */

DROP TABLE IF EXISTS `difficultylevel`;

CREATE TABLE `difficultylevel` (
  `q_diff_level_id` int(11) NOT NULL DEFAULT '0',
  `q_diff_level` int(11) NOT NULL,
  PRIMARY KEY (`q_diff_level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `difficultylevel` */

insert  into `difficultylevel`(`q_diff_level_id`,`q_diff_level`) values (1,1);
insert  into `difficultylevel`(`q_diff_level_id`,`q_diff_level`) values (2,2);
insert  into `difficultylevel`(`q_diff_level_id`,`q_diff_level`) values (3,3);
insert  into `difficultylevel`(`q_diff_level_id`,`q_diff_level`) values (4,4);
insert  into `difficultylevel`(`q_diff_level_id`,`q_diff_level`) values (5,5);
insert  into `difficultylevel`(`q_diff_level_id`,`q_diff_level`) values (6,6);

/*Table structure for table `enrollment` */

DROP TABLE IF EXISTS `enrollment`;

CREATE TABLE `enrollment` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `token` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`,`token`),
  KEY `FKenrollmentcourselist` (`token`),
  CONSTRAINT `FKenrollmentcourselist` FOREIGN KEY (`token`) REFERENCES `course` (`token`) ON DELETE CASCADE,
  CONSTRAINT `FKenrollmentuser` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `enrollment` */

insert  into `enrollment`(`userid`,`token`) values ('jander','CSC440FALL14');
insert  into `enrollment`(`userid`,`token`) values ('mfiser','CSC440FALL14');
insert  into `enrollment`(`userid`,`token`) values ('tregan','CSC440FALL14');
insert  into `enrollment`(`userid`,`token`) values ('aneela','CSC540FALL14');
insert  into `enrollment`(`userid`,`token`) values ('jmick','CSC540FALL14');
insert  into `enrollment`(`userid`,`token`) values ('mjones','CSC540FALL14');
insert  into `enrollment`(`userid`,`token`) values ('aneela','CSC541FALL14');
insert  into `enrollment`(`userid`,`token`) values ('jmick','CSC541FALL14');
insert  into `enrollment`(`userid`,`token`) values ('mjones','CSC541FALL14');
/*Table structure for table `questions` */

DROP TABLE IF EXISTS `questions`;

CREATE TABLE `questions` (
  `questionid` int(11) NOT NULL DEFAULT '0',
  `questiontext` varchar(100) DEFAULT NULL,
  `topicid` int(11) NOT NULL,
  `diff_level_id` int(11) NOT NULL,
  `hint` varchar(100) DEFAULT NULL,
  `explanation` varchar(100) DEFAULT NULL,
  `parameterid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`questionid`,`parameterid`),
  KEY `FKquestionstopics` (`topicid`),
  KEY `FKquestionsdifflevel` (`diff_level_id`),
  CONSTRAINT `FKquestionsdifflevel` FOREIGN KEY (`diff_level_id`) REFERENCES `difficultylevel` (`q_diff_level_id`) ON DELETE CASCADE,
  CONSTRAINT `FKquestionstopics` FOREIGN KEY (`topicid`) REFERENCES `topics` (`topicid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `questions` */

insert  into `questions`(`questionid`,`questiontext`,`topicid`,`diff_level_id`,`hint`,`explanation`,`parameterid`) values (5401,'Question 1?',1001,2,'Hint Text Q1','detailed explanation Q1',1);
insert  into `questions`(`questionid`,`questiontext`,`topicid`,`diff_level_id`,`hint`,`explanation`,`parameterid`) values (5402,'Question 2?',1001,3,'Hint Text Q2','detailed explanation Q2',1);
insert  into `questions`(`questionid`,`questiontext`,`topicid`,`diff_level_id`,`hint`,`explanation`,`parameterid`) values (5403,'Consider a disk with a 512 bytes, 2000, 50, 5, 10msec. What is the capacity of a track in bytes ?',1003,2,'Hint Text Q3','detailed explanation Q3',1);
insert  into `questions`(`questionid`,`questiontext`,`topicid`,`diff_level_id`,`hint`,`explanation`,`parameterid`) values (5403,'Consider a disk with a 256 bytes, 1000, 100, 10, 20msec. What is the capacity of a track in bytes ?',1003,2,'Hint Text Q3','detailed explanation Q3',2);

/*Table structure for table `exercises` */

DROP TABLE IF EXISTS `exercises`;

CREATE TABLE `exercises` (
  `topicid` int(11) DEFAULT NULL,
  `exerciseid` int(11) NOT NULL DEFAULT '0',
  `token` varchar(20) NOT NULL,
  `userid` varchar(20) NOT NULL,
  `estartdate` date NOT NULL,
  `eenddate` date NOT NULL,
  `max_retry_count` int(11) NOT NULL check (max_retry_count>0),
  `exer_diff_level` varchar(11) NOT NULL check (exer_diff_level >= (select dl.q_diff_level from difficultylevel dl, questions q where q.diff_level_id= dl.diff_level_id)),
  `random_seed` int(11) NOT NULL,
  `points_per_question` int(11) NOT NULL,
  `negative_points` int(11) NOT NULL,
  `scoretypeid` int(11) NOT NULL,
  `number_qt` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`exerciseid`),
  KEY `FKexercisesprofessor` (`userid`,`token`),
  KEY `FKexercisescoretype` (`scoretypeid`),
  KEY `FKexercisestopic` (`topicid`),
  CONSTRAINT `FKexercisescoretype` FOREIGN KEY (`scoretypeid`) REFERENCES `scoretype` (`scoretypeid`) ON DELETE CASCADE,
  CONSTRAINT `FKexercisesprofessor` FOREIGN KEY (`userid`, `token`) REFERENCES `professor` (`userid`, `token`) ON DELETE CASCADE,
  CONSTRAINT `FKexercisestopic` FOREIGN KEY (`topicid`) REFERENCES `topics` (`topicid`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `exercises` */

insert  into `exercises`(`topicid`,`exerciseid`,`token`,`userid`,`estartdate`,`eenddate`,`max_retry_count`,`exer_diff_level`,`random_seed`,`points_per_question`,`negative_points`,`scoretypeid`,`number_qt`) values (1001,54001,'CSC540FALL14','kogan','2014-08-12','2014-09-19',2,'1-5',0,3,1,1,3);
insert  into `exercises`(`topicid`,`exerciseid`,`token`,`userid`,`estartdate`,`eenddate`,`max_retry_count`,`exer_diff_level`,`random_seed`,`points_per_question`,`negative_points`,`scoretypeid`,`number_qt`) values (1003,54002,'CSC540FALL14','kogan','2014-09-21','2014-10-10',100,'1-5',0,4,1,2,1);

/*Table structure for table `exercises_questions` */

DROP TABLE IF EXISTS `exercises_questions`;

CREATE TABLE `exercises_questions` (
  `exerciseid` int(11) NOT NULL DEFAULT '0',
  `questionid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`exerciseid`,`questionid`),
  KEY `FKexerques_questions` (`questionid`),
  CONSTRAINT `FKexerques_exercises` FOREIGN KEY (`exerciseid`) REFERENCES `exercises` (`exerciseid`) ON DELETE CASCADE,
  CONSTRAINT `FKexerques_questions` FOREIGN KEY (`questionid`) REFERENCES `questions` (`questionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `exercises_questions` */

insert  into `exercises_questions`(`exerciseid`,`questionid`) values (54001,5401);
insert  into `exercises_questions`(`exerciseid`,`questionid`) values (54001,5402);
insert  into `exercises_questions`(`exerciseid`,`questionid`) values (54001,5403);
insert  into `exercises_questions`(`exerciseid`,`questionid`) values (54002,5403);

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `fid` int(11) NOT NULL DEFAULT '0',
  `feedback_text` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `feedback` */

/*Table structure for table `notification` */

DROP TABLE IF EXISTS `notification`;

CREATE TABLE `notification` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `messageid` int(11) NOT NULL DEFAULT '0',
  `message` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`userid`,`messageid`),
  CONSTRAINT `FKnotificationuser` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `notification` */

/*Table structure for table `professor` */

DROP TABLE IF EXISTS `professor`;

CREATE TABLE `professor` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `token` varchar(20) NOT NULL DEFAULT 'default',
  PRIMARY KEY (`userid`,`token`),
  KEY `FKprofessorcourse` (`token`),
  CONSTRAINT `FKprofessorcourse` FOREIGN KEY (`token`) REFERENCES `course` (`token`) ON DELETE CASCADE,
  CONSTRAINT `FKprofessoruser` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `professor` */

insert  into `professor`(`userid`,`token`) values ('rchirkova','CSC440FALL14');
insert  into `professor`(`userid`,`token`) values ('kogan','CSC540FALL14');
insert  into `professor`(`userid`,`token`) values ('chealey','CSC541FALL14');

/*Table structure for table `scoretype` */

DROP TABLE IF EXISTS `scoretype`;

CREATE TABLE `scoretype` (
  `scoretypeid` int(11) NOT NULL DEFAULT '0',
  `scoringtype` varchar(20) NOT NULL,
  PRIMARY KEY (`scoretypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `scoretype` */

insert  into `scoretype`(`scoretypeid`,`scoringtype`) values (1,'last attempt');
insert  into `scoretype`(`scoretypeid`,`scoringtype`) values (2,'avg of all attempts');
insert  into `scoretype`(`scoretypeid`,`scoringtype`) values (3,'max of all attempts');

/*Table structure for table `section` */

DROP TABLE IF EXISTS `section`;

CREATE TABLE `section` (
  `isbnnum` varchar(20) NOT NULL DEFAULT '',
  `chapterid` int(11) NOT NULL DEFAULT '0',
  `sectionid` int(11) NOT NULL DEFAULT '0',
  `sectionname` varchar(100) NOT NULL,
  PRIMARY KEY (`isbnnum`,`chapterid`,`sectionid`),
  CONSTRAINT `FKsectionchapter` FOREIGN KEY (`isbnnum`, `chapterid`) REFERENCES `chapter` (`isbnnum`, `chapterid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `section` */

insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0072465638',5401,1,'Database design and ER diagram');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0072465638',5401,2,'Additional Features of ER Model');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0072465638',5402,1,'Union, Intersect and Except');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0072465638',5402,2,'Aggregate Operators');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0072465638',5403,1,'The Memory Hierarchy');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0072465638',5403,2,'Redundant Arrays of Independent disks');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0471605212',1001,1,'Sequencial file organizations');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0471605212',1001,2,'Direct file organisation');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0471605212',1002,1,'Binary tree structures');
insert  into `section`(`isbnnum`,`chapterid`,`sectionid`,`sectionname`) values ('0471605212',1002,2,'Hashing techniques');

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `studylevel` varchar(20) NOT NULL,
  PRIMARY KEY (`userid`),
  CONSTRAINT `FKstudentuser` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`userid`,`studylevel`) values ('aneela','Grad');
insert  into `student`(`userid`,`studylevel`) values ('jander','Undergrad');
insert  into `student`(`userid`,`studylevel`) values ('jharla','Grad');
insert  into `student`(`userid`,`studylevel`) values ('jmick','Grad');
insert  into `student`(`userid`,`studylevel`) values ('jmoyer','Grad');
insert  into `student`(`userid`,`studylevel`) values ('mfiser','Undergrad');
insert  into `student`(`userid`,`studylevel`) values ('mjones','Grad');
insert  into `student`(`userid`,`studylevel`) values ('tregan','Undergrad');

/*Table structure for table `submission` */

DROP TABLE IF EXISTS `submission`;

CREATE TABLE `submission` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `exerciseid` int(11) NOT NULL DEFAULT '0',
  `attemptnum` int(11) NOT NULL DEFAULT '0',
  `substarttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subendtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `answerlist` varchar(500) DEFAULT NULL,
  `score` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  `qlist` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`userid`,`exerciseid`,`attemptnum`),
  KEY `FKsubmissionexercises` (`exerciseid`),
  CONSTRAINT `FKsubmissionexercises` FOREIGN KEY (`exerciseid`) REFERENCES `exercises` (`exerciseid`) ON DELETE CASCADE,
  CONSTRAINT `FKsubmissionuser` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `submission` */

insert  into `submission`(`userid`,`exerciseid`,`attemptnum`,`substarttime`,`subendtime`,`answerlist`,`score`,`status`,`qlist`) values ('aneela',54002,1,'2014-09-21 04:45:31','2014-09-23 22:11:20','5403,1,11017',8,'complete','5403:1:11017,11020,11022,11019');
insert  into `submission`(`userid`,`exerciseid`,`attemptnum`,`substarttime`,`subendtime`,`answerlist`,`score`,`status`,`qlist`) values ('aneela',54002,2,'2014-10-02 04:45:37','2014-10-02 22:13:40','5403,2,11023',4,'complete','5403:2:11029,11030,11023,11027');
insert  into `submission`(`userid`,`exerciseid`,`attemptnum`,`substarttime`,`subendtime`,`answerlist`,`score`,`status`,`qlist`) values ('aneela',54002,3,'2014-10-08 04:45:46','2014-10-08 22:16:19','5403,2,11028',-1,'complete','5403:2:11024,11026,11028,11030');
insert  into `submission`(`userid`,`exerciseid`,`attemptnum`,`substarttime`,`subendtime`,`answerlist`,`score`,`status`,`qlist`) values ('jmick',54001,1,'2014-09-09 04:46:30','2014-09-10 23:03:28','5401,1,11002 5402,1,11007 5403,1,11016',9,'complete','5401:1:11002,11004,11005,11006 5402:1:11013,11012,11011,11007 5403:1:11019,11022,11016,11018');
insert  into `submission`(`userid`,`exerciseid`,`attemptnum`,`substarttime`,`subendtime`,`answerlist`,`score`,`status`,`qlist`) values ('mjones',54001,1,'2014-08-13 04:46:47','2014-08-14 23:53:17','5401,1,11001 5402,1,11009 5403,1,11017',12,'complete','5401:1:11005,11003,11001,11006 5402:1:11010,11009,11011,11012 5403:1:11019,11020,11017,11022');
insert  into `submission`(`userid`,`exerciseid`,`attemptnum`,`substarttime`,`subendtime`,`answerlist`,`score`,`status`,`qlist`) values ('mjones',54001,2,'2014-08-26 04:47:00','2014-08-27 22:00:03','5401,1,11004 5402,1,11008 5403,2,11024',5,'complete','5401:1:11004,11005,11006,11002 5402:1:11013,11011,11008,11010 5403:2:11024,11026,11028,11030');
insert  into `submission`(`userid`,`exerciseid`,`attemptnum`,`substarttime`,`subendtime`,`answerlist`,`score`,`status`,`qlist`) values ('mjones',54002,1,'2014-10-08 04:47:08','2014-10-08 22:32:18','5403,2,11025',4,'complete','5403:2:11027,11025,11029,11030');
insert  into `submission`(`userid`,`exerciseid`,`attemptnum`,`substarttime`,`subendtime`,`answerlist`,`score`,`status`,`qlist`) values ('mjones',54002,2,'2014-10-10 04:47:37','2014-10-10 05:33:34','5403,1,11018',-1,'complete','5403:1:11016,11018,11019,11020');

/*Table structure for table `subsection` */

DROP TABLE IF EXISTS `subsection`;

CREATE TABLE `subsection` (
  `isbnnum` varchar(20) NOT NULL DEFAULT '',
  `chapterid` int(11) NOT NULL DEFAULT '0',
  `sectionid` int(11) NOT NULL DEFAULT '0',
  `subsectionid` int(11) NOT NULL DEFAULT '0',
  `subsectionname` varchar(30) DEFAULT NULL,
  `subsectiondescr` varchar(100) NOT NULL,
  PRIMARY KEY (`isbnnum`,`chapterid`,`sectionid`,`subsectionid`),
  CONSTRAINT `FKsubsectionsection` FOREIGN KEY (`isbnnum`, `chapterid`, `sectionid`) REFERENCES `section` (`isbnnum`, `chapterid`, `sectionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `subsection` */

insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0072465638',5401,2,1,'Key Constraints','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0072465638',5401,2,2,'Participant constraints','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0072465638',5402,2,1,'Group by and Having clause','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0072465638',5403,1,1,'Magnetic disks','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0072465638',5403,2,1,'Data striping','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0072465638',5403,2,2,'Redundancy','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0471605212',1001,1,1,'Binary search','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0471605212',1001,1,2,'Interpolation search','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0471605212',1001,2,1,'Hashing functions','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0471605212',1002,1,1,'AVL Trees','');
insert  into `subsection`(`isbnnum`,`chapterid`,`sectionid`,`subsectionid`,`subsectionname`,`subsectiondescr`) values ('0471605212',1002,2,1,'Extendible hashing','');

/*Table structure for table `teaching_assistant` */

DROP TABLE IF EXISTS `teaching_assistant`;

CREATE TABLE `teaching_assistant` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `token` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`,`token`),
  KEY `FKtacourse` (`token`),
  CONSTRAINT `FKtacourse` FOREIGN KEY (`token`) REFERENCES `course` (`token`) ON DELETE CASCADE,
  CONSTRAINT `FKtauserid` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `teaching_assistant` */

insert  into `teaching_assistant`(`userid`,`token`) values ('aneela','CSC440FALL14');
insert  into `teaching_assistant`(`userid`,`token`) values ('jmick','CSC440FALL14');
insert  into `teaching_assistant`(`userid`,`token`) values ('jharla','CSC540FALL14');
insert  into `teaching_assistant`(`userid`,`token`) values ('jmoyer','CSC541FALL14');

/*Table structure for table `textbook` */

DROP TABLE IF EXISTS `textbook`;

CREATE TABLE `textbook` (
  `isbnnum` varchar(20) NOT NULL DEFAULT '',
  `textbookname` varchar(50) NOT NULL,
  `textbookauthor` varchar(50) NOT NULL,
  PRIMARY KEY (`isbnnum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `textbook` */

insert  into `textbook`(`isbnnum`,`textbookname`,`textbookauthor`) values ('0072465638','Database Management Systems (3rd edition)','Raghu Ramakrishnan and Johannes Gehrke');
insert  into `textbook`(`isbnnum`,`textbookname`,`textbookauthor`) values ('0471605212','File Organisation and Processing','Alan L. Tharp');

/*Table structure for table `textbook_course` */

DROP TABLE IF EXISTS `textbook_course`;

CREATE TABLE `textbook_course` (
  `isbnnum` varchar(20) NOT NULL DEFAULT '',
  `token` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`isbnnum`,`token`),
  KEY `FKtextbookcourse_courselist` (`token`),
  CONSTRAINT `FKtextbookcourse_courselist` FOREIGN KEY (`token`) REFERENCES `course` (`token`) ON DELETE CASCADE,
  CONSTRAINT `FKtextbookcourse_textbook` FOREIGN KEY (`isbnnum`) REFERENCES `textbook` (`isbnnum`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `textbook_course` */

insert  into `textbook_course`(`isbnnum`,`token`) values ('0072465638','CSC440FALL14');
insert  into `textbook_course`(`isbnnum`,`token`) values ('0072465638','CSC540FALL14');
insert  into `textbook_course`(`isbnnum`,`token`) values ('0471605212','CSC540FALL14');
insert  into `textbook_course`(`isbnnum`,`token`) values ('0471605212','CSC541FALL14');

/*Table structure for table `topic_courselist` */

DROP TABLE IF EXISTS `topic_courselist`;

CREATE TABLE `topic_courselist` (
  `topicid` int(11) NOT NULL DEFAULT '0',
  `courseid` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`topicid`,`courseid`),
  KEY `FKtopiccoursecourselist` (`courseid`),
  CONSTRAINT `FKtopiccoursecourselist` FOREIGN KEY (`courseid`) REFERENCES `courselist` (`courseid`) ON DELETE CASCADE,
  CONSTRAINT `FKtopiccoursetopics` FOREIGN KEY (`topicid`) REFERENCES `topics` (`topicid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `topic_courselist` */

insert  into `topic_courselist`(`topicid`,`courseid`) values (1001,'CSC440');
insert  into `topic_courselist`(`topicid`,`courseid`) values (1002,'CSC440');
insert  into `topic_courselist`(`topicid`,`courseid`) values (1001,'CSC540');
insert  into `topic_courselist`(`topicid`,`courseid`) values (1003,'CSC540');
insert  into `topic_courselist`(`topicid`,`courseid`) values (1004,'CSC540');
insert  into `topic_courselist`(`topicid`,`courseid`) values (1005,'CSC540');
insert  into `topic_courselist`(`topicid`,`courseid`) values (1004,'CSC541');
insert  into `topic_courselist`(`topicid`,`courseid`) values (1005,'CSC541');

/*Table structure for table `topic_section` */

DROP TABLE IF EXISTS `topic_section`;

CREATE TABLE `topic_section` (
  `topicid` int(11) NOT NULL DEFAULT '0',
  `isbnnum` varchar(20) NOT NULL DEFAULT '',
  `chapterid` int(11) NOT NULL DEFAULT '0',
  `sectionid` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`topicid`,`isbnnum`,`chapterid`,`sectionid`),
  KEY `FKtopicsectionsubsection` (`isbnnum`,`chapterid`,`sectionid`),
  CONSTRAINT `FKtopicsectionsubsection` FOREIGN KEY (`isbnnum`, `chapterid`, `sectionid`) REFERENCES `section` (`isbnnum`, `chapterid`, `sectionid`) ON DELETE CASCADE,
  CONSTRAINT `FKtopicsectiontopics` FOREIGN KEY (`topicid`) REFERENCES `topics` (`topicid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `topic_section` */

/*Table structure for table `topics` */

DROP TABLE IF EXISTS `topics`;

CREATE TABLE `topics` (
  `topicid` int(11) NOT NULL DEFAULT '0',
  `topicname` varchar(50) NOT NULL,
  PRIMARY KEY (`topicid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `topics` */

insert  into `topics`(`topicid`,`topicname`) values (1001,'Introduction to database design');
insert  into `topics`(`topicid`,`topicname`) values (1002,'SQL: Queries, Constraints, Triggers');
insert  into `topics`(`topicid`,`topicname`) values (1003,'Storing data: Disks and Files');
insert  into `topics`(`topicid`,`topicname`) values (1004,'Primary File organisations');
insert  into `topics`(`topicid`,`topicname`) values (1005,'Tree Structures');

/*Table structure for table `topq` */

DROP TABLE IF EXISTS `topq`;

CREATE TABLE `topq` (
  `qid` int(11) NOT NULL,
  `qcount` int(11) NOT NULL,
  PRIMARY KEY (`qid`),
  CONSTRAINT `FKtopqquestions` FOREIGN KEY (`qid`) REFERENCES `questions` (`questionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `topq` */

insert  into `topq`(`qid`,`qcount`) values (5401,1);
insert  into `topq`(`qid`,`qcount`) values (5403,2);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `userid` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `FKusertype` (`type_id`),
  CONSTRAINT `FKusertype` FOREIGN KEY (`type_id`) REFERENCES `usertype` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('admin','admin','admin@ncsu.edu','Admin','Admin',1);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('aneela','aneela','aneela@ncsu.edu','Aishwarya','Neelakantan',4);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('chealey','chealey','chealey@ncsu.edu','Cristopher','Healey',2);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('jander','jander','jander@ncsu.edu','Joseph','Anderson',3);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('jharla','jharla','jharla@ncsu.edu','Jitendra','Harlalka',4);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('jmick','jmick','jmick@ncsu.edu','Jenelle','Mick',4);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('jmoyer','jmoyer','jmoyer@ncsu.edu','James','Moyer',4);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('kogan','kogan','kogan@ncsu.edu','Kemafor','Ogan',2);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('mfiser','mfiser','mfiser@ncsu.edu','Michal','Fiser',3);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('mjones','mjones','mjones@ncsu.edu','Mary','Jones',3);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('rchirkova','rchirkova','rchirkova@ncsu.edu','Rada','Chirkova',2);
insert  into `user`(`userid`,`password`,`email`,`firstname`,`lastname`,`type_id`) values ('tregan','tregan','tregan@ncsu.edu','Tom','Regan',3);

/*Table structure for table `usertype` */

DROP TABLE IF EXISTS `usertype`;

CREATE TABLE `usertype` (
  `type_id` int(11) NOT NULL DEFAULT '0',
  `type_description` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `usertype` */

insert  into `usertype`(`type_id`,`type_description`) values (1,'admin');
insert  into `usertype`(`type_id`,`type_description`) values (2,'Professor');
insert  into `usertype`(`type_id`,`type_description`) values (3,'Student');
insert  into `usertype`(`type_id`,`type_description`) values (4,'TA');

DROP TRIGGER IF EXISTS score_trigger
delimiter $$
create trigger score_trigger before insert  on submission 
for each row begin 
if scoretypeid = 1 
then 
  	set new.score = (select s1.score from submission s1, s2 where s1.attemptnum = max(s2.attemptnum) and s1.userid=s2.userid and s1.exercise=s2.exercise);
end if;

if scoretypeid = 2 
then 
  	set new.score = (select avg(s1.score) from submission s1, s2 where s1.userid=s2.userid and s1.exercise=s2.exercise);
end if;

if scoretypeid = 3 
then 
  	set new.score = (select max(s1.score) from submission s1, s2 where s1.userid=s2.userid and s1.exercise=s2.exercise);
end if;

if scoretypeid = 4 
then 
  	set new.score = (select s1.score from submission s1, s2 where s1.attemptnum = 1 and s1.userid=s2.userid and s1.exercise=s2.exercise);
end if;
end $$


	DROP TRIGGER IF EXISTS ta_check
delimiter $$
create trigger ta_check before insert  on teaching_assistant 
for each row begin 
if new.userid = (select userid from student where studylevel='undergrad')
then 
  	delete from teaching_assistant where userid=new.userid;
end if;
end $$

/* Exercise*/
DROP TRIGGER IF EXISTS exercise_max_retry
delimiter $$
create trigger exercise_max_retry before insert  on exercises 
for each row begin 

  	update exercises set max_retry_count = 1 where  scoretypeid =4;

end $$

/*professor*/

DROP TRIGGER IF EXISTS only_one_prof_percourse
delimiter $$
create trigger only_one_prof_percourse before insert  on professor 
for each row begin 
if (select userid from course c, professor p where c.token=p.token)= 1
then
  	update professor set userid = 'NULL' where course.token=professor.token;
end if;
end $$

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
