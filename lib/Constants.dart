import 'package:flutter/material.dart';

//CONSTANTS VARIABLES
const String FIRSTNAME = "First Name";
const String LASTNAME = "Lastname";
const String EMAIL = "E-mail";
const String DATEOFBIRTH = "Date of birth";
const String PASSWORD = "Password";
const String REENTERPASSWORD = "Re-enter password";
const String GENDER = "Gender";
const String FORGOTPASSWORD = "Forgot password?";
const String SIGNIN = "Sign In";
const String REGISTER = "Register";
const String TITLE = "Crackstats";
const String MALE = 'Male';
const String FEMALE = 'Female';
const String PASSWORDMATCHNOTICE = 'Passwords Must Match';
const String PASSWORDREQUIREMENTS =
    'PASSWORD MUST BE AT LEAST 6 CHARACTERS LONG';
const String INCOMPLETEFIELDSMSG = 'Please fill all fields';
const String FORGOTPASSWORDMESSAGE = 'If your email is on record, you will' +
    '\n' 'receive a temporal code.You will be' +
    '\n' +
    'able to log in using that code as a' +
    '\n' +
    'password and change your password' +
    '\n' +
    'once you are in.';
const String SENDCODE = 'Send Code';
const String USERADDED = "user added successfully";
const String USEREXIST = "User exist in database";
const String CRACKSTATSEMAIL = 'crackstats01@gmail.com';
const String CRACKSTATSEMAILPASSWORD = 'MessiCrack.10';
const String EMAILSENT = 'Email Sent';
const String EMPTYSTR = "";
const String EMAILSENTMSG =
    'Email Sent. Please check spam if not found in inbox.';
const String EMAILNOTSENT = 'Email Not Sent';
const String EMAILNOTSENTMSG =
    'Email not sent. Please check internet connection and the email is correct';
const String EMAILBODY = 'Hello,' + '\n\n' + 'Your temporary password is: ';
const String EMAILSUBJECT = 'CrackStats Password Recover';
const String TRUE = 'true';
const String FALSE = 'false';
const String OK = 'OK';
const String NOTREGISTERED = 'ERROR: UNABLE TO REGISTER';
const String REGISTERED = 'USER REGISTERED';
const String ALREADYREGISTERED = "user already registered";
const String REGISTEREDMSG = 'User registered succesfully';
const String NOTREGISTEREDMSG =
    'User unable to register. Email is already in use or internet connection unavailable';
const String SAVE = "Save";
const String CANCEL = "Cancel";
const String EDIT = "Edit";
const String DELETE = "Delete";
const String MENUTITLE = "Menu";
const String NOTIFICATIONS = "Notifications";
const String TEAMS = 'Teams';
const String WELCOME = "Welcome ";
const String LEAGUESTITLE = 'Leagues';
const String TEAMSTITLE = 'Teams';
const String ADDTEAMSTITLE = 'Add Team';
const String ADDPLAYERTITLE = 'Add Player Request';
const String PROFILETITLE = 'Profile';
const String LOGOUTTITLE = 'Log out';
const String PLAYERS = 'Players';
const String ADDPLAYER = 'Request to Join Team';
const String USERDOESNTEXISTMESSAGE = 'Incorrect User or Password';
const String LEAGUES = 'Leagues';
const String GOALS = 'Goals:';
const String APPS = 'Apps:';
const String YELLOWREDS = 'YL/RED:';
const String PASSWORDHIDER = '********';
const String SCHEDULE = 'Schedule';
const String STATS = 'Stats';
const String ANNOUNCEMENTS = 'Announcements';
const String STANDING = 'Standing';
const String GOALSCORERS = 'Goal Scorers';
const String DISCIPLINE = 'Discipline';
const String CREATETEAM = 'Create Team';
const String TEAMNAME = 'Team Name';
const String SENDREQUEST = 'Send Request';
const String MESSAGETOADMIN = "Comment for league admin\n\n\n\n";
const String MYLEAGUES = "My Leagues";
const String CONFIRMTEAMREQUESTMSG =
    'Your request has been sent to the league admin.';
