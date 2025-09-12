import 'package:flutter/material.dart';
import '../theme.dart';

class CustomDrawer extends StatelessWidget {
  final String currentRoute;
  const CustomDrawer({Key? key, this.currentRoute = '/'}) : super(key: key);

  Widget _menuTile(BuildContext context, IconData icon, String title, String route) {
    final bool active = currentRoute == route;
    return GestureDetector(
      onTap: () {
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.of(context).pushReplacementNamed(route);
        } else {
          Navigator.of(context).pop();
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          gradient: active
              ? LinearGradient(colors: [kAccentLight.withOpacity(0.15), kPrimaryLight.withOpacity(0.12)])
              : null,
          color: active ? Colors.white : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: active
              ? [
            BoxShadow(color: kPrimaryLight.withOpacity(0.12), blurRadius: 12, offset: Offset(0, 6)),
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4, offset: Offset(0, 2)),
          ]
              : [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: active ? kPrimaryLight.withOpacity(0.14) : kPrimaryLight.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: active ? kPrimaryLight : Colors.black54),
            ),
            SizedBox(width: 12),
            Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kBackground,
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [kAccentLight, kPrimaryLight]),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(color: kPrimaryLight.withOpacity(0.2), blurRadius: 10, offset: Offset(0,4))],
                    ),
                    child: Icon(Icons.account_balance_wallet, color: Colors.white),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Finance', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Dashboard', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: [
                  _menuTile(context, Icons.dashboard, 'Overview', '/'),
                  _menuTile(context, Icons.analytics, 'Analytics', '/'), // same as dashboard
                  _menuTile(context, Icons.swap_horiz, 'Transactions', '/transactions'),
                  _menuTile(context, Icons.pie_chart, 'Reports', '/reports'),
                  _menuTile(context, Icons.group, 'Users', '/users'),
                  _menuTile(context, Icons.settings, 'Settings', '/settings'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(radius: 20, backgroundColor: kPrimaryLight, child: Icon(Icons.person, color: Colors.white)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Jane Doe', style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('Admin', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
