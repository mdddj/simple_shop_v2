
import 'package:provider/provider.dart';

import 'app.dart';

///状态管理
final providers = [
  ChangeNotifierProvider(create: (_)=>AppProvider())
];
