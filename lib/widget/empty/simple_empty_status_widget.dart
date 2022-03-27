import 'package:flutter/material.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String? title;

  const CustomEmptyWidget({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.assessment_outlined),
        const SizedBox(
          height: 12,
        ),
        Text(title ?? '暂无数据!'),
      ],
    );
  }
}
