import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product.pictureUrl,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            product.productName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('type: ${product.productType}'),
          Text('RM ${product.price.toString()}'),
          Text(
            'qty: ${product.quantity.toString()}',
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(16)),
    );
  }
}
