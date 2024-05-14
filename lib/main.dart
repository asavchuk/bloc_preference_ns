import 'package:bloc_preference_ns/models/color.dart';
import 'package:bloc_preference_ns/providers/preference_provider.dart';
import 'package:bloc_preference_ns/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PreferenceProvider(),
      child: Consumer<PreferenceProvider>(
        builder: (context, provider, child) {
          return StreamBuilder<Brightness>(
              stream: provider.bloc.brightness,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return StreamBuilder<ColorModel>(
                    stream: provider.bloc.primaryColor,
                    builder: (context, snapshotPrimaryColor) {
                      if (!snapshotPrimaryColor.hasData) {
                        print('no Primary Color detected');
                        return Container();
                      }
                      print('building on Primary Color change');
                      return MaterialApp(
                        title: 'Flutter Demo',
                        theme: ThemeData(
                          primaryColor: snapshotPrimaryColor.data!.color,
                          brightness: snapshot.data,
                        ),
                        home: const Home(),
                      );
                    });
              });
        },
      ),
    );
  }
}
