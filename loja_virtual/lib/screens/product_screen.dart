import 'package:flutter/material.dart';
import 'package:loja_virtual/delegate/product_size_select_delegate.dart';
import 'package:loja_virtual/data/product.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/util/product_util.dart';
import 'package:loja_virtual/util/util.dart';
import 'package:loja_virtual/widgets/images_carousel.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen>
    implements ProductSizeSelectDelegate {
  final Product product;
  var _selectedSize;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        children: <Widget>[
          ImagesCarousel(product.images),
          Padding(
            padding: EdgeInsets.all(16),
            child: productTileAndPriceContainer(context, product,
                titleFontSize: 20.0,
                priceTextFontSize: 22.0,
                alignment: CrossAxisAlignment.start),
          ),
          Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 18.0),
                ),
                productSizeOptions(context, product, this),
                buildSizedBoxDivider(),
                _buttonAddProductToCart(context, primaryColor),
                productDescription(product),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buttonAddProductToCart(BuildContext context, Color primaryColor) =>
      SizedBox(
        height: 44.0,
        width: double.infinity,
        child: RaisedButton(
          onPressed: _selectedSize != null
              ? () {
                  if (UserModel.of(context).isLoggedIn()) {
                  } else {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                }
              : null,
          child: Text(
            UserModel.of(context).isLoggedIn() ? "Adicionar ao Carrinho": "Efetuar login",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          textColor: Colors.white,
          color: primaryColor,
        ),
      );

  @override
  void sizeSelected(String selectedSize) {
    setState(() {
      this._selectedSize = selectedSize;
    });
  }

  @override
  String selectedSize() {
    return _selectedSize;
  }
}
