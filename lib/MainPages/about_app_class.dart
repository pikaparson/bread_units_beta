import 'package:flutter/material.dart';

class AboutAppClass extends StatefulWidget {
  const AboutAppClass({super.key});

  @override
  State<AboutAppClass> createState() => _AboutAppClassState();
}

class _AboutAppClassState extends State<AboutAppClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _aboutAppAppBar(),
      body: _aboutAppBody(),
      drawer: _aboutAppDrawer(),
    );
  }

  AppBar _aboutAppAppBar() {
    return AppBar(
      title: Text('О приложении'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
    );
  }

  Widget _aboutAppBody() {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 15, top: 35),
      child: Column(
        children: [
          Text(_aboutAppText(), style: TextStyle(fontSize: 16),)
        ],
      ),
    );
  }

  String _aboutAppText() {
    return 'Приложение разработано командой ГПО.\n\nАвторы идеи: Качаева С.А., Глотов Д.Д.\n\nРазработчик: Качаева С.А.\n\nПрототип дизайна: Дей Д.В.\n\nМатериальная поддержка разработчика:\nГлотов Д.Д.';
  }

  Drawer _aboutAppDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.blueAccent[100]
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: Colors.black54, size: 70,),
                  Text('Качаева Софья'),
                  Text('email: sonna1012@gmail.com')
                ],
              )
          ),
          ListTile(
            leading: Icon(
                Icons.edit_note_outlined, color: Colors.blueAccent[100]),
            title: Text('Запись приема пищи'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.local_dining, color: Colors.blueAccent[100]),
            title: Text('База блюд'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'dish_base');
            },
          ),
          ListTile(
            leading: Icon(
                Icons.apple, color: Colors.blueAccent[100]),
            title: Text('База продуктов'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'product_base');
            },
          ),
          ListTile(
            leading: Icon(Icons.menu_book_rounded, color: Colors.blueAccent[100]),
            title: Text('История'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'history');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.blueAccent[100]),
            title: Text('Настройки'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.question_mark, color: Colors.blueAccent[100]),
            title: Text('Справка'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'help');
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.blueAccent[100]),
            title: Text('О разработчиках', style: TextStyle(color: Colors.blueAccent[100]),),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