const String CONFIRMPLAYERREQUESTMSG =
    'Your request has been sent to the team owner.';
const String REQUESTSENT = 'Request Send';
const String PLAYERSTATSTITLE = 'Player Stats';
const String REDCARDS = 'Red Cards';
const String YELLOWCARDS = 'Yellow Cards';
const double TITLESIZE = 35;
const String ADDPLAYERTEXT = "Press submit to request being added to team ";
const String ADDPLAYERTEXT2 = " from league ";
const String ANNOUNCEMENT = "Announcement";
const String TEAMNOTIFICATION = "Team Notification";
const String PLAYERNOTIFICATION = "Player Notification";
const String ADDTEAMMESSAGE = " wants to add a new team";
const String ADDPLAYERMESSAGE = " wants to join your team";
const String LEAGUETITLE = "League: ";
const String TEAMTITLE = "Team: ";
const String MESSAGETITLE = "Message: ";
const String NOTIFICATIONREMOVED = "Notification Removed";
const String ACCEPT = "Accept";
const String DECLINE = "Decline";
const String SALT = "%#MESS1=10#*";
const String DATE = "Date: ";
const String MYLEAGUESTITLE = "My Leagues";
const String ADDANNOUNCEMENT = "Add Announcement";
const String SELECTLEAGUE = "Please Select a League";
const String ENTERTEXT = "Enter any text";
const String ENTERANNOUNCEMENT = "Enter the announcement";
const String ADDTEXT = "Add";
const String ADDNEWANNOUNCEMENT = "Add an announcement";
const String ANNOUNCEMENTDISMISSED = "Announcement removed";
const String ANNOUNCEMENTNOTDISMISSED = "Announcement not removed";
const String ADDGAME = "Add New Game";
const String TIMEWITHFORMAT = "Time: HH:MM";
const String DATEWITHFORMAT = "Date: YYYY-MM-DD";
const String LOCALTEAM = "Local Team";
const String VISITORTEAM = "Visitor Team";
const String SCORETEXT = "Score";
const String SCORERTEXT = "Scorer";
const String NOLOCALGOALS = "No Local Goals";
const String NOVISITORGOALS = "No Visitor Goals";
const String YELLOWCARDSNUM = "Yellow cards number";
const String NOLOCALYELLOWS = "No Local Yellow Cards";
const String NOVISITORYELLOWS = "No Visitor Yellow Cards";
const String REDCARDSNUM = "Red cards number";
const String NOLOCALREDCARDS = "No Local Red Cards";
const String NOVISITORREDCARDS = "No Visitor Red Cards";
const String LOCALTEAMSCORERTXT = "Local Team Scorer";
const String VISITORTEAMSCORERTXT = "Visitor Team Scorer";
const String VISITORYELLOWSTXT = "Visitor Yellow cards";
const String LOCALYELLOWSTXT = "Local Yellow cards";
const String VISITORREDTXT = "Visitor Red cards";
const String LOCALREDTXT = "Local Red cards";
const String NOTEAMSELECTED = "No team has been selected yet";
const String SUBMIT = "Submit";
const String PARTICIPATEDPLAYERS = "Select players that participated:";
const String VENUE = "Venue";
const String SELECTTEAMS = "Please select a local y visitor team";
const String SELECTVALIDWEEK =
    "Please select a week not equal to zero, and less than or equal to ";
const String MATCHADDED = "Game Succesfully added";
const String WEEKNUMBER = "Week Number";
const String WEEK = "Week";
const String VS = "vs";
const String NEWMATCH = "Select if this game has been played";
const String SENTSUCCESSFULLY = "Request sent Succesfully";
const String GF = "GF:";
const String GA = "GA:";
const String GD = "GD:";
const String YELLOWRED = "Y(R):";

