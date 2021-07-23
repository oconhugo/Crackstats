///Sends the email to the email provided by the user ///

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../Constants.dart';

class SendEmail {
  String usrEmail;
  String pswCode;

  SendEmail(this.usrEmail, this.pswCode);

  Future<String> sendmail() async {
    String username = CRACKSTATSEMAIL; //Your Email;
    String password = CRACKSTATSEMAILPASSWORD; //Your Email's password;
    final smtpServer = gmail(username, password); // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(usrEmail) //recipent email
      //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
      //..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject = EMAILSUBJECT //subject of the email
      ..text = EMAILBODY + pswCode; //body of the email
    try {
      await send(message, smtpServer);
      return Future<String>.value(TRUE);
    } on MailerException {
      return Future<String>.value(FALSE);
    }
  }
}
