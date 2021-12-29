import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicroom/styles.dart';
import 'package:musicroom/utils/apiServices.dart';
import 'package:musicroom/utils/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes.dart';
import '../utils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/RegisterScreen';
  RegisterScreen({Key? key, this.userType}) : super(key: key);

  UserType? userType;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _organizerName = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Widget _registrationForm;

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2!;
    final _userType = ModalRoute.of(context)!.settings.arguments;
    switch (_userType) {
      case UserType.partyOrganizer:
        {
          _registrationForm = Container();
        }
        break;
      case UserType.partyGuest:
        {
          _registrationForm = Container();
        }
        break;
    }

    return Scaffold(
        body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
                children: [
                  Text("Let's get you setup",
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w700,
                          textStyle: headline4
                      )),
                  SizedBox(height: 20),
                  Text(
                      'Kindly provide the necessary details to get your account up and running',
                      style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          height: 1.8
                      )),
                  SizedBox(height: 60),
                  TextFormField(
                    controller: _organizerName,
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (value) {
                      _organizerName.value = TextEditingValue(
                          text: value.trim(), selection: _organizerName.selection);
                    },
                    validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
                    // textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(16),
                      labelText: "DJ/Event Organizer Name",
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (value) {
                      _emailController.value = TextEditingValue(
                          text: value.trim(), selection: _emailController.selection);
                    },
                    validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
                    // textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(16),
                      labelText: "Email Address",
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    // textCapitalization: TextCapitalization.characters,
                    onChanged: (value) {
                      _passwordController.value = TextEditingValue(
                          text: value.trim(), selection: _passwordController.selection);
                    },
                    validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
                    // textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(16),
                      labelText: "Password",
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0)
                        ],
                        gradient: DarkPalette.borderGradient1,
                        // color: Colors.deepPurple.shade300,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(50, 50)),
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          // elevation: MaterialStateProperty.all(3),
                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          var FormData = <String, String>{
                            "organizer_name":  _organizerName.text,
                            "email": _emailController.text,
                            "password": _passwordController.text
                          };
                          ApiBaseHelper api = ApiBaseHelper();
                          try{
                            api.post("/register/", <String, String>{
                              "display_name":  _organizerName.text,
                              "email": _emailController.text,
                              "username": _emailController.text,
                              "password": _passwordController.text
                            }).then((value){
                              Navigator.of(context).pushNamed(Routes.login);
                              print("value is $value");
                            });
                          } catch (e){
                            print("error is $e");
                          }

                          if (_formKey.currentState!.validate()){

                          }





                          },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          child: Text("Sign Up",

                              style: GoogleFonts.workSans(
                                  color: DarkPalette.darkDark,
                                  fontWeight: FontWeight.bold
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "OR",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google_icon.png"),
                      SizedBox(
                        width: 30,
                      ),
                      Image.asset("assets/images/facebook_icon.png"),
                      SizedBox(
                        width: 30,
                      ),
                      Image.asset("assets/images/apple_icon.png"),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w300,
                          fontSize: 16
                      ),),
                      SizedBox(width: 10),

                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Routes.login);
                          },
                          child: Text("Sign In", style: GoogleFonts.workSans(

                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                          ),)),
                      Text("to continue", style: GoogleFonts.workSans(
                          fontWeight: FontWeight.w300,
                          fontSize: 16
                      ))
                    ],
                  )
                ],
              )
            )));
  }
}

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = "roland@boiyelove.website";
    _passwordController.text = "somepassword";
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2!;

    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      children: [
        Text("Welcome Back",
            style: GoogleFonts.workSans(
                fontWeight: FontWeight.w700,
                textStyle: headline4
            )),
        SizedBox(height: 20),
        Text(
            'Kindly provide the necessary details to  return to your activities',
            style: GoogleFonts.workSans(
                fontWeight: FontWeight.w300,
                fontSize: 16,
                height: 1.8
            )),
        SizedBox(height: 60),
        TextFormField(
          controller: _emailController,
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _emailController.value = TextEditingValue(
                text: value.trim(), selection: _emailController.selection);
          },
          validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
          // textAlign: TextAlign.center,
          decoration: new InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.all(16),
            labelText: "Email Address",
          ),
        ),
        SizedBox(height: 40),
        TextFormField(
          controller: _passwordController,
          // textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _passwordController.value = TextEditingValue(
                text: value.trim(), selection: _passwordController.selection);
          },
          validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
          // textAlign: TextAlign.center,
          decoration: new InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.all(16),
            labelText: "Password",
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.forgotPassword);
                },
                child: Text("Forgot Password?", style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color:Colors.white
                ),)),
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 5.0)
              ],
              gradient: DarkPalette.borderGradient1,
              // color: Colors.deepPurple.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(Size(50, 50)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                // elevation: MaterialStateProperty.all(3),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () async {
                ApiBaseHelper api = ApiBaseHelper();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                try{
                  api.post("/login/", <String, String>{
                    "username": _emailController.text.toLowerCase(),
                    "password": _passwordController.text
                  }).then((data) async {
                    print("value is $data");
                    await prefs.setString("token", data["token"]);
                    await prefs.setString("email", data["email"]);
                    await prefs.setString("display_name", data["display_name"]);
                    Navigator.pushReplacementNamed(context, Routes.organizerHome);




                  });
                } catch (e){
                  print("error is $e");
                }

              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text("Sign In",
                    style: GoogleFonts.workSans(
                    color: DarkPalette.darkDark,
                    fontWeight: FontWeight.bold
                )),
              ),
            ),
          ),
        ),
        SizedBox(height: 50),
        Text(
          "OR",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/google_icon.png"),
            SizedBox(
              width: 20,
            ),
            Image.asset("assets/images/facebook_icon.png"),
            SizedBox(
              width: 20,
            ),
            Image.asset("assets/images/apple_icon.png"),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?", style: GoogleFonts.workSans(
                fontWeight: FontWeight.w300,
                fontSize: 16
            )),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.decision);
                },
                child: Text("Sign Up", style: GoogleFonts.workSans(

                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ))),
            Text("to continue", style: GoogleFonts.workSans(
                fontWeight: FontWeight.w300,
                fontSize: 16
            ))
          ],
        )
      ],
    )));
  }
}

