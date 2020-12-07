import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../Constants.dart';

class SendEmail{

  String usrEmail;
  SendEmail(this.usrEmail);

  Future<String> sendmail() async {

  String username = CRACKSTATSEMAIL;//Your Email;
  String password = CRACKSTATSEMAILPASSWORD;//Your Email's password;
  final smtpServer = gmail(username, password); // Creating the Gmail server
  
  // Create our email message.
  final message = Message()
    ..from = Address(username)
    ..recipients.add(usrEmail) //recipent email
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
    //..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
    ..subject = 'CrackStats Password Recover' //subject of the email
    ..text = 'ARRIBA LAS AGUILACTICAS'; //body of the email
  try {
    final sendReport = await send(message, smtpServer);
    return Future<String>.value('true');
    //print('Message sent: ' + sendReport.toString()); //print if the email is sent
  } on MailerException catch (e) {
    return Future<String>.value('false');
    //print('Message not sent. \n'+ e.toString()); //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
} 
}