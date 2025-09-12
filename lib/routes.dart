import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/users_screen.dart';
import 'screens/settings_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (ctx) => const DashboardScreen(),
  '/transactions': (ctx) => TransactionsScreen(),
  '/reports': (ctx) => ReportsScreen(),
  '/users': (ctx) => UsersScreen(),
  '/settings': (ctx) => SettingsScreen(),
};
