import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../services/user_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();

  final _focusNodeUsername = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeButton = FocusNode();

  bool passwordIsObscure = true;
  void _onAuth() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    await UserService.login(_controllerUsername.text, _controllerPassword.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            image: DecorationImage(
          alignment: Alignment.centerLeft,
          fit: BoxFit.contain,
          image: AssetImage('images/background.jpg'),
        )),
        width: Get.width,
        height: Get.height,
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          height: Get.height,
          color: blackColor,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  height: 200,
                  child: Image.asset('images/gamer.gif'),
                ),
                Container(
                  child: TextFormField(
                    controller: _controllerUsername,
                    focusNode: _focusNodeUsername,
                    validator: (value) => value.length != 0
                        ? null
                        : 'Please insert your username',
                    onEditingComplete: () {
                      _focusNodeUsername.unfocus();
                      _focusNodePassword.requestFocus();
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person, color: mainColor),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  child: TextFormField(
                    controller: _controllerPassword,
                    focusNode: _focusNodePassword,
                    validator: (value) => value.length != 0
                        ? null
                        : 'Please insert your password',
                    onEditingComplete: () {
                      _focusNodeUsername.unfocus();
                      _focusNodeButton.requestFocus();
                    },
                    obscureText: passwordIsObscure,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: mainColor),
                      suffixIcon: InkWell(
                        child: Icon(
                            passwordIsObscure
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: mainColor),
                        onTap: () => setState(
                            () => passwordIsObscure = !passwordIsObscure),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(8),
                  width: 200,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: _onAuth,
                    focusNode: _focusNodeButton,
                    label: Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
                    icon: Icon(Icons.arrow_forward),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
