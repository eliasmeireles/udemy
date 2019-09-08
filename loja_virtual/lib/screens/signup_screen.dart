import 'package:flutter/material.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:loja_virtual/util/util.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _globalFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            textColor: Colors.white,
            child: Text(
              "Login",
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

  Widget _bodyBuilder(
          BuildContext context, Widget child, UserModel userModel) =>
      Form(
        key: _globalFormKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              validator: (text) {
                if (text.isEmpty || text.length < 6)
                  return "Nome inválido!";
                else
                  return null;
              },
              decoration: InputDecoration(
                labelText: "Nome completo",
              ),
            ),
            buildSizedBoxDivider(),
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
            buildSizedBoxDivider(),
            TextFormField(
              controller: _addressController,
              validator: (text) {
                if (text.isEmpty || text.length < 6)
                  return "Endereço inválido!";
                else
                  return null;
              },
              decoration: InputDecoration(
                labelText: "Endereço",
              ),
            ),
            buildSizedBoxDivider(),
            SizedBox(
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  if (_globalFormKey.currentState.validate()) {
                    _signUp(userModel);
                  }
                },
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                child: Text(
                  "Criar Conta",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      );

  void _signUp(UserModel userModel) {
    Map<String, dynamic> userData = {
      "email": _emailController.text,
      "name": _nameController.text,
      "address": _addressController.text
    };

    userModel.signUp(
        userData: userData,
        password: _passwordController.text,
        onSuccess: _onSuccess,
        onFail: _onFail);
  }

  void _onFail() {_showDialog(
      message: "Não foi possivél efetuar o cadastro, tente novamente!");
  }

  void _onSuccess() {
    _showDialog(
        message: "Sua conta foi criada com sucesso!", leaveScreen: true);
  }

  void _showDialog(
      {String title = "Criação de conta",
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
