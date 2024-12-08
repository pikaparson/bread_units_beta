import 'package:flutter/material.dart';
import '../../DataBase/data_base.dart';

class DishBaseClass extends StatefulWidget {
  const DishBaseClass({super.key});

  @override
  State<DishBaseClass> createState() => _DishBaseClassState();
}

class _DishBaseClassState extends State<DishBaseClass> {

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: _dishBaseAppBar(),
          body: _dishBaseBody(),
          drawer: _dishBaseDrawer(),
          floatingActionButton: _dishBaseFloatingActionButton(),
        ),
    );
  }

  AppBar _dishBaseAppBar() {
    return AppBar(
      title: Text('База блюд'),
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

  Widget _dishBaseBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            onChanged: (value) => _filterSearchResults(value),
            decoration: const InputDecoration(
              hintText: "Поиск блюда по названию",
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
                itemBuilder: (context, index) => Card (
                  color: Colors.grey[100],
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text('${filteredItems[index]['name']}'),
                    subtitle: FutureBuilder<double>(
                        future: SQLhelper().calculateBu(int.parse(filteredItems[index]['id'].toString())),
                        builder: (context, snapshot) {
                          return Text('${snapshot.data?.toStringAsFixed(2)} ХЕ на 100 грамм');
                        }
                    ),
                    trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showForm(filteredItems[index]['id']);
                                  });
                                },
                                icon: const Icon(Icons.edit)
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _deleteItem(filteredItems[index]['id']);
                                  });
                                },
                                icon: const Icon(Icons.delete)
                            ),
                          ],
                        )
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

 Widget _dishBaseFloatingActionButton() {
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

  Drawer _dishBaseDrawer() {
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
            title: Text('База блюд', style: TextStyle(color: Colors.blueAccent[100]),),
            onTap: null,
          ),
          ListTile(
            leading: Icon(Icons.apple, color: Colors.blueAccent[100]),
            title: Text('База продуктов'),
            onTap: () {
              Navigator.popAndPushNamed(context, 'product_base');
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

  int idHelper = 0;
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  Future<void> _refreshJournals() async {
    final data = await SQLhelper().getDishItem();
    setState(() {
      if(data != null)
      {
        _journals = data;
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

  bool _hasName(String name) {
    for(var dish in _journals) {
      if (dish['name'] == name) {
        return true;
      }
    }
    return false;
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
            child: Form(
              key: _key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Название блюда',
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0)),
                        borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                      focusColor: Colors.blueAccent,
                    ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty){
                          return 'Пожалуйста, введите название блюда';
                        }
                        if (value != null && value.contains('\$')) {
                          return 'Название блюда содержит запрещенный знак \$';
                        }
                        if (_hasName(value!)) {
                          return 'Блюдо с таким именем уже существует';
                        }
                      },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(_key.currentState!.validate()) {
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
                          Navigator.popAndPushNamed(context, 'composition');
                        });
                      }
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
        )
    );
  }

  //добавить имя блюда в контроллер
  Future<void> _controlName() async {
    await SQLhelper().controlInsertDishName(_nameController.text);
  }
  //Вставить новый объект в базу данных
  Future<void> _addItem() async {
    await SQLhelper().createDishItem(_nameController.text);
    await _refreshJournals();
  }
  //Обновить существующий объект
  Future<void> _updateItem(int id) async {
    await SQLhelper().updateDishItem(id, _nameController.text);
    await _refreshJournals();
  }
  //Удалить существующий объект
  void _deleteItem(int id) async{
    await SQLhelper().deleteDishItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Успешное удаление объекта!'),
    ));
    await _refreshJournals();
  }
}
