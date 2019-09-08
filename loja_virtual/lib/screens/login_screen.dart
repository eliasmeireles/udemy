import 'package:flutter/material.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:loja_virtual/util/util.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            textColor: Colors.white,
            child: Text(
              "Criar conta",
              style: TextStyle(fontSize: 15.0),
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return _bodyBuilder(context, child, model);
        },
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context, Widget child, UserModel model) =>
      Form(
        key: _globalFormKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text.isEmpty || (!text.contains("@") || text.length < 6))
                  return "Email inválido!";
                else
                  return null;
              },
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            buildSizedBoxDivider(),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (text) {
                if (text.length < 6)
                  return "Senha inválida!";
                else
                  return null;
              },
              decoration: InputDecoration(
                labelText: "Senha",
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  var email = _emailController.text;
                  if (email.isEmpty ||
                      email.length < 6 && !email.contains("@")) {
                    _onFail(message:
                            "Email informado não é valido, para recupera sua senha, porfavor informe o seu email",
                        title: "Recuperação de senha");
                  } else {
                    model.passwordRecover(email, _onSuccess, _onFail);
                  }
                },
                child: Text("Esqueci minha senha"),
              ),
            ),
            buildSizedBoxDivider(),
            SizedBox(
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  if (_globalFormKey.currentState.validate()) {
                    model.signIn(
                      password: _passwordController.text.trim(),
                      email: _emailController.text.trim(),
                      onFail: _onFail,
                      onSuccess: _onSuccess,
                    );
                  }
                },
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );

  void _onFail(
      {String message =
          "Não foi possivél efetuar o login com os dados informados, tente novamente!",
      String title = "Login"}) {
    _showDialog(message: message);
  }

  void _onSuccess(
      {String message = "Login efetuado com sucesso!",
      bool leaveScreen = true}) {
    _showDialog(message: message, leaveScreen: leaveScreen);
  }

  void _showDialog(
      {String title = "Login",
      @required String message,
      bool leaveScreen = false}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();

                if (leaveScreen) {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
