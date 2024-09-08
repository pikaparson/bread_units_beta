import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../DataBase/data_base.dart';

class ProductBaseClass extends StatefulWidget {
  const ProductBaseClass({super.key});

  @override
  State<ProductBaseClass> createState() => _ProductBaseClassState();
}

class _ProductBaseClassState extends State<ProductBaseClass> {

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _productBaseAppBar(),
      body: _productBaseBody(),
      floatingActionButton: _productBaseFloatingActionButton(),
      drawer: _productBaseDrawer(),
    );
  }

  AppBar _productBaseAppBar() {
    return AppBar(
      title: Text('База продуктов'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
    );
  }

  ListView _productBaseBody() {
    return ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) =>
            Card(
              color: Colors.grey[100],
              margin: const EdgeInsets.all(15),
              child: ListTile(
                title: Text(
                    '${_journals[index]['name']}\n${_journals[index]['carbohydrates']}г углеводов на 100г'),
                subtitle: FutureBuilder<String>(
                  future: SQLhelper().getProductBU(_journals[index]['id']),
                  builder: (context, snapshot) {
                    return Text('${snapshot.data}');
                  },
                ),
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

  FloatingActionButton _productBaseFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          _showForm(null);
        });
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.blueAccent[100],
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


  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  Future<void> _refreshJournals() async {
    final data = await SQLhelper().getProductItem();
    setState(() {
      if (data != null) _journals = data;
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


  bool? hasName;
  Future<void> _refreshHasName(String? name) async {
    bool? has = await SQLhelper().hasProductName(name);
    setState(() {
      hasName = has;
    });
  }

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
        //тень
        isScrollControlled: true,
        backgroundColor: Colors.white,
        isDismissible: false,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
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
                cursorColor: Colors.blueAccent[100],
                decoration: const InputDecoration(
                  labelText: 'Название продукта',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(4.0)),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  focusColor: Colors.blueAccent,
                ),
                validator: (String? value) {
                  if (value != null && value.isEmpty){
                    return 'Пожалуйста, введите название продукта';
                  }
                  if (value != null && value.contains('\$')) {
                    return 'Название продукта содержит запрещенный знак \$';
                  }
                  setState(() {
                    Future.microtask(() async => await _refreshHasName(value));
                  });
                  if (hasName!) {
                    return 'Продукт с таким именем уже существует';
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
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
                  hintStyle: TextStyle(color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(4.0)),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
                validator: (value) {
                  var carbs = double.parse(value.toString());
                  if (carbs < 0 || carbs > 100) {
                    return 'Было введено неправильное количество углеводов - ${value.toString()}';
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    if (id == null) {
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
                  }
                },
                child: Text(
                    'Добавить', style: TextStyle(color: Colors.black)),
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

