import 'package:bloc_preference_ns/widgets/settings.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: OutlinedButton(
          child: const Text('Settings'),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Settings()));
          },
        ),
      ),
    );
  }
}
