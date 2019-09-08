import 'package:flutter/material.dart';
import 'package:loja_virtual/data/product.dart';
import 'package:loja_virtual/tiles/base_product_tile.dart';
import 'package:loja_virtual/util/product_util.dart';

class ProductListViewTile extends BaseProductTile {
  ProductListViewTile(Product product) : super(product);

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
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
                height: 250.0,
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: productTileAndPriceContainer(context, product,
                    alignment: CrossAxisAlignment.start, maxLines: 5),
              )
            ),
          ],
        ),
      ),
    );
  }
}
