import 'package:dd_models/models/product.dart';
import 'package:flutter/material.dart';

import '../product/simple_card.dart';

class SimpleColumnProducts extends StatelessWidget {
  final List<Product>? products;

  const SimpleColumnProducts({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: _builder,
        itemCount: products!.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics());
  }

  Widget _builder(_, index) {
    return SimpleCard(
      product: products![index],
    );
  }
}
