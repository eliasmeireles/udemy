import 'package:flutter/material.dart';
import 'package:loja_virtual/data/product.dart';
import 'package:loja_virtual/tiles/base_product_tile.dart';
import 'package:loja_virtual/util/product_util.dart';

class ProductGridTile extends BaseProductTile {
  ProductGridTile(Product product) : super(product);

  @override
  Widget bodyBuilder(BuildContext context) {
    return InkWell(
      onTap: () {
        onProductTaped(context);
      },
      child: Card(
        elevation: 10,
        borderOnForeground: true,
        semanticContainer: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.9,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
                child: productTileAndPriceContainer(context, product,
                    maxLines: 1)),
          ],
        ),
      ),
    );
  }
}
