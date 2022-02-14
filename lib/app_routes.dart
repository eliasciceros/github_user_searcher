import 'package:flutter_modular/flutter_modular.dart';

import 'modules/search/presenter/search/search_page.dart';

final appRoutes = <ModularRoute>[
  ChildRoute(Modular.initialRoute, child: (context, args) => SearchPage()),
];