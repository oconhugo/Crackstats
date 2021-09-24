import '../Constants.dart';
import 'package:http/http.dart' as http;

class SendEmail {
  String usrEmail;
  String pswCode;

  SendEmail(this.usrEmail, this.pswCode);

  Future<String> sendEmail() async {
    final response = await http.post(
      RECOVERPASSWORDURL,
      body: {
        "value1": usrEmail,
        "value2": pswCode,
      },
    );

    print(response.body);
    return Future.delayed(Duration(milliseconds: 1), () => response.body);
   /* try {
      Map<String, dynamic> user = jsonDecode(response.body);
      userEmailGlobal = user['Email'];
      userPasswordGlobal = user['Password'];
      return Future.delayed(Duration(milliseconds: 1), () => user);
    } catch (e) {
      return null;
    } */
  }
}
