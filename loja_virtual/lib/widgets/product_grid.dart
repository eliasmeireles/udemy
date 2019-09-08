import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/data/product.dart';
import 'package:loja_virtual/widgets/base_product_widget.dart';
import 'package:loja_virtual/tiles/product_grid_tile.dart';

class ProductGrid extends BaseProductWidget {

  ProductGrid(QuerySnapshot snapshot) : super(snapshot);

  @override
  Widget bodyBuilder(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.65,
        ),
        itemCount: snapshot.documents.length,
        itemBuilder: (context, index) {
          return ProductGridTile(Product.fromDocument(snapshot.documents[index]));
        });
  }
}
