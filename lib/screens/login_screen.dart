import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ecommerce_app/providers/auth_provider.dart';
import 'package:ecommerce_app/widgets/my_rounded_button.dart';
import 'package:ecommerce_app/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _pageState = 0;
  Color bgColor = Colors.white;
  Color headingColor = Colors.teal;
  Color subHeadColor = Colors.grey[700];
  double deviceHeight = 0;
  double deviceWidth = 0;
  double _loginYOffset = 0;
  bool loginMode = false;
  var _isLoading = false;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  void dismissKeypad() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void resetFields() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    switch (_pageState) {
      case 0:
        bgColor = Colors.white;
        headingColor = Colors.teal;
        subHeadColor = Colors.grey[700];
        _loginYOffset = deviceHeight;
        dismissKeypad();
        resetFields();
        break;
      case 1:
        bgColor = Colors.teal;
        headingColor = Colors.lime;
        subHeadColor = Colors.grey[200];
        _loginYOffset = deviceHeight * 0.25;
        break;
    }
    return GestureDetector(
      onTap: () {
        dismissKeypad();
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(children: [
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            color: bgColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _pageState = 0;
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                      child: Column(
                        children: [
                          Text(
                            "EShop Waves",
                            style:
                                TextStyle(fontSize: 25.0, color: headingColor),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "Stay safe at home,keep social distancing and enjoy the online shopping from Eshop Waves!!!!",
                            style: TextStyle(
                              color: subHeadColor,
                              fontSize: 15.0,
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Center(
                    child: Image.asset(
                      'images/banner-1.png',
                    ),
                  ),
                ),
                MyRoundedButton(
                  color: Colors.teal,
                  label: 'Get Started',
                  onPress: () {
                    if (_pageState != 0) {
                      setState(() {
                        _pageState = 0;
                      });
                    } else {
                      setState(() {
                        _pageState = 1;
                      });
                    }
                  },
                  disabled: false,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 1000),
            transform: Matrix4.translationValues(0, _loginYOffset, 1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            child: ListView(children: [
              Container(
                height: deviceHeight * 0.70,
                child: Column(
                  children: [
                    Text(
                      loginMode ? "Login To Account" : "Create a new Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.teal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    MyTextField(
                      hintText: "Enter username ...",
                      icon: Icons.supervised_user_circle_sharp,
                      controller: usernameController,
                    ),
                    if (!loginMode)
                      MyTextField(
                        hintText: "Enter email ...",
                        icon: Icons.email,
                        controller: emailController,
                      ),
                    MyTextField(
                      hintText: "Enter password ...",
                      icon: Icons.security,
                      controller: passwordController,
                      obscureText: true,
                    ),
                    if (_isLoading)
                      SpinKitWave(
                        color: Colors.teal,
                      ),
                    if (!_isLoading)
                      MyRoundedButton(
                        color: Colors.teal,
                        onPress: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (loginMode) {
                            try {
                              await Provider.of<Auth>(context, listen: false)
                                  .login(usernameController.text,
                                      passwordController.text);
                            } catch (e) {
                              if (e.toString() is String) {
                                showError(context, e.toString());
                              } else {
                                showError(context, "Something went wrong !");
                              }
                            }
                            dismissKeypad();
                            resetFields();
                            setState(() {
                              _isLoading = false;
                            });
                          } else {
                            try {
                              await Provider.of<Auth>(context, listen: false)
                                  .register(
                                      usernameController.text,
                                      emailController.text,
                                      passwordController.text);
                            } catch (e) {
                              if (e.toString() is String) {
                                showError(context, e.toString());
                              } else {
                                showError(context, "Something went wrong !");
                              }
                            }
                            dismissKeypad();
                            resetFields();
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        label: loginMode ? 'Login' : 'Register',
                      ),
                    MyRoundedButton(
                      color: Colors.teal,
                      onPress: () {
                        setState(() {
                          loginMode = !loginMode;
                          resetFields();
                        });
                      },
                      label: loginMode
                          ? 'Create An Account'
                          : 'Already Have An Account',
                      outline: true,
                      disabled: _isLoading,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  void showError(BuildContext context, String message) {
    var alertDialog = AlertDialog(
      title: Text("An Error Occured"),
      titleTextStyle: TextStyle(
        color: Colors.red,
        fontFamily: 'Ubuntu',
        fontWeight: FontWeight.w700,
        fontSize: 25.0,
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Ok",
            style: TextStyle(
                color: Colors.red,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w600),
          ),
        )
      ],
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}
