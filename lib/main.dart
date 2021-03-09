import 'package:flutter/material.dart';

const routeHome = '/';
const routeSettings = '/settings';
const routePrefixDeviceSetup = '/setup/';
const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF222222),
                ),
                child: Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 175,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Add your first bulb',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(routeDeviceSetupStart);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Welcome'),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, routeSettings);
          },
        ),
      ],
    );
  }
}

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Settings'),
    );
  }
}

class SetupFlow extends StatefulWidget {
  const SetupFlow({
    Key? key,
    required this.setupPageRoute,
  });

  final String setupPageRoute;

  @override
  _SetupFlowState createState() => _SetupFlowState();
}

class _SetupFlowState extends State<SetupFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildFlowAppBar(),
      body: SizedBox(),
    );
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      title: Text('Bulb Setup'),
    );
  }
}
