import 'dart:io';
import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconly/iconly.dart';
import 'package:musicroom/main.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile";

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String _enteredText = '';
  String? email = "partymixers@gmail.com";
  String? display_name = "PartyMixers";
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController1 = TextEditingController();
  TextEditingController newPasswordController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      display_name = prefs.getString("display_name");
      email = prefs.getString("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          leading: IconButton(
            icon: Icon(IconlyBold.arrow_left),
            color: DarkPalette.darkGold,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn().disconnect();
                  await FacebookAuth.instance.logOut();
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove("userType");
                  await prefs.remove("userLoggedIn");
                  await prefs.remove("display_name");
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => DecisionPage()),
                      (Route<dynamic> route) => false);
                },
                color: DarkPalette.darkGold,
                icon: Icon(Icons.power_settings_new_outlined))
          ],
        ),
        body: SafeArea(
            top: true,
            bottom: true,
            child: Column(children: [
              Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                      child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                        "assets/images/avatars/organizer-profile-icon.png"),
                  ))),
              InkWell(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.image);
                    if (result != null) {
                      File file = File("${result.files.single.path}");
                    } else {
                      // User canceled the picker
                    }
                  },
                  child: Text("Change Profile picture",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w300, fontSize: 16))),
              SizedBox(height: 20),
              TabBar(
                tabs: [
                  Tab(
                    child: Text("Profile"),
                  ),
                  Tab(
                    child: Text("Settings & More"),
                  )
                ],
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: TabBarView(
                        children: [
                          ListView(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 50, bottom: 15),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: DarkPalette.darkYellow))),
                                child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text("OK",
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 18,
                                                        color: Colors.amber)),
                                                onPressed: () async {
                                                  //Display name alert dialogue
                                                  // print("something happened");

                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  // String? token = prefs.getString("token");
                                                  // print("token is $token");

                                                  if (displayNameController
                                                              .text !=
                                                          null &&
                                                      displayNameController
                                                          .text.isNotEmpty) {
                                                    ApiBaseHelper api =
                                                        ApiBaseHelper();
                                                    api.post(
                                                        "/account-settings/change_name/",
                                                        {
                                                          "display_name":
                                                              displayNameController
                                                                  .text
                                                        }).then((data) async {
                                                      await prefs.setString(
                                                          "display_name",
                                                          data["display_name"]);
                                                      setState(() {
                                                        display_name = data[
                                                            "display_name"];
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                            'Display name updated..',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ));
                                                      });
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Colors.black,
                                            elevation: 16,
                                            content: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(height: 20),
                                                  Text(
                                                    'Change Display Name',
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        displayNameController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _enteredText = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        counterText:
                                                            '${_enteredText.length.toString()} character(s)'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("DJ/Event Organizer Name",
                                            style: GoogleFonts.workSans(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16)),
                                        Text(
                                          "$display_name",
                                          style: GoogleFonts.workSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        )
                                      ],
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 50, bottom: 15),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: DarkPalette.darkYellow))),
                                child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                                ),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text("OK",
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 18,
                                                        color: Colors.amber)),
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  if (EmailValidator.validate(
                                                      emailController.text)) {
                                                    ApiBaseHelper api =
                                                        ApiBaseHelper();
                                                    api.post(
                                                        "/account-settings/change_email/",
                                                        {
                                                          "email":
                                                              emailController
                                                                  .text
                                                        }).then((data) async {
                                                      await prefs.setString(
                                                          "email",
                                                          data["email"]);
                                                      setState(() {
                                                        email = data["email"];
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                SnackBar(
                                                          content: Text(
                                                            'Email address updated',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ));
                                                      });
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Colors.black,
                                            elevation: 16,
                                            content: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(height: 20),
                                                  Text(
                                                    'Change Email Address',
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  TextField(
                                                    controller: emailController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _enteredText = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        counterText:
                                                            '${_enteredText.length.toString()} character(s)'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Email Address",
                                          style: GoogleFonts.workSans(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "$email",
                                          style: GoogleFonts.workSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        )
                                      ],
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20, bottom: 5),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: DarkPalette.darkYellow))),
                                child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            actions: [
                                              TextButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: GoogleFonts.workSans(
                                                      fontSize: 18,
                                                      color: Colors.grey),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: Text("SAVE",
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 18,
                                                        color: Colors.amber)),
                                                onPressed: () {
                                                  if (newPasswordController1
                                                          .text
                                                          .trim() ==
                                                      newPasswordController2
                                                          .text
                                                          .trim()) {
                                                    ApiBaseHelper api =
                                                        ApiBaseHelper();
                                                    api.post(
                                                        "/account-settings/change_password/",
                                                        {
                                                          "old_password":
                                                              oldPasswordController
                                                                  .text
                                                                  .trim(),
                                                          "new_password":
                                                              newPasswordController1
                                                                  .text
                                                                  .trim(),
                                                        }).then((data) async {
                                                      Navigator.pop(context);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                          'Password updated',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ));
                                                    });
                                                  }
                                                },
                                              ),
                                            ],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Colors.black,
                                            elevation: 16,
                                            content: Container(
                                              padding: EdgeInsets.all(10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  SizedBox(height: 20),
                                                  Text(
                                                    'Change Password',
                                                    style: GoogleFonts.workSans(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 20),
                                                  TextField(
                                                    controller:
                                                        oldPasswordController,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Old Password",
                                                        hintStyle: GoogleFonts
                                                            .workSans(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 13),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        counterText:
                                                            '${_enteredText.length.toString()} character(s)'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        newPasswordController1,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "New Password",
                                                        hintStyle: GoogleFonts
                                                            .workSans(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 13),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        counterText:
                                                            '${_enteredText.length.toString()} character(s)'),
                                                  ),
                                                  TextField(
                                                    controller:
                                                        newPasswordController2,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Confirm New Password",
                                                        hintStyle: GoogleFonts
                                                            .workSans(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 13),
                                                        enabledBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: DarkPalette
                                                                  .darkYellow),
                                                        ),
                                                        counterText:
                                                            '${_enteredText.length.toString()} character(s)'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Change Password",
                                            style: GoogleFonts.workSans(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16)),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.chevron_right,
                                              size: 30, color: Colors.amber),
                                        )
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Connected Accounts",
                                  style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16)),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/google_icon.png"),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Image.asset(
                                      "assets/images/facebook_icon.png"),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Image.asset("assets/images/apple_icon.png"),
                                ],
                              ),
                            ],
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context)
                                      //     .pushNamed(Routes.subscription);
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 40, bottom: 5),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  width: 2,
                                                  color:
                                                      DarkPalette.darkYellow))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Go Premium (Coming Soon)"),
                                          IconButton(
                                            onPressed: () {
                                              // Navigator.of(context).pushNamed(
                                              //     Routes.subscription);
                                            },
                                            icon: Icon(Icons.chevron_right,
                                                size: 30,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                          )
                                        ],
                                      ),
                                    )),
                                SizedBox(height: 35),
                                Text("SETTINGS",
                                    style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16)),
                                Container(
                                  padding: EdgeInsets.only(top: 30, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Enable Dark Mode",
                                          style: GoogleFonts.workSans(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16)),
                                      CupertinoSwitch(
                                          value: false,
                                          trackColor: Colors.grey,
                                          onChanged: null)
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 20, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Turn off Notifications",
                                          style: GoogleFonts.workSans(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16)),
                                      CupertinoSwitch(
                                          value: true,
                                          activeColor: Colors.amber,
                                          trackColor: Colors.grey,
                                          onChanged: null)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text("Send Feedbacks & communicate with us",
                                    style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16)),
                                SizedBox(height: 20),
                                Row(children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color: DarkPalette.darkYellow,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Icon(FeatherIcons.facebook,
                                              color: Colors.amber))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Container(
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color: DarkPalette.darkYellow,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Icon(FeatherIcons.twitter,
                                              color: Colors.amber))),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: DarkPalette.darkYellow,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Icon(FeatherIcons.instagram,
                                            color: Colors.amber),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: DarkPalette.darkYellow,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Icon(FeatherIcons.mail,
                                            color: Colors.amber),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: DarkPalette.darkYellow,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Icon(FeatherIcons.phone,
                                            color: Colors.amber),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ])
                              ])
                        ],
                      ))),
              Text("Copyright 2021 | Music Room | Version 1.1",
                  style: GoogleFonts.workSans(
                      fontWeight: FontWeight.w300, fontSize: 13))
            ])),
      ),
    );
  }
}

