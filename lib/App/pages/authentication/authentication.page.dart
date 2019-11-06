import 'package:flutter/material.dart';

enum AuthState { signIn, signUp }

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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
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
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'Mail',
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                Divider(
                  color: Theme.of(context).primaryColorLight,
                  height: 0,
                  thickness: 1,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    labelText: 'Password',
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                ),
                FlatButton(
                  child: Text('Sign-in'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        FlatButton(
          child: Text(
            'Sign-up Instead',
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: 12,
            ),
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
