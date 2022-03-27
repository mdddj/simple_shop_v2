import 'package:after_layout/after_layout.dart';
import 'package:dataoke_sdk/model/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../widget/loading/loading_more_custom_indicator.dart';
import '../../widget/product/wall_product_card.dart';
import 'repository.dart';


///产品列表
class ProductListComponents extends StatefulWidget {
  @override
  _ProductListComponentsState createState() => _ProductListComponentsState();
}

class _ProductListComponentsState extends State<ProductListComponents>
    with AfterLayoutMixin<ProductListComponents> {
  late var _repository;

  @override
  void initState() {
    _repository = ProductListRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingMoreSliverList(
      SliverListConfig<Product>(
          extendedListDelegate:
          SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            collectGarbage: (List<int> indexes) {
              indexes.forEach((index) {
                final provider = ExtendedNetworkImageProvider(
                  _repository[index].mainPic,
                );
                provider.evict();
              });
            },
          ),
          itemBuilder: _builder,
          sourceList: _repository,
          indicatorBuilder: CustomIndicator.instance.loadingMoreStyle,
          padding: EdgeInsets.all(12)),
    );
  }

  /// 子组件布局
  Widget _builder(BuildContext context, Product item, int index) {
    return Container(
      child: WallProductCard(product: item),
    );
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {}
}
