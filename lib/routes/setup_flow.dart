import 'package:flutter/material.dart';
import 'package:nested_navigation_flow_sample/pages/finished_page.dart';
import 'package:nested_navigation_flow_sample/pages/select_device_page.dart';
import 'package:nested_navigation_flow_sample/pages/waiting_page.dart';

const routeDeviceSetupStart = '/setup/$routeDeviceSetupStartPage';
const routeDeviceSetupStartPage = 'find_devices';
const routeDeviceSetupSelectDevicePage = 'select_device';
const routeDeviceSetupConnectingPage = 'connecting';
const routeDeviceSetupFinishedPage = 'finished';

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
  final _navigationKey = GlobalKey<NavigatorState>();

  void _onDiscoveryComplete() {
    _navigationKey.currentState!.pushNamed(
      routeDeviceSetupSelectDevicePage,
    );
  }

  void _onDeviceSelected(String deviceId) {
    _navigationKey.currentState!.pushNamed(
      routeDeviceSetupConnectingPage,
    );
  }

  void _onConnectionEstablished() {
    _navigationKey.currentState!.pushNamed(
      routeDeviceSetupFinishedPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExitDesired,
      child: Scaffold(
        appBar: _buildFlowAppBar(),
        body: Navigator(
          key: _navigationKey,
          initialRoute: widget.setupPageRoute,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case routeDeviceSetupStartPage:
        page = WaitingPage(
          message: 'Searching for nearby bulb...',
          onWaitComplete: _onDiscoveryComplete,
        );
        break;
      case routeDeviceSetupSelectDevicePage:
        page = SelectDevicePage(onDeviceSelected: _onDeviceSelected);
        break;
      case routeDeviceSetupConnectingPage:
        page = WaitingPage(
          message: 'Connecting...',
          onWaitComplete: _onConnectionEstablished,
        );
        break;
      case routeDeviceSetupFinishedPage:
        page = FinishedPage(onFinishPressed: _exitSetup);
        break;
    }

    return MaterialPageRoute(
        builder: (context) {
          return page;
        },
        settings: settings);
  }

  PreferredSizeWidget _buildFlowAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _onExitPressed,
        icon: Icon(Icons.chevron_left),
      ),
      title: Text('Bulb Setup'),
    );
  }

  Future<void> _onExitPressed() async {
    final isConfirmed = await _isExitDesired();
    if (isConfirmed && mounted) {
      _exitSetup();
    }
  }

  Future<bool> _isExitDesired() async {
    return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Are you sure?'),
                content: Text(
                    'If you exit device setup, your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // AlertControllerをpop
                      Navigator.of(context).pop(true);
                    },
                    child: Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text('Stay'),
                  ),
                ],
              );
            }) ??
        false;
  }

  void _exitSetup() {
    Navigator.of(context).pop();
  }
}
