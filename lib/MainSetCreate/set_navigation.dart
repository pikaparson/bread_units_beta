import 'package:bread_units_beta/MainSetCreate/set_dish.dart';
import 'package:bread_units_beta/MainSetCreate/set_product.dart';
import 'package:flutter/material.dart';

class SetNavigationClass extends StatefulWidget {
  const SetNavigationClass({super.key});
  @override
  State<SetNavigationClass> createState() => _SetNavigationClass();
}

class _SetNavigationClass extends State<SetNavigationClass> {

  var _currentPage = 1;
  final List<Widget> _pages = [
    SetProductClass(),
    SetDishClass(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: _pages.elementAt(_currentPage)
      ),

      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.blueAccent[100],
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.apple),
              backgroundColor: Colors.blueAccent[100],
              label: 'Продукты'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            backgroundColor: Colors.blueAccent[100],
            label: 'Блюда',
          )
        ],
        currentIndex: _currentPage,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white,
        //fixedColor: Colors.white,
        onTap: (int intIndex) {
          setState(() {
            _currentPage = intIndex;
          });
        },
      ),
    );
  }
}
