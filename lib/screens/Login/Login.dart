import 'dart:ui';

import 'package:adisyon/auth.dart';
import 'package:adisyon/screens/Adisyon/Adisyon.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _LoginState createState() => new _LoginState();
}

enum FormType { login, register }

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  String _password, _email;
  FormType _formType = FormType.login;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  _loadAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email.text = (prefs.getString('email') ?? "null");
      password.text = (prefs.getString('password') ?? "null");
    });
    prefs.setString('email', "demo@adisyon.com");
    prefs.setString('password', "demo@adisyon.com");
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      //_presenter.doLogin(_email, _password);
      print('Form is valid. Email: $_email, password $_password');
      return true;
    } else {
      print('Form is invalid, Email: $_email, password $_password');
      return false;
    }
  }

  void _submit() async {
    try {
      if (validateAndSave()) {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);

          Navigator.of(context).pushReplacement(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new Adisyon(),
              ));
          print(userId);
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print(userId);
        }
        widget.onSignedIn();
      }
    } catch (e) {
      print('Hata: $e');
    }
  }

  void moveToRegister() {
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadAccount();
  }

  @override
  Widget build(BuildContext context) {
    var _loginForm = new Form(
      key: formKey,
      child: new Column(
        children: buildInputs() + buildSubmitButtons(),
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
    return new Scaffold(
      appBar: null,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new NetworkImage(
                  'https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/Yu5bJ4M/woman-using-her-mobile-phone-on-beautiful-blurred-lighting-background-inside-mcdonalds-restaurant_slsfefiwe_thumbnail-full01.png'),
              fit: BoxFit.cover),
        ),
        child: new Center(
          child: new ClipRect(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                child: _loginForm,
                height: 300.0,
                width: 300.0,
                decoration: new BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        controller: email,
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email boş geçilemez' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        controller: password,
        decoration: new InputDecoration(labelText: 'Parola'),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Parola boş geçilemez' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text("GİRİŞ"),
          onPressed: _submit,
        ),
        new FlatButton(
          child: new Text("Yeni Hesap Oluştur."),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text("Yeni Hesap Oluştur."),
          onPressed: _submit,
        ),
        new FlatButton(
          child: new Text("Hesabın var mı? Giriş Yap."),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
