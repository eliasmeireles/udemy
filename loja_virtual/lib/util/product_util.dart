import 'package:flutter/material.dart';
import 'package:loja_virtual/delegate/product_size_select_delegate.dart';
import 'package:loja_virtual/data/product.dart';
import 'package:loja_virtual/util/util.dart';

Widget productTileAndPriceContainer(BuildContext context, Product product,
        {CrossAxisAlignment alignment = CrossAxisAlignment.center,
        double titleFontSize = 14.0,
        double priceTextFontSize = 17.0,
        int maxLines = 3}) =>
    Container(
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Text(
            product.title,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(fontWeight: FontWeight.w500, fontSize: titleFontSize),
          ),
          Text(
            "R\$ ${product.price.toStringAsFixed(2)}",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: priceTextFontSize,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

Widget productSizeOptions(BuildContext context, Product product,
        ProductSizeSelectDelegate delegate) =>
    SizedBox(
      height: 34.0,
      child: GridView(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, mainAxisSpacing: 8.0, childAspectRatio: 0.5),
          children: product.sizes.map((productSize) {
            var borderColor = delegate.selectedSize() == productSize
                ? Theme.of(context).primaryColor
                : Colors.grey[500];
            var borderWidth =
                delegate.selectedSize() == productSize ? 3.0 : 2.0;
            return GestureDetector(
              child: Container(
                width: 50.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: borderColor, width: borderWidth)),
                child: Text(productSize),
              ),
              onTap: () {
                delegate.sizeSelected(productSize);
              },
            );
          }).toList()),
    );

Widget productDescription(Product product) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildSizedBoxDivider(),
        Text(
          "Descrição:",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        buildSizedBoxDivider(height: 10.0),
        Text(product.description, style: TextStyle(fontSize: 16.0),),
        buildSizedBoxDivider(),
      ],
    );
