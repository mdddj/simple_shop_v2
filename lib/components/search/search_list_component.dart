import 'package:dataoke_sdk/model/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

import '../../constant/app_constant.dart';
import '../../constant/color_constant.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';
import '../../widget/image/simple_image.dart';
import '../../widget/loading/loading_more_custom_indicator.dart';
import 'repository.dart';

class SearchListComponent extends StatefulWidget {
  final SearchRepostory searchRepostory;
  final ScrollController? controller;

  const SearchListComponent(
      {Key? key, required this.searchRepostory, this.controller})
      : super(key: key);

  @override
  _SearchListComponentState createState() => _SearchListComponentState();
}

class _SearchListComponentState extends State<SearchListComponent> {
  @override
  Widget build(BuildContext context) {
    return LoadingMoreList(ListConfig<Product>(
        itemBuilder: _renderItem,
        sourceList: widget.searchRepostory,
        controller: widget.controller,
        indicatorBuilder: CustomIndicator.instance.loadingMoreStyle,
        extendedListDelegate: ExtendedListDelegate(
          collectGarbage: (List<int> indexes) {
            indexes.forEach((index) {
              final provider = ExtendedNetworkImageProvider(
                widget.searchRepostory[index].mainPic!,
              );
              provider.evict();
            });
          },
        )));
  }

  /// 渲染每个卡片样式
  Widget _renderItem(_, Product item, int index) {
    final _imageSize = 80.0;
    final _radius = BorderRadius.circular(5);
    return GestureDetector(
      onTap: () => WidgetUtil.instance.detailPage(product: item),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhysicalModel(
          color: Colors.grey[100]!,
          elevation: 3,
          borderRadius: _radius,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadded, vertical: kDefaultPadded),
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: _radius),
            child: Row(
              children: [
                SizedBox(
                  width: _imageSize,
                  height: _imageSize,
                  child: SimpleImage(
                    url: item.mainPic!,
                  ),
                ),
                SizedBox(
                  width: kDefaultPadded,
                ),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: _imageSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.dtitle}',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                        Text(
                          '券后 ${'${item.actualPrice}'.coverRmbPrice}',
                          style:
                              TextStyle(color: kPriceValueColor, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