class ForgotPassword extends StatefulWidget {
  static const String routeName = "/forgotPassword";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
      children: [
        Text("Forgot Password?",
            style: GoogleFonts.workSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(height: 20),
        Text(
            'Having issues signing in to your account? provide your email and let’s fix this issue. '),
        SizedBox(height: 30),
        TextFormField(
          controller: _emailController,
          textCapitalization: TextCapitalization.characters,
          onChanged: (value) {
            _emailController.value = TextEditingValue(
                text: value.trim(), selection: _emailController.selection);
          },
          validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
          // textAlign: TextAlign.center,
          decoration: new InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
            ),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.all(16),
            labelText: "Email Address",
          ),
        ),
        SizedBox(height: 20),
        Row(children: [
          Expanded(
              child: InkWell(
            onTap: () {},
            child: Ink(
              decoration: const BoxDecoration(
                gradient: DarkPalette.borderGradient1,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 13, bottom: 13.0),
                constraints: BoxConstraints(
                    minWidth: 88.0,
                    minHeight: 36.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: Text(
                  'OK',
                  style: TextStyle(color: DarkPalette.darkDark),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ))
        ]),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Remember your details? Go back to ",
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
                child: Text("Log In")),
          ],
        )
      ],
    )));
  }
}

class RegisterPartyGuest extends StatefulWidget{
  static const routeName = "/registerPartyGuest";

  @override
  _RegisterPartyGuest createState() => _RegisterPartyGuest();
}
class _RegisterPartyGuest extends State<RegisterPartyGuest>{
  FilePickerResult? result;
  TextEditingController _displayNameController = TextEditingController();
  final _displayNameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;
    final TextStyle subtitle2 = Theme.of(context).textTheme.subtitle2!;

    return Scaffold(
        body: SafeArea(
            child: ListView(
              padding: EdgeInsets.only(top: 15, bottom: 20, left: 10, right: 10),
              children: [
                Text("Time to party",
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w700,
                        textStyle: headline4
                    )),
                SizedBox(height: 20),
                Text(
                    'Kindly provide the necessary details to  return to your activities',
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        height: 1.8
                    )),
                SizedBox(height: 60),
                Center(
                  child: GestureDetector(
                      onTap: () async {
                        result = await FilePicker.platform.pickFiles(
                            type: FileType.image
                        );
                        if (result != null) {
                          File file = File("${result!.files.single.path}");
                          setState(() {
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      child:
                      result == null ?  CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/images/avatar_upload.png"),
                    radius: 50,
                  ) : Container(
                          width: 120.0,
                          height: 120.0,
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:  FileImage(
                                      File("${result!.files.single.path}")
                                  )
                              )
                          )
                      ),)
                ),
                SizedBox(
                  height:20
                ),
                Text(
                    'Upload an image of yourself party style',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.workSans(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        height: 1.8
                    )),
                SizedBox(height: 30),
                Form(
                  key: _displayNameKey,
                  child: TextFormField(
                    controller: _displayNameController,
                    textCapitalization: TextCapitalization.characters,

                    validator: (value) => value!.isEmpty ? "Cannot be empty" : null,
                    // textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.7))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.all(16),
                      labelText: "Display Name",
                    ),
                  )
                ),


                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 5.0)
                      ],
                      gradient: DarkPalette.borderGradient1,
                      // color: Colors.deepPurple.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(50, 50)),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        // elevation: MaterialStateProperty.all(3),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () async {
                        if(_displayNameKey.currentState!.validate()){
                          ApiBaseHelper api = ApiBaseHelper();
                          var data = <String, dynamic>{
                            "device_id": await getDeviceId(),
                            "display_name": _displayNameController.text,
                          };
                          if (result != null){
                            Map image = {
                              "file": base64Encode(File("${result!.files.single.path}").readAsBytesSync()),
                              "filename": result!.files.single.path!.split("/").last
                            };
                            data["image"] = image;
                          }

                          api.post("/register/guest/", data).then((data) async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("display_name", _displayNameController.text);
                            Navigator.pushReplacementNamed(context, Routes.guestHome);
                          });
                          }

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text("Let's Party.",
                            style: GoogleFonts.workSans(
                                color: DarkPalette.darkDark,
                                fontWeight: FontWeight.bold
                            )),
                      ),
                    ),
                  ),
                ),

              ],
            )));
  }
}
