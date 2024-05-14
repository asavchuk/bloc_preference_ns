import 'package:bloc_preference_ns/models/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/preference_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PreferenceProvider>(context).bloc;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings'),
          leading: GestureDetector(
            child: const Icon(CupertinoIcons.back),
            onTap: () {
              bloc.savePreferences();
              Navigator.of(context).pop();
            },
          )),
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Dark Mode'),
                  StreamBuilder<Brightness>(
                      stream: bloc.brightness,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Container();
                        return Switch(
                          value: (snapshot.data == Brightness.light) ? false : true,
                          onChanged: (bool value) {
                            if (value) {
                              bloc.changeBrightness(Brightness.dark);
                            } else {
                              bloc.changeBrightness(Brightness.light);
                            }
                          },
                        );
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Primary Color'),
                  StreamBuilder<ColorModel>(
                      stream: bloc.primaryColor,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return Container();
                        return Slider(
                          value: snapshot.data!.index,
                          min: 0.0,
                          max: 3.0,
                          divisions: 3,
                          label: snapshot.data!.name,
                          onChanged: (double value) {
                            bloc.changePrimaryColor(bloc.indexToPrimaryColor(value));
                            print('primary color should change');
                          },
                        );
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
