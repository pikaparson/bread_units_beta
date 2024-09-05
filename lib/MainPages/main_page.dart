import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DataBase/data_base.dart';

class MainPageClass extends StatefulWidget {
  const MainPageClass({super.key});

  @override
  State<MainPageClass> createState() => _MainPageClassState();
}

class _MainPageClassState extends State<MainPageClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _mainPageAppBar(),
      body: _mainPageBody(),
      drawer: _mainPageDrawer(),
      floatingActionButton: _mainPageFloatingActionButton(),
    );
  }
  AppBar _mainPageAppBar() {
    return AppBar(
      title: Text('Калькулятор XE'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
    );
  }

  Row _mainPageBU() {
    double bu = 0.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$bu ХЕ', style: TextStyle(fontSize: 34),)
      ],
    );
  }

  Padding _mainPageFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: FloatingActionButton(
        onPressed: () {
          _showForm(null);
        },
        child: Icon(Icons.add, color: Colors.black,),
        backgroundColor: Colors.blueAccent[100],
      ),
    );
  }

  Drawer _mainPageDrawer() {
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
            leading: Icon(Icons.edit_note_outlined, color: Colors.blueAccent[100]),
            title: Text('Запись приема пищи', style: TextStyle(color: Colors.blueAccent[100]),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.local_dining, color: Colors.blueAccent[100]),
            title: Text('База блюд'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'dish_base');
            },
          ),
          ListTile(
            leading: Icon(Icons.apple, color: Colors.blueAccent[100]),
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
            title: Text('О разработчиках'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'about_app');
            },
          ),
        ],
      ),
    );
  }

  Column _mainPageBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _mainPageBU(),
          flex: 1,
        ),
        Expanded(
          child: _mainPageCards(),
          flex: 6,
        ),
      ],
    );
  }

  ListView _mainPageCards() {
    return ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) => Card (
          color: Colors.grey[100],
          margin: const EdgeInsets.all(15),
          child: ListTile(
            title: Text('${_journals[index]['name']}'),
            trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _showForm(_journals[index]['id']);
                          });
                        },
                        icon: const Icon(Icons.edit)
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _deleteItem(_journals[index]['id']);
                          });
                        },
                        icon: const Icon(Icons.delete)
                    ),
                  ],
                )
            ),
          ),
        )
    );
  }

  int idHelper = 0;
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  Future<void> _refreshJournals() async {
    final data = await SQLhelper().getSetItem();
    setState(() {
      if(data != null)
      {
        _journals = data;
      }
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  final TextEditingController _nameController = TextEditingController();
  void _showForm(int? id) async {
    //если id == 0, то шторка для создания элемента
    if (id != null) {
      final existingJournal = _journals.firstWhere((element) => element['id'] == id);
      _nameController.text = existingJournal['name'];
    }
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        elevation: 5,
        backgroundColor: Colors.white,
        isDismissible: false,
        builder: (_) => Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              // это предотвратит закрытие текстовых полей программной клавиатурой
              bottom: MediaQuery.of(context).viewInsets.bottom + 275,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Название приема пищи',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Ввод названия приема пищи',
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _controlName();
                    if (id == null){
                      await _addItem();
                    }
                    else if (id != null) {
                      await _updateItem(id);
                    }
                    // Очистим поле
                    _nameController.text = '';
                    await _refreshJournals();
                    // Закрываем шторку
                    if (!mounted) return;
                    Navigator.of(context).pop();
                    setState(() {
                      Navigator.pushNamedAndRemoveUntil(context, 'set_create', (route) => false);
                    });
                  },
                  child: Text('Продолжить', style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Отмена', style: TextStyle(color: Colors.black),))
              ],
            )
        )
    );
  }

//добавить имя блюда в контроллер
  Future<void> _controlName() async {
    await SQLhelper().controlInsertSetName(_nameController.text);
  }
  //Вставить новый объект в базу данных
  Future<void> _addItem() async {
    await SQLhelper().createSetItem(_nameController.text);
    await _refreshJournals();
  }
  //Обновить существующий объект
  Future<void> _updateItem(int id) async {
    await SQLhelper().updateSetItem(id, _nameController.text);
    await _refreshJournals();
  }
  //Удалить существующий объект
  void _deleteItem(int id) async{
    await SQLhelper().deleteSetItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Успешное удаление объекта!'),
    ));
    await _refreshJournals();
  }

}