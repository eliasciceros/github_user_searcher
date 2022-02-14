import 'package:flutter_modular/flutter_modular.dart';

import 'app_binds.dart';
import 'app_routes.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => appBinds;

  @override
  List<ModularRoute> get routes => appRoutes;
}