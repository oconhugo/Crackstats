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
