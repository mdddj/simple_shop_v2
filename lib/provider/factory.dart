

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'user.dart';

///状态管理
final providers = <SingleChildWidget>[
  ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider())
];
