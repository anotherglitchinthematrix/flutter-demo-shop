import 'dart:ui';
import 'package:course_008/App/models/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:course_008/App/providers/index.dart';

class AuthData {
  String mail;
  String password;

  AuthData({this.mail, this.password});
}

enum AuthState { SignIn, SignUp }

class AuthenticationPage extends StatelessWidget {
  static const routeName = 'auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(32),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AuthenticationForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthenticationForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  var _formKey = GlobalKey<FormState>();
  var _passwordController = TextEditingController();
  var _passwordVisible = false;
  var _state = AuthState.SignIn;
  var _isLoading = false;
  var _data = AuthData();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  set isLoading(bool v) {
    setState(() {
      _isLoading = v;
    });
  }

  Future<void> _action() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // trigger the onSave methods of the TextFormFields
    _formKey.currentState.save();
    isLoading = true;
    // test delay
    await Future.delayed(Duration(milliseconds: 600));
    try {
      switch (_state) {
        case AuthState.SignIn:
          // print('Sign in action');
          await Provider.of<AuthenticationProvider>(context, listen: false).signIn(_data.mail, _data.password);
          break;
        case AuthState.SignUp:
          // print('Sign up action');
          await Provider.of<AuthenticationProvider>(context, listen: false).signUp(_data.mail, _data.password);
          break;
      }
    } on HttpException catch (error) {
      String errorMessage = 'Authentication Failed';

      if (error.message.contains('EMAIL_EXISTS')) {
        errorMessage = 'This email already signed up.';
      } else if (error.message.contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Couldn\'t find a user with the given email.';
      } else if (error.message.contains('INVALID_PASSWORD')) {
        errorMessage = 'Couldn\'t find a user with these credentials.';
      } else if (error.message.contains('USER_DISABLED')) {
        errorMessage = 'Your account is suspended.';
      }

      showDialog(
        context: context,
        builder: (_) => SimpleDialog(
          backgroundColor: Colors.red.shade50,
          contentPadding: EdgeInsets.all(16),
          children: <Widget>[
            Center(
              child: Text(errorMessage,
                  style: TextStyle(
                    color: Colors.red.shade800,
                  )),
            ),
          ],
        ),
      );
    }

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColorDark,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        enabled: !_isLoading,
                        onSaved: (value) => _data.mail = value,
                        validator: (value) {
                          // W3C e-mail pattern.
                          RegExp pattern = RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
                          if (!pattern.hasMatch(value)) {
                            print('test');
                            return 'Please provide a correct e-mail address.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          labelText: 'Mail',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColorLight,
                      height: 0,
                      thickness: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              enabled: !_isLoading,
                              onSaved: (value) => _data.password = value,
                              validator: (value) {
                                RegExp pattern = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,})");
                                if (_state == AuthState.SignUp && !pattern.hasMatch(value)) {
                                  // return pattern.pattern;
                                  return '- Must be at least 8 characters.\n- Must contain an uppercase and a lowercase.\n- Must contain a number. ';
                                  // return 'Password should be at least 8 characters long and must be containing an uppercase and lowercase character along with a number.';
                                }

                                if (value.isEmpty) {
                                  return 'Can\'t be blank';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                errorMaxLines: 4,
                                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                labelText: 'Password',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              obscureText: !_passwordVisible,
                              controller: _passwordController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              child: Opacity(
                                opacity: _passwordVisible ? 1 : 0.3,
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_state == AuthState.SignUp)
                      Column(
                        children: <Widget>[
                          Divider(
                            color: Theme.of(context).primaryColorLight,
                            height: 0,
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              enabled: !_isLoading,
                              validator: (value) {
                                if (_passwordController.text != value) {
                                  return 'Doesn\'t match.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorMaxLines: 4,
                                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                labelText: 'Password Repeat',
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              obscureText: !_passwordVisible,
                            ),
                          ),
                        ],
                      ),
                    Divider(
                      color: Theme.of(context).primaryColorLight,
                      height: 0,
                      thickness: 1,
                    ),
                    FlatButton(
                      child: Text(
                        '${_state == AuthState.SignIn ? 'Sign In' : 'Sign Up'}',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: !_isLoading ? _action : null,
                    ),
                  ],
                ),
                if (_isLoading)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        FlatButton(
          child: Text(
            '${_state == AuthState.SignIn ? 'Sign Up' : 'Sign In'} Instead',
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: 12,
            ),
          ),
          onPressed: _isLoading
              ? null
              : () {
                  setState(() {
                    switch (_state) {
                      case AuthState.SignIn:
                        _state = AuthState.SignUp;
                        break;
                      case AuthState.SignUp:
                        _state = AuthState.SignIn;
                        break;
                    }
                  });
                },
        ),
      ],
    );
  }
}
