import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(16, (index) {
            return Container(
                width: double.infinity,
                height: 54,
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFF222222),
                ));
          }),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Settings'),
    );
  }
}
