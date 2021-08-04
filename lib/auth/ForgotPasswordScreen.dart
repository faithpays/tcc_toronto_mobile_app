import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import '../utils/Alerts.dart';
import '../utils/TextStyles.dart';
import 'dart:convert';
import 'dart:async';
import '../utils/my_colors.dart';
import '../utils/ApiUrl.dart';
import '../utils/Utility.dart';
import 'package:email_validator/email_validator.dart';
import '../i18n/strings.g.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = "/forgotpassword";
  ForgotPasswordScreen();

  @override
  ForgotPasswordScreenRouteState createState() =>
      new ForgotPasswordScreenRouteState();
}

class ForgotPasswordScreenRouteState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  verifyFormAndSubmit() {
    String _email = emailController.text.trim();

    if (_email == "") {
      Alerts.show(context, t.error, t.emptyfielderrorhint);
    } else if (EmailValidator.validate(_email) == false) {
      Alerts.show(context, t.error, t.invalidemailerrorhint);
    } else {
      registerUser(_email);
    }
  }

  Future<void> registerUser(String email) async {
    Alerts.showProgressDialog(context, t.processingpleasewait);
    try {
      final response = await Utility.getDio().post(
        ApiUrl.RESETPASSWORD,
        data: jsonEncode({
          "data": {"email": email}
        }),
      );

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        Navigator.of(context).pop();
        dynamic res = jsonDecode(response.data);
        if (res["status"] == "error") {
          Alerts.show(context, t.error, res["message"]);
        } else {
          Alerts.show(context, t.success, res["message"]);
        }
        print(res);
      } else {
        Navigator.of(context).pop();
      }
    } catch (exception) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar:
          PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(height: 85),
            Container(height: 5),
            Text(t.appname,
                style: TextStyles.title(context).copyWith(
                    color: MyColors.primary, fontWeight: FontWeight.bold)),
            Container(height: 15),
            Text(t.enteremailaddresstoresetpassword,
                style: TextStyles.subhead(context).copyWith(
                  color: Colors.blueGrey[300],
                )),
            Container(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(t.emailaddress,
                  style: TextStyles.caption(context).copyWith()),
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[400], width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey[400], width: 2),
                ),
              ),
            ),
            Container(height: 25),
            Container(
              width: double.infinity,
              height: 40,
              child: TextButton(
                child: Text(
                  t.resetpassword,
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: MyColors.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20)),
                ),
                onPressed: () {
                  verifyFormAndSubmit();
                },
              ),
            ),
            Container(
              width: double.infinity,
              child: TextButton(
                child: Text(
                  t.backtologin,
                  style: TextStyle(color: MyColors.primary),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
              ),
            ),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}
