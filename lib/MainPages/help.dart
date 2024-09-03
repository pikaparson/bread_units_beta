import 'package:flutter/material.dart';

class HelpClass extends StatefulWidget {
  const HelpClass({super.key});

  @override
  State<HelpClass> createState() => _HelpClassState();
}

class _HelpClassState extends State<HelpClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _helpAppBar(),
      body: _helpBody(),
      drawer: _helpDrawer(),
    );
  }

  AppBar _helpAppBar() {
    return AppBar(
      title: Text('Справка'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
    );
  }

  Widget _helpBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
        child: SafeArea(
            child: Column(
              children: [
                Text(_aboutBU(), style: TextStyle(fontSize: 20),),
                SizedBox(height: 12,),
                Text(_aboutCalculate(), style: TextStyle(fontSize: 20),),
                SizedBox(height: 12,),
                Text(_aboutAppPartOne(), style: TextStyle(fontSize: 20),),
                SizedBox(height: 12,),
                Text(_aboutAppPartTwo(), style: TextStyle(fontSize: 20),)
              ],
            )
        ),
      )
    );
  }

  String _aboutBU() {
    return '      Хлебные единицы (ХЕ) — это показатель, используемый для учета количества углеводов в продуктах питания. Одна ХЕ соответствует примерно 10-12 граммам углеводов. Этот показатель широко используется при составлении диет для людей с диабетом, чтобы правильно рассчитывать дозу инсулина и поддерживать уровень сахара в крови в пределах нормы.';
  }

  String _aboutCalculate() {
    return '      Существует несколько методов расчета хлебных единиц. Например, для натурального йогурта с содержанием углеводов 6 г на 100 г продукта и объемом 120 г, расчет ХЕ будет следующим: 6 / 100 * 120 / 12 = 0,6 ХЕ. Таким образом, потребление одной упаковки такого йогурта добавит примерно 0,6 ХЕ к суточному рациону.';
  }

  String _aboutAppPartOne() {
    return '      Приложение Bread Units (BU) разработано для автоматического расчета общего количества ХЕ и калорий в блюде. Пользователи могут вводить вес продуктов и получать автоматический расчет ХЕ. Приложение также позволяет создавать карточки продуктов в базе данных и рассчитывать состав сложных блюд, таких как сырники, с учетом всех ингредиентов.';
  }

  String _aboutAppPartTwo() {
    return '      Для вычисления углеводов во время приема пищи пользователи выбирают продукты из списка в приложении, вводят их вес, и приложение автоматически рассчитывает количество хлебных единиц. Это упрощает процесс планирования диеты и контроль уровня сахара в крови, особенно для людей с диабетом, которым необходимо тщательно следить за потреблением углеводов.';
  }

  Drawer _helpDrawer() {
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
            title: Text('Справка', style: TextStyle(color: Colors.blueAccent[100]),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.blueAccent[100]),
            title: Text('О разработчиках'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'about_app');
            },
          ),
        ],
      ),
    );
  }
}