//URLS
const String INSERTDATAURL = "http://hugoocon.com/insert_into_db.php";
const String LOGINUSERCRED = "http://hugoocon.com/login_verify_user.php";
const String TEMPORALPASSWORDUPDATEURL =
    "http://hugoocon.com/update_temp_password.php";
const String MODIFYCREDURL = "http://hugoocon.com/modify_user_info.php";
const String RETRIEVEUSERLEAGUES =
    "http://hugoocon.com/retrieve_user_leagues.php";
const String RETRIEVEUSERSTATS = "http://hugoocon.com/retrieve_user_stats.php";
const String RETRIEVELEAGUETEAMS =
    "http://hugoocon.com/retrieve_league_teams.php";
const String RETRIEVEALLLEAGUES = "http://hugoocon.com/retrieve_leagues.php";
const String RETRIEVETEAMPLAYERS =
    "http://hugoocon.com/retrieve_team_players.php";
const String RETRIEVEPLAYERSTATS =
    "http://hugoocon.com/retrieve_player_stats.php";
const SENDADDTEAMREQUEST = "http://hugoocon.com/send_team_request.php";
const String SENDADDPLAYERREQUEST =
    "http://hugoocon.com/send_player_request.php";
const String GETUSERNOTIFICATIONSURL =
    "http://hugoocon.com/get_user_notifications.php";
const String REMOVENOTIFICATION =
    "http://hugoocon.com/remove_notifications.php";
const String DECLINEPLAYERREQUEST =
    "http://hugoocon.com/decline_player_request.php";
const String ACCEPTPLAYERREQUEST =
    "http://hugoocon.com/accept_player_request.php";
const String DECLINETEAMREQUESTURL =
    "http://hugoocon.com/decline_team_request.php";
const String ACCEPTTEAMREQUESTURL =
    "http://hugoocon.com/accept_team_request.php";
const String MYLEAGUEANNOUNCEMENT =
    "http://hugoocon.com/get_user_leagues_notifications.php";
const String GETMYADMINLEAGUES = "http://hugoocon.com/get_admin_leagues.php";
const String INSERTANNOUNCEMENT = "http://hugoocon.com/insert_announcement.php";
const String GETLEAGUEANNOUNCEMENTSURL =
    "http://hugoocon.com/get_league_announcements.php";
const String DISMISSANNOUNCEMENT =
    "http://hugoocon.com/dismiss_announcement.php";
const String GETLEAGUETEAMSURL = "http://hugoocon.com/get_league_teams.php";
const String SENDMATCHURL = "http://hugoocon.com/insert_new_match.php";
const String GETLEAGUEWEEKS = "http://hugoocon.com/get_league_weeks.php";
const String GETWEEKGAMES = "http://hugoocon.com/get_week_games.php";
const String GETMATCHINFO = "http://hugoocon.com/get_match_info.php";
const String UPDATEMATCHURL = "http://hugoocon.com/update_new_match.php";
const String GETALLLEAGUEGAMES = "http://hugoocon.com/get_all_league_games.php";
const String RETRIEVETEAMSTATSURL =
    "http://hugoocon.com/retrieve_team_stats.php";
const String RETRIEVELEAGUESCORERS =
    "http://hugoocon.com/retrieve_league_scorers.php";
const String RETRIEVEPLAYERDISCIPLINE =
    "http://hugoocon.com/retrieve_player_discipline_stats.php";

//COLORS
const PRIMARYCOLOR = Color(0xFF008000);
const PENCILCOLOR = Colors.orangeAccent;
const SECUNDARYCOLOR = Colors.white;
const BLUE = Colors.blue;
const WHITE = Colors.white;
const BLACK = Colors.black;
const RED = Colors.red;
const YELLOW = Colors.yellow;

//global variables
var userEmailGlobal = '';
var userPasswordGlobal = '';
var globalUserLeagueList = List();
var globalLeagueList = List();
var globalUserType;
