import 'package:ekolabweb/src/ui/login.dart';
import 'package:ekolabweb/src/ui/main/admin/main_admin.dart';
import 'package:ekolabweb/src/ui/forgot_password.dart';
import 'package:ekolabweb/src/ui/main/main_menu.dart';
import 'package:ekolabweb/src/ui/new_password.dart';
import 'package:ekolabweb/src/ui/not_found.dart';
import 'package:ekolabweb/src/ui/pre_login_reg.dart';
import 'package:ekolabweb/src/ui/preload_auth.dart';
import 'package:ekolabweb/src/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

import 'ui/splash_screen.dart';
import 'utilities/string.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: colorBase),
          fontFamily: 'Regular'),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(),
      ),
      initialRoute: '/splash',
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name == '/main_menu') {
      return _buildRoute(settings, MainMenu());
    } else if (settings.name == '/main_admin') {
      return _buildRoute(settings, MainAdmin());
    } else if (settings.name == '/login_menu') {
      return _buildRoute(settings, Login());
    } else if (settings.name == '/register_menu') {
      return _buildRoute(settings, Register());
    } else if (settings.name == '/forgot_pass') {
      return _buildRoute(settings, ForgotPass());
    } else if (settings.name!.contains('/new_password')) {
      if (Jwt.isExpired(Uri.base.pathSegments.last)) {
        return _buildRoute(settings, NotFound());
      } else {
        return _buildRoute(settings, NewPassword(Uri.base.pathSegments.last));
      }
    } else if (settings.name == '/splash') {
      return _buildRoute(settings, SplashScreen());
    } else if (settings.name == "/prelogin") {
      return _buildRoute(settings, PreLoginRegister());
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
