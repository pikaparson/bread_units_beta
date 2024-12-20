import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../DataBase/data_base.dart';
import 'package:searchfield/searchfield.dart';

class ProductBaseClass extends StatefulWidget {
  const ProductBaseClass({super.key});

  @override
  State<ProductBaseClass> createState() => _ProductBaseClassState();
}

class _ProductBaseClassState extends State<ProductBaseClass> {



  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: _productBaseAppBar(),
          body: _productBaseBody(),
          floatingActionButton: _productBaseFloatingActionButton(),
          drawer: _productBaseDrawer(),
        ),
    );
  }

  AppBar _productBaseAppBar() {
    return AppBar(
      title: Text('База продуктов'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
    );
  }

  void _filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Map<String, dynamic>> dummySearchList = List.from(_journals);
      List<Map<String, dynamic>> dummyListData = [];
      for (var item in dummySearchList) {
        if (item["name"].toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        filteredItems.clear(); // Можно оставить
        filteredItems.addAll(dummyListData); // Или присвоить новое значение
      });
      return;
    } else {
      setState(() {
        filteredItems = List.from(_journals); // Убедитесь, что _journals изменяемо
      });
    }
  }

  List<Map<String, dynamic>> filteredItems = [];

  Widget _productBaseBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            onChanged: (value) => _filterSearchResults(value),
            decoration: const InputDecoration(
              hintText: "Поиск продукта по названию",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded( // Используем Expanded здесь
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) => Card(
                color: Colors.grey[100],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(
                      '${filteredItems[index]['name']}\n${filteredItems[index]['carbohydrates']}г углеводов на 100г'),
                  subtitle: FutureBuilder<String>(
                    future: SQLhelper().getProductBU(filteredItems[index]['id']),
                    builder: (context, snapshot) {
                      return Text('${snapshot.data}');
                    },
                  ),
                  trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          returnEditIcon(filteredItems[index]['main'], index),
                          returnDeleteIcon(filteredItems[index]['main'], index),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget returnDeleteIcon(int help, int index) {
    if(help != 1) {
      return IconButton(
          onPressed: () {
            setState(() {
              _deleteItem(filteredItems[index]['id']);
            });
          },
          icon: const Icon(Icons.delete)
      );
    }
    return SizedBox.shrink();
  }
  Widget returnEditIcon(int help, int index) {
    if(help != 1) {
      return IconButton(
          onPressed: () {
            setState(() {
              _showForm(filteredItems[index]['id']);
            });
          },
          icon: const Icon(Icons.edit)
      );
    }
    return SizedBox.shrink();
  }

  Widget _productBaseFloatingActionButton() {
    return Stack(
      children: <Widget>[
        // Другие виджеты вашего интерфейса
        Positioned(
          right: 15, // Установите отступ от правого края
          bottom: 45, // Установите отступ от нижнего края
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _showForm(null);
              });
            },
            backgroundColor: Colors.blueAccent[100],
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Drawer _productBaseDrawer() {
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
            leading: Icon(Icons.apple, color: Colors.blueAccent[100]),
            title: Text('База продуктов', style: TextStyle(color: Colors.blueAccent[100]),),
            onTap: null,
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


  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  Future<void> _refreshJournals() async {
    final data = await SQLhelper().getProductItem();
    setState(() {
      if (data != null) {
        _journals = data; // Преобразуем QueryResultSet в список
        filteredItems = List<Map<String, dynamic>>.from(_journals);
      }
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  double carbohydrates = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _carbohydratesController = TextEditingController();

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal = _journals.firstWhere((element) =>
      element['id'] == id);
      _nameController.text = existingJournal['name'];
      _carbohydratesController.text =
          existingJournal['carbohydrates'].toString();
    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        isDismissible: false,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 100,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _nameController,
                cursorColor: Colors.blueAccent[100],
                decoration: const InputDecoration(
                  labelText: 'Название продукта',
                  labelStyle: TextStyle(color: Colors.black),
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
              TextField(
                controller: _carbohydratesController,
                cursorColor: Colors.blueAccent[100],
                keyboardType: TextInputType.numberWithOptions(
                    decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                decoration: const InputDecoration(
                  labelText: 'Количество углеводов',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(4.0)),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (double.parse('${_carbohydratesController.text}') >
                      100 ||
                      double.parse('${_carbohydratesController.text}') <
                          0) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('Ошибка'),
                              content: Text(
                                  'Было введено неправильное количество углеводов - ${_carbohydratesController
                                      .text}. \n Количество углеводов должно не превышать 100 грамм, но и не быть меньше нуля.'),
                              actions: [ElevatedButton(onPressed: () {
                                Navigator.of(context).pop();
                              }, child: Text('Выйти'))
                              ]
                          );
                        }
                    );
                  } else if (id == null) {
                    await _addItem();
                    // Очистим поле
                    _nameController.text = '';
                    _carbohydratesController.text = '';
                    carbohydrates = 0;
                    await _refreshJournals();
                    // Закрываем шторку
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  } else if (id != null) {
                    await _updateItem(id);
                    // Очистим поле
                    _nameController.text = '';
                    _carbohydratesController.text = '';
                    carbohydrates = 0;
                    await _refreshJournals();
                    // Закрываем шторку
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  }
                },
                child: Text(
                    'Ок', style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Отмена', style: TextStyle(color: Colors.black),))
            ],
          ),
        )
    );
  }

  //Вставить новый объект в базу данных
  Future<void> _addItem() async {
    carbohydrates = double.parse('${_carbohydratesController.text}');
    await SQLhelper().createProductItem(_nameController.text, carbohydrates, 0);
    await _refreshJournals();
  }

  //Обновить существующий объект
  Future<void> _updateItem(int id) async {
    carbohydrates = double.parse('${_carbohydratesController.text}');
    await SQLhelper().updateProductItem(
        id, _nameController.text, carbohydrates);
    await _refreshJournals();
  }

  //Удалить существующий объект
  void _deleteItem(int id) async {
    await SQLhelper().deleteProductItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Успешное удаление объекта!'),
    ));
    await _refreshJournals();
  }

}

