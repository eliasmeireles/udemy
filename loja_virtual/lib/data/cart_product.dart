import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/data/product.dart';

class CartProduct {
  String id;
  String category;
  String productId;
  String productSize;
  int quantity;
  Product product;

  CartProduct.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    category = snapshot.data["category"];
    productId = snapshot.data["productId"];
    productSize = snapshot.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "productId": productId,
      "productSize": "size",
      "quantity": quantity,
      "product": product.toResumedMap()
    };
  }
}
