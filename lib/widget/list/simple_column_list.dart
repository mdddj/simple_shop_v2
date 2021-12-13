import 'package:dataoke_sdk/model/product.dart';
import '../product/simple_card.dart';
import 'package:flutter/material.dart';

class SimpleColumnProducts extends StatelessWidget {
  final List<Product>? products;

  const SimpleColumnProducts({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: _builder,
          itemCount: products!.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics()),
    );
  }

  Widget _builder(_, index) {
    return Container(
      child: SimpleCard(
        product: products![index],
      ),
    );
  }
}
