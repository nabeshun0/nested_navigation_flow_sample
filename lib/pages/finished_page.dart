import 'package:flutter/material.dart';

class FinishedPage extends StatelessWidget {
  const FinishedPage({
    Key? key,
    required this.onFinishPressed,
  });

  final VoidCallback onFinishPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
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
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Bulb added!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.resolveWith(
                      (states) {
                        return const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12);
                      },
                    ),
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return const Color(0xFF222222);
                    }),
                    shape: MaterialStateProperty.resolveWith((states) {
                      return StadiumBorder();
                    }),
                  ),
                  onPressed: onFinishPressed,
                  child: Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
