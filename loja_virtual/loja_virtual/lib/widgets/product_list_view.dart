import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/data/product.dart';
import 'package:loja_virtual/tiles/product_list_view_tile.dart';
import 'package:loja_virtual/widgets/base_product_widget.dart';

class ProductListView extends BaseProductWidget {
  ProductListView(QuerySnapshot snapshot) : super(snapshot);

  @override
  Widget bodyBuilder(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: snapshot.documents.length,
        itemBuilder: (context, index) {
          return ProductListViewTile(
              Product.fromDocument(snapshot.documents[index]));
        });
  }
}
