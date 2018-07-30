import 'dart:async';
import 'dart:ui';
import 'package:adisyon/auth.dart';
import 'package:adisyon/models/user.dart';
import 'package:adisyon/utils/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _password, _email;
  FormType _formType = FormType.login;
  Helper helper = new Helper();

  Future<User> get isUser async {
    final String username = await helper.getFromSharedPreference('email');
    final String password = await helper.getFromSharedPreference('password');
    return new User(username, password);
  }

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  _loadAccount() async {
    final user = await isUser;
    setState(() {
      email.text = user.username;
      password.text = user.password;
    });
  }

  void _rememberMe(bool value) async {
    if (value == true) {
      helper.setFromSharedPreference('email', email.text);
      helper.setFromSharedPreference('password', password.text);
    }else{
      email.text = '';
      password.text = '';
      helper.setFromSharedPreference('email', '');
      helper.setFromSharedPreference('password', '');
    }
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

          /*Navigator.of(context).pushReplacement(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new Adisyon(),
              ));*/
          print("Oturum Açıldı $userId");
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print(userId);
        }
        widget.onSignedIn();
      }
    } on PlatformException catch (e) {
      print('Hata: ${e.message.toString()} / ${e.code}');
      if (e.message.toString() ==
          "The user account has been disabled by an administrator.") {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text("Hesabınız devre dışı."),
          duration: Duration(milliseconds: 100),
        ));
      }
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
      key: _scaffoldKey,
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
        new Checkbox(
          onChanged: (value) {
            _rememberMe(value);
          }, value: null,
        ),
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

class _username {}
