import 'package:flutter/material.dart';
import 'package:nested_navigation_flow_sample/pages/home_screen.dart';
import 'package:nested_navigation_flow_sample/pages/setting_screen.dart';
import 'package:nested_navigation_flow_sample/routes/setup_flow.dart';

const routeHome = '/';
const routeSettings = '/settings';
const routePrefixDeviceSetup = '/setup/';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.blue),
      ),
      onGenerateRoute: (settings) {
        late Widget page;
        if (settings.name == routeHome) {
          page = HomeScreen();
        } else if (settings.name == routeSettings) {
          page = SettingScreen();
        } else if (settings.name!.startsWith(routePrefixDeviceSetup)) {
          final subRoute = settings.name!.substring(
            routePrefixDeviceSetup.length,
          );
          print('•subRoute: $subRoute');
          page = SetupFlow(
            setupPageRoute: subRoute,
          );
        } else {
          throw Exception('Unknown route: ${settings.name}');
        }

        return MaterialPageRoute<dynamic>(
          builder: (context) {
            return page;
          },
          settings: settings,
        );
      },
    ),
  );
}
