import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(currentRoute: '/users'),
      appBar: AppBar(title: Text('Users')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(child: ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('Jane Doe'), subtitle: Text('Admin'))),
            Card(child: ListTile(leading: CircleAvatar(child: Icon(Icons.person)), title: Text('John Smith'), subtitle: Text('User'))),
          ],
        ),
      ),
    );
  }
}
