import 'package:flutter/material.dart';

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

  void _action() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    // trigger the onSave methods of the TextFormFields
    _formKey.currentState.save();

    switch (_state) {
      case AuthState.SignIn:
        print('Sign in action');
        break;
      case AuthState.SignUp:
        print('Sign up action');
        break;
    }
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value) {
                      // W3C e-mail pattern.
                      RegExp pattern = RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
                      if (!pattern.hasMatch(value)) {
                        print('test');
                        return 'Please provide a correct e-mail address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                        padding: EdgeInsets.only(right: 8.0),
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
                          validator: (value) {
                            if (_passwordController.text != value) {
                              return 'Passwords doesn\'t match';
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
                  onPressed: _action,
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
          onPressed: () {
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
