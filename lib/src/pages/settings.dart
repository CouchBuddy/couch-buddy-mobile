import 'package:flutter/material.dart';

import '../utils/preferences.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: preferences.serverUrl,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                labelText: 'Server address',
                hintText: 'http://192.168.1.2'
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a value';
                }

                try {
                  Uri.parse(value);
                } catch (e) {
                  return 'Invalid URL';
                }

                return null;
              },
              onSaved: (val) => preferences.serverUrl = val,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Settings have been saved!')));
                  }
                },
                child: Text('Save'),
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
