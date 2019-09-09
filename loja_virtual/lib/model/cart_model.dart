import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/data/cart_product.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;
  List<CartProduct> products = [];

  CartModel(this.user);

  void addCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((cartDocument) {
      cartProduct.id = cartDocument.documentID;
      products.add(cartProduct);
      notifyListeners();
    });
  }

  void removeItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.id)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }
}
