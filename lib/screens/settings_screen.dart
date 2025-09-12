import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(currentRoute: '/settings'),
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(child: ListTile(title: Text('Profile Settings'), trailing: Icon(Icons.chevron_right))),
            Card(child: ListTile(title: Text('Notifications'), trailing: Switch(value: true, onChanged: (_) {}))),
            Card(child: ListTile(title: Text('Theme'), trailing: Text('Light'))),
          ],
        ),
      ),
    );
  }
}
