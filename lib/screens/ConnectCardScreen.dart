import 'package:churchapp_flutter/i18n/strings.g.dart';
import 'package:churchapp_flutter/providers/AppStateManager.dart';
import 'package:churchapp_flutter/utils/TextStyles.dart';
import 'package:churchapp_flutter/utils/Utility.dart';
import 'package:intl/intl.dart';
import '../utils/my_colors.dart';
import 'dart:convert';
import '../utils/ApiUrl.dart';
import '../utils/Alerts.dart';
import '../models/Userdata.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectCardScreen extends StatefulWidget {
  static const routeName = "/ConnectCardScreen";
  ConnectCardScreen();

  @override
  ConnectCardScreenState createState() => new ConnectCardScreenState();
}

class ConnectCardScreenState extends State<ConnectCardScreen> {
  Userdata userdata;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController streetController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController stateController = new TextEditingController();
  final TextEditingController postalCodeController =
      new TextEditingController();
  final TextEditingController birthdayController = new TextEditingController();
  final TextEditingController genderController = new TextEditingController();
  final TextEditingController maritalStatusController =
      new TextEditingController();
  final TextEditingController statusController = new TextEditingController();
  final TextEditingController attendanceController =
      new TextEditingController();

  validateandsubmit() async {
    String _email = emailController.text;
    String _firstName = firstNameController.text;
    String _lastName = lastNameController.text;
    String _phone = phoneController.text;
    String _street = streetController.text;
    String _city = cityController.text;
    String _state = stateController.text;
    String _postal = postalCodeController.text;
    String _birthday = birthdayController.text;
    String _gender = genderController.text;
    String _marital = maritalStatusController.text;
    String _status = statusController.text;
    String _attendance = attendanceController.text;

    if (_firstName == "" ||
        _lastName == "" ||
        _email == "" ||
        _phone == "" ||
        _street == "" ||
        _city == "" ||
        _state == "" ||
        _postal == "" ||
        _birthday == "" ||
        _gender == "" ||
        _marital == "" ||
        _status == "" ||
        _attendance == "") {
      Alerts.show(context, "", "Please fill all the fields before you submit.");
      return;
    }

    Alerts.showProgressDialog(context, t.processingpleasewait);
    FormData formData = FormData.fromMap({
      "firstName": _firstName,
      "lastName": _lastName,
      "phone": _phone,
      "email": _email,
      "street": _street,
      "city": _city,
      "state": _state,
      "postal": _postal,
      "birthday": _birthday,
      "gender": _gender,
      "marital": _marital,
      "status": _status,
      "attendance": _attendance,
    });

    try {
      var response = await Utility.getDio().post(ApiUrl.connect_card,
          data: formData, onSendProgress: (int send, int total) {
        print((send / total) * 100);
      });
      Navigator.of(context).pop();
      print(response.data);

      Map<String, dynamic> res = json.decode(response.data);
      if (res["status"] == "ok") {
        Alerts.show(
            context, "Success", "Your Connect Card was submitted sucessfully.");
        return;
      }
      //Navigator.pop(context, true);
    } on DioError catch (e) {
      Navigator.of(context).pop();
      Alerts.show(context, "Error", e.message);
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        //print(e.response.request);
      } else {
        //print(e.request.headers);
        print(e.message);
      }
    }
  }

  @override
  void initState() {
    userdata = Provider.of<AppStateManager>(context, listen: false).userdata;
    if (userdata != null) {
      emailController.text = userdata.email;
    }
    statusController.text = "Mango";
    super.initState();
  }

  int id = 0;
  List<String> _status = [
    "First Time Visitor",
    "Member",
    "Regular Attendee",
    "New Believer",
    "Update My Information"
  ];

  List<String> _attendance = [
    "In Person",
    "On Livestream",
    "I am no longer attending",
  ];

  List<String> _gender = [
    "Male",
    "Female",
  ];

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthdayController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    } else {
      print("picked null" + picked.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            "Connect"), /*actions: <Widget>[
        IconButton(
          icon: Icon(Icons.done_all),
          onPressed: () {
            validateandsubmit();
          },
        ),
      ]*/
      ),
      body: SingleChildScrollView(
        child: Container(
          //height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Text(
                    "Connect with us",
                    textAlign: TextAlign.center,
                    style: TextStyles.headline(context).copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 0, 20),
                  child: Text(
                    "If you are new or need to update your information, please fill out the connect card below.",
                    style: TextStyles.headline(context).copyWith(
                      //fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Text("First Name",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    controller: firstNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                height: 15,
              ),
              Text("Last Name",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    controller: lastNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("Email",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("Phone",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    controller: phoneController,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("Street",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  //height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: streetController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("City",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  //height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: cityController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("State",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  //height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: stateController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("Postal Code",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  //height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: postalCodeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("Birthday",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  //height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    enableInteractiveSelection: true,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _selectDate(context);
                    },
                    keyboardType: TextInputType.text,
                    controller: birthdayController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("Gender",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Container(
                height: 120.0,
                child: Column(
                  children: _gender
                      .map((data) => RadioListTile(
                            title: Text(data),
                            groupValue: genderController.text,
                            value: data,
                            onChanged: (val) {
                              setState(() {
                                genderController.text = data;
                              });
                            },
                          ))
                      .toList(),
                ),
              ),
              Container(height: 15),
              Text("Marital Status",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: EdgeInsets.all(0),
                elevation: 0,
                child: Container(
                  //height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[900],
                        blurRadius: 0,
                      )
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    controller: maritalStatusController,
                    decoration: InputDecoration(
                      //contentPadding: EdgeInsets.all(-12),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("I AM*",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Container(
                height: 280.0,
                child: Column(
                  children: _status
                      .map((data) => RadioListTile(
                            title: Text(data),
                            groupValue: statusController.text,
                            value: data,
                            onChanged: (val) {
                              setState(() {
                                statusController.text = data;
                              });
                            },
                          ))
                      .toList(),
                ),
              ),
              Container(height: 15),
              Text("I am attending*",
                  style: TextStyles.body1(context)
                      .copyWith(color: MyColors.grey_60)),
              Container(height: 5),
              Container(
                height: 180.0,
                child: Column(
                  children: _attendance
                      .map((data) => RadioListTile(
                            title: Text(data),
                            groupValue: attendanceController.text,
                            value: data,
                            onChanged: (val) {
                              setState(() {
                                attendanceController.text = data;
                              });
                            },
                          ))
                      .toList(),
                ),
              ),
              Container(height: 15),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 200,
                  height: 50,
                  child: TextButton(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: MyColors.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      validateandsubmit();
                    },
                  ),
                ),
              ),
              Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
