//Makes the calls to the PHP

import 'package:http/http.dart' as http;
import './Constants.dart';
import 'dart:convert';

class ConnectDB {
  //register a new user
  Future<String> sendData(registerFields, genderinput) async {
    final response = await http.post(
      INSERTDATAURL,
      body: {
        "name": registerFields[FIRSTNAME],
        "email": registerFields[EMAIL],
        "last_name": registerFields[LASTNAME],
        "dob": registerFields[DATEOFBIRTH],
        "gender": genderinput,
        "password": registerFields[PASSWORD],
      },
    );
    return Future.delayed(Duration(milliseconds: 1), () => response.body);
  }

  //Verify if the user exist in the db
  Future<Map> logInDb(email, pswd) async {
    final response = await http.post(
      LOGINUSERCRED,
      body: {
        "email": email,
        "password": pswd,
      },
    );

    try {
      Map<String, dynamic> user = jsonDecode(response.body);
      userEmailGlobal = user['Email'];
      userPasswordGlobal = user['Password'];
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //Add temporal password to db
  Future<String> tempPswUpdate(email, pwd) async {
    final response = await http.post(
      TEMPORALPASSWORDUPDATEURL,
      body: {
        "email": email.text,
        "password": pwd,
      },
    );
    return Future.delayed(Duration(milliseconds: 1), () => response.body);
  }

  //Update the user credentials
  Future<Map> updateCred(newUserInfo) async {
    final response = await http.post(
      MODIFYCREDURL,
      body: {
        "name": newUserInfo[FIRSTNAME],
        "email": newUserInfo[EMAIL],
        "last_name": newUserInfo[LASTNAME],
        "dob": newUserInfo[DATEOFBIRTH],
        "password": newUserInfo[PASSWORD],
      },
    );

    try {
      Map<String, dynamic> user = jsonDecode(response.body);
      userPasswordGlobal = user['Password'];
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //get the user leagues
  Future retrieveLeagues() async {
    final response = await http.post(
      RETRIEVEUSERLEAGUES,
      body: {"email": userEmailGlobal},
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //get all the registered leagues
  Future retrieveAllLeagues() async {
    final response = await http.post(
      RETRIEVEALLLEAGUES,
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //retrieve the user stats
  Future retrieveUserStats(league) async {
    final response = await http.post(
      RETRIEVEUSERSTATS,
      body: {"email": userEmailGlobal, "league": league},
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //retrieve all the teams from a league
  Future retrieveLeagueTeams(league) async {
    final response = await http.post(
      RETRIEVELEAGUETEAMS,
      body: {"league": league},
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //retrieve the teams where the player is registered
  Future retrieveTeamPlayers(team, league) async {
    final response = await http.post(
      RETRIEVETEAMPLAYERS,
      body: {"team": team, "league": league},
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //retrieve the user stats
  Future retrievePlayerStats(firstName, lastName, league, team) async {
    final response = await http.post(
      RETRIEVEPLAYERSTATS,
      body: {
        "first_name": firstName,
        "last_name": lastName,
        "league": league,
        "team": team
      },
    );
    try {
      var user = json.decode(response.body);
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    }
  }

  //send a request to add a team
  Future sendAddTeamRequest(team, league, comment) async {
    final response = await http.post(
      SENDADDTEAMREQUEST,
      body: {
        "sender": userEmailGlobal,
        "team": team,
        "league": league,
        "comment": comment
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //send the request to add a player
  Future sendAddPlayerRequest(team, league, comment) async {
    final response = await http.post(
      SENDADDPLAYERREQUEST,
      body: {
        "sender": userEmailGlobal,
        "team": team,
        "league": league,
        "comment": comment
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //get all user notifications
  Future getUserNotifications() async {
    final response = await http.post(
      GETUSERNOTIFICATIONSURL,
      body: {
        "user": userEmailGlobal,
      },
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Remove the notification
  Future removeNotification(id) async {
    final response = await http.post(
      REMOVENOTIFICATION,
      body: {
        "id": id,
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //Declide the player request
  Future declineplayernotification(List notification) async {
    final response = await http.post(
      DECLINEPLAYERREQUEST,
      body: {
        "id": notification[0],
        "player_email": notification[2],
        "team": notification[5],
        "user_email": userEmailGlobal,
        "league": notification[6],
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //Accept the player request
  Future acceptplayernotification(List notification) async {
    final response = await http.post(
      ACCEPTPLAYERREQUEST,
      body: {
        "id": notification[0],
        "player_email": notification[2],
        "team": notification[5],
        "user_email": userEmailGlobal,
        "league": notification[6],
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //Decline the team request
  Future declineteamrequest(List notification) async {
    final response = await http.post(
      DECLINETEAMREQUESTURL,
      body: {
        "id": notification[0],
        "player_email": notification[2],
        "team": notification[5],
        "user_email": userEmailGlobal,
        "league": notification[6],
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //Accept the team request
  Future acceptteamrequest(List notification) async {
    final response = await http.post(
      ACCEPTTEAMREQUESTURL,
      body: {
        "id": notification[0],
        "player_email": notification[2],
        "team": notification[5],
        "user_email": userEmailGlobal,
        "league": notification[6],
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //Get all the league announcements
  Future getLeagueNotifications(league) async {
    final response = await http.post(
      MYLEAGUEANNOUNCEMENT,
      body: {"league": league},
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Get the leagues administrators IDs
  Future getUserAdminLeaguesList(usrEmail) async {
    final response = await http.post(
      GETMYADMINLEAGUES,
      body: {"user": usrEmail},
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Insert a new announcement
  Future<String> insertNewAnnouncement(message, league) async {
    final response = await http.post(
      INSERTANNOUNCEMENT,
      body: {"message": message, "league": league},
    );
    return Future.delayed(Duration(milliseconds: 1), () => response.body);
  }

  //Get the league announcements
  Future getLeagueAnnouncements(league) async {
    final response = await http.post(
      GETLEAGUEANNOUNCEMENTSURL,
      body: {"league": league},
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Remove a announcement
  Future<String> dismissAnnouncement(id) async {
    final response = await http.post(
      DISMISSANNOUNCEMENT,
      body: {"id": id},
    );
    return Future.delayed(Duration(milliseconds: 1), () => response.body);
  }

  //Get the teams in a league
  Future getLeagueTeams(league) async {
    final response = await http.post(
      GETLEAGUETEAMSURL,
      body: {"league": league},
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Get the players from a team
  Future getTeamPlayers(team, league) async {
    final response = await http.post(
      RETRIEVETEAMPLAYERS,
      body: {"team": team, "league": league},
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Get the week number
  Future getLeagueWeeks(league) async {
    final response = await http.post(
      GETLEAGUEWEEKS,
      body: {"league": league},
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Get the games from a week
  Future getWeekGames(weekNum, league) async {
    final response = await http.post(
      GETWEEKGAMES,
      body: {
        "week_num": weekNum,
        "league": league,
      },
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Get all league games
  Future retrieveAllLeagueGames(league) async {
    final response = await http.post(
      GETALLLEAGUEGAMES,
      body: {
        "league": league,
      },
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Send a new match
  Future<String> sendMatch(
      localTeam,
      visitorTeam,
      weekNumber,
      date,
      venue,
      localScore,
      visitorScore,
      localYellows,
      visitorYellows,
      localReds,
      visitorReds,
      time,
      league,
      localApps,
      visitorApps,
      gamePlayed) async {
    final response = await http.post(
      SENDMATCHURL,
      body: {
        "localTeam": localTeam,
        "visitorTeam": visitorTeam,
        "Week_Num": weekNumber,
        "date": date,
        "venue": venue,
        "localScore": localScore,
        "visitorScore": visitorScore,
        "localYellows": localYellows,
        "visitorYellows": visitorYellows,
        "localReds": localReds,
        "visitorReds": visitorReds,
        "time": time,
        "league": league,
        "localApps": localApps,
        "visitorApps": visitorApps,
        "gamePlayed": gamePlayed
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //Get the information from a match
  Future getMatchInfo(id) async {
    final response = await http.post(
      GETMATCHINFO,
      body: {"id": id},
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Update the match information
  Future<String> updateMatch(
      localTeam,
      visitorTeam,
      weekNumber,
      date,
      venue,
      localScore,
      visitorScore,
      localYellows,
      visitorYellows,
      localReds,
      visitorReds,
      time,
      league,
      localApps,
      visitorApps,
      id,
      newMatch) async {
    final response = await http.post(
      UPDATEMATCHURL,
      body: {
        "localTeam": localTeam,
        "visitorTeam": visitorTeam,
        "Week_Num": weekNumber,
        "date": date,
        "venue": venue,
        "localScore": localScore,
        "visitorScore": visitorScore,
        "localYellows": localYellows,
        "visitorYellows": visitorYellows,
        "localReds": localReds,
        "visitorReds": visitorReds,
        "time": time,
        "league": league,
        "localApps": localApps,
        "visitorApps": visitorApps,
        "id": id,
        "newMatch": newMatch,
      },
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //Update the match information
  Future<String> deleteMatch(id) async {
    final response = await http.post(
      DELETEMATCHURL,
      body: {"id": id},
    );
    try {
      return Future.delayed(Duration(milliseconds: 1), () => response.body);
    } catch (e) {
      return null;
    }
  }

  //Get the stats from a team
  Future retrieveTeamStats(league) async {
    final response = await http.post(
      RETRIEVETEAMSTATSURL,
      body: {
        "league": league,
      },
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Get the league scorers
  Future retrieveLeagueScorers(league) async {
    final response = await http.post(
      RETRIEVELEAGUESCORERS,
      body: {
        "league": league,
      },
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }

  //Retrieve players dicipline stats
  Future retrievePlayerDisciplineStats(league) async {
    final response = await http.post(
      RETRIEVEPLAYERDISCIPLINE,
      body: {
        "league": league,
      },
    );
    try {
      return Future.delayed(
          Duration(milliseconds: 1), () => json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}
