import 'package:flutterfauth/ui/home/home.dart';
import 'package:sailor/sailor.dart';

class Routes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoute(SailorRoute(
      name: '/home',
      builder: (context, args, paramMap) {
        return HomePage();
      },
    ));
  }
}
