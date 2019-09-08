import 'package:flutter/material.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatefulWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  _CustomDrawerState createState() => _CustomDrawerState(this.pageController);
}

class _CustomDrawerState extends State<CustomDrawer> {
  final PageController pageController;

  _CustomDrawerState(this.pageController);

  Widget _buildDrawerBackground() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 165, 236, 241), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBackground(),
          ListView(
            padding: EdgeInsets.only(top: 16.0, left: 32),
            children: <Widget>[
              _buildContainerHeader(context),
              Divider(
                color: Colors.white,
              ),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildContainerHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
      height: 170.0,
      child: Stack(
        children: <Widget>[
          _buildPositionedHeader(context),
          _buildPositionedUserAction(),
        ],
      ),
    );
  }

  Positioned _buildPositionedUserAction() {
    return Positioned(
      left: 0.0,
      bottom: 0.0,
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Ola, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              GestureDetector(
                child: Text(
                  !model.isLoggedIn() ? "Entre ou cadastre-se >" : "Sair",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  if (!model.isLoggedIn()) {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  } else {
                    _showDialog(model);
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Positioned _buildPositionedHeader(BuildContext context) {
    return Positioned(
      top: 8.0,
      left: 0.0,
      child: Text(
        "Futter's\nClothing",
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 34.0,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showDialog(UserModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Efetuar logout"),
          elevation: 10,
          content: new Text(
              "Você realmente deseja efetuar o logout do applicativo?"),
          actions: <Widget>[
            FlatButton(
              child: new Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Confirmar", style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                model.signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
