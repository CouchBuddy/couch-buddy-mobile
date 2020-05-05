import 'package:couch_buddy/src/resources/discovery.dart';
import 'package:flutter/material.dart';

import '../utils/preferences.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

const kDiscoveryRetrials = 5;

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  bool searchingServer = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startDiscovery() async {
    try {
      setState(() { searchingServer = true; });

      for (int i = 0; i < kDiscoveryRetrials; i++) {
        final server = await Discovery.start();

        if (server != null) {
          preferences.serverUrl = server.toString();
          return;
        }
      }
    } catch (e) {
    } finally {
      setState(() { searchingServer = false; });
    }
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
                hintText: 'http://192.168.1.2:3000',
                suffixIcon: !searchingServer
                ? IconButton(
                    icon: Icon(Icons.network_check),
                    onPressed: () => startDiscovery(),
                    tooltip: 'Search server',
                  )
                : Container(
                    padding: EdgeInsets.all(12.0),
                    height: 24.0,
                    width: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)
                  ),
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
