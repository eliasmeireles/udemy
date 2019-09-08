import 'package:flutter/material.dart';
import 'package:loja_virtual/data/product.dart';
import 'package:loja_virtual/screens/product_screen.dart';

abstract class BaseProductTile extends StatelessWidget {
  final Product product;

  BaseProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return bodyBuilder(context);
  }

  void onProductTaped(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ProductScreen(product))
    );
  }

  Widget bodyBuilder(BuildContext context);
}
