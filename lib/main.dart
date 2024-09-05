import 'package:flutter/material.dart';
import 'package:bread_units_beta/MainPages/about_app_class.dart';
import 'package:bread_units_beta/MainPages/dish_base_page.dart';
import 'package:bread_units_beta/MainPages/help.dart';
import 'package:bread_units_beta/MainPages/history_page.dart';
import 'package:bread_units_beta/MainPages/main_page.dart';
import 'package:bread_units_beta/MainPages/product_base_page.dart';
import 'package:bread_units_beta/MainPages/settings_page.dart';
import 'MainPages/Compositions/composition.dart';
import 'MainSetCreate/set_dish.dart';
import 'MainSetCreate/set_navigation.dart';
import 'MainSetCreate/set_product.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bread Units Beta',
      routes: {
        '/': (context) => MainPageClass(),
        'product_base': (context) => ProductBaseClass(),
        'dish_base': (context) => DishBaseClass(),
        'history': (context) => HistoryClass(),
        'settings': (context) => SettingsClass(),
        'help': (context) => HelpClass(),
        'about_app': (context) => AboutAppClass(),
        'composition': (context) => CompositionClass(),
        'set_create': (context) => SetNavigationClass(),
        'set_product': (context) => SetProductClass(),
        'set_dish': (context) => SetDishClass(),
      },
      initialRoute: '/',
    );
  }
}