class PartyGuestProfile extends StatefulWidget {
  static const String routeName = "/partyGuestProfile";
  @override
  _PartyGuestProfile createState() => _PartyGuestProfile();
}

class _PartyGuestProfile extends State<PartyGuestProfile> {
  String _enteredText = '';
  String? email = "partymixers@gmail.com";
  String? display_name = "PartyMixers";
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController1 = TextEditingController();
  TextEditingController newPasswordController2 = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      display_name = prefs.getString("display_name");
      email = prefs.getString("email");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: Icon(IconlyBold.arrow_left),
          color: DarkPalette.darkGold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => DecisionPage()),
                    (Route<dynamic> route) => false);
              },
              color: DarkPalette.darkGold,
              icon: Icon(Icons.power_settings_new_outlined))
        ],
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: Column(children: [
            Container(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      "assets/images/avatars/organizer-profile-icon.png"),
                ))),
            InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    File file = File("${result.files.single.path}");
                  } else {
                    // User canceled the picker
                  }
                },
                child: Text("Change Profile picture",
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w300, fontSize: 16))),
            SizedBox(height: 20),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 50, bottom: 15),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 2,
                                        color: DarkPalette.darkYellow))),
                            child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              "Cancel",
                                              style: GoogleFonts.workSans(
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: Text("OK",
                                                style: GoogleFonts.workSans(
                                                    fontSize: 18,
                                                    color: Colors.amber)),
                                            onPressed: () async {
                                              //Display name alert dialogue
                                              // print("something happened");

                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              // String? token = prefs.getString("token");
                                              // print("token is $token");

                                              if (displayNameController.text !=
                                                      null &&
                                                  displayNameController
                                                      .text.isNotEmpty) {
                                                ApiBaseHelper api =
                                                    ApiBaseHelper();
                                                api.post(
                                                    "/account-settings/change_name/",
                                                    {
                                                      "display_name":
                                                          displayNameController
                                                              .text
                                                    }).then((data) async {
                                                  await prefs.setString(
                                                      "display_name",
                                                      data["display_name"]);
                                                  setState(() {
                                                    display_name =
                                                        data["display_name"];
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                        'Display name updated..',
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ));
                                                  });
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.black,
                                        elevation: 16,
                                        content: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(height: 20),
                                              Text(
                                                'Change Display Name',
                                                style: GoogleFonts.workSans(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextField(
                                                controller:
                                                    displayNameController,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _enteredText = value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: DarkPalette
                                                              .darkYellow),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: DarkPalette
                                                              .darkYellow),
                                                    ),
                                                    counterText:
                                                        '${_enteredText.length.toString()} character(s)'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Display Name",
                                        style: GoogleFonts.workSans(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16)),
                                    Text(
                                      "$display_name",
                                      style: GoogleFonts.workSans(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                    )
                                  ],
                                )),
                          ),
                          SizedBox(height: 35),
                          Text("SETTINGS",
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w700, fontSize: 16)),
                          Container(
                            padding: EdgeInsets.only(top: 30, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enable Dark Mode",
                                    style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16)),
                                CupertinoSwitch(
                                    value: false,
                                    trackColor: Colors.grey,
                                    onChanged: null)
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 20, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Turn off Notifications",
                                    style: GoogleFonts.workSans(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16)),
                                CupertinoSwitch(
                                    value: true,
                                    activeColor: Colors.amber,
                                    trackColor: Colors.grey,
                                    onChanged: null)
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("Send Feedbacks & communicate with us",
                              style: GoogleFonts.workSans(
                                  fontWeight: FontWeight.w300, fontSize: 16)),
                          SizedBox(height: 20),
                          Row(children: [
                            InkWell(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: DarkPalette.darkYellow,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(FeatherIcons.facebook,
                                        color: Colors.amber))),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: DarkPalette.darkYellow,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Icon(FeatherIcons.twitter,
                                        color: Colors.amber))),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: DarkPalette.darkYellow,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(FeatherIcons.instagram,
                                      color: Colors.amber),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: DarkPalette.darkYellow,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(FeatherIcons.mail,
                                      color: Colors.amber),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: DarkPalette.darkYellow,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(FeatherIcons.phone,
                                      color: Colors.amber),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                          ])
                        ]))),
            Text("Copyright 2021 | Music Room | Version 1.1",
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w300, fontSize: 13))
          ])),
    );
  }
}
