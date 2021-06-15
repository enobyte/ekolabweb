import 'package:ekolabweb/src/ui/login.dart';
import 'package:ekolabweb/src/ui/main/main_menu.dart';
import 'package:ekolabweb/src/ui/register.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)),
          fontFamily: 'Regular'),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Login(),
      ),
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name == '/main_menu') {
      return _buildRoute(settings, MainMenu());
    } else if (settings.name == '/login_menu') {
      return _buildRoute(settings, Login());
    } else if (settings.name == '/register_menu') {
      return _buildRoute(settings, Register());
    }
    return null;
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
