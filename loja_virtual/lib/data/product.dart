import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String category;
  String title;
  String description;
  double price;
  List images;
  List sizes;

  Product.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data['title'];
    description = snapshot.data['description'];
    price = snapshot.data['price'];
    images = snapshot.data['images'];
    sizes = snapshot.data['sizes'];
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "title": title,
      "descricao": description,
      "price": price
    };
  }
}
