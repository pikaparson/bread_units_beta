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

  final _key = GlobalKey<FormState>();

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
      title: const Text('База продуктов'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
      actions: [
        IconButton(
            onPressed: () {_showFormSorting();},
            icon: const Icon(Icons.sort)
        ),
      ],
    );
  }


  void _showFormSorting() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      elevation: 5,
      backgroundColor: Colors.white,
      isDismissible: false,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          // Переменные состояния для радиокнопок и чекбоксов
          //String selectedRadio = "от А до Я";  // начальное значение для radio buttons
          //bool isCustomChecked = true;   // чекбокс "пользовательские" по умолчанию
          //bool isBuiltInChecked = true;  // чекбокс "встроенные" по умолчанию

          // Функция для вызова sortValidator и закрытия виджета
          void onSelectionChanged() {
            sortValidator();
            Navigator.of(context).pop();  // Закрытие виджета с сохранением настроек
          }

          return Container(
            padding: EdgeInsets.only(
              top: 25,
              left: 30,
              right: 30,
              bottom: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Показать",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),

                // Радиокнопки для выбора сортировки
                RadioListTile(
                  title: Text("от А до Я"),
                  value: "от А до Я",
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() => selectedRadio = value.toString());
                    setState(() => _sortKey = "name");
                    setState(() => _ascending = true);
                    onSelectionChanged();
                  },
                ),
                RadioListTile(
                  title: Text("от Я до А"),
                  value: "от Я до А",
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() => selectedRadio = value.toString());
                    setState(() => _sortKey = "name");
                    setState(() => _ascending = false);
                    onSelectionChanged();
                  },
                ),
                RadioListTile(
                  title: Text("по возрастанию ХЕ"),
                  value: "по возрастанию ХЕ",
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() => selectedRadio = value.toString());
                    setState(() => _sortKey = "carbohydrates");
                    setState(() => _ascending = true);
                    onSelectionChanged();
                  },
                ),
                RadioListTile(
                  title: Text("по убыванию ХЕ"),
                  value: "по убыванию ХЕ",
                  groupValue: selectedRadio,
                  onChanged: (value) {
                    setState(() => selectedRadio = value.toString());
                    setState(() => _sortKey = "carbohydrates");
                    setState(() => _ascending = false);
                    onSelectionChanged();
                  },
                ),
                SizedBox(height: 10),

                // Чекбоксы
                CheckboxListTile(
                  title: Text("пользовательские"),
                  value: isCustomChecked,
                  controlAffinity: ListTileControlAffinity.leading, // Значок перед текстом
                  onChanged: (bool? value) {
                    setState(() => isCustomChecked = value!);
                    onSelectionChanged();
                  },
                ),
                CheckboxListTile(
                  title: Text("встроенные"),
                  value: isBuiltInChecked,
                  controlAffinity: ListTileControlAffinity.leading, // Значок перед текстом
                  onChanged: (bool? value) {
                    setState(() => isBuiltInChecked = value!);
                    onSelectionChanged();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // эта функция пока особо не нужна, но пусть будет, мб при рефакторинге пригодится
  void sortValidator() {
    //_sortKey = 'name';
    //_ascending = true;
    _refreshJournals();
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

/*    ListView _productBaseBody() {
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
                        returnEditIcon(_journals[index]['main'], index),
                        returnDeleteIcon(_journals[index]['main'], index),
                      ],
                    )*/
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

  // void _showFormChoiceSort() {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       elevation: 5,
  //       backgroundColor: Colors.white,
  //       isDismissible: false,
  //       builder: (_) => Container(
  //           padding: EdgeInsets.only(
  //               top: 25,
  //               left: 75,
  //               right: 75,
  //               bottom: 200
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               ElevatedButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     _showFormAddProduct(time);
  //                   },
  //                   child: Text("Добавить продукт", style: TextStyle(color: Colors.black, fontSize: 14),)
  //               ),
  //               SizedBox(height: 10,),
  //               ElevatedButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     _showFormAddDish(time);
  //                   },
  //                   child: Text("Добавить свое блюдо", style: TextStyle(color: Colors.black, fontSize: 14))
  //               ),
  //               SizedBox(height: 10,),
  //               ElevatedButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text("Отмена",style: TextStyle(color: Colors.black, fontSize: 14))
  //               ),
  //             ],
  //           )
  //       )
  //   );
  // }

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
  String _sortKey = 'name'; // сортировка по ключу
  bool _ascending = true; // сортировка по возрастанию/убыванию
  bool isCustomChecked = true;   // чекбокс "пользовательские" по умолчанию
  bool isBuiltInChecked = true;  // чекбокс "встроенные" по умолчанию
  String selectedRadio = "от А до Я";  // начальное значение для radio buttons


  Future<void> _refreshJournals() async {
    final data = await SQLhelper().getProductItem(_sortKey, _ascending, isCustomChecked, isBuiltInChecked);
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

  bool _hasName(String name) {
    for(var product in _journals) {
      if (product['name'] == name) {
        return true;
      }
    }
    return false;
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal = _journals.firstWhere((element) =>
      element['id'] == id);
      _nameController.text = existingJournal['name'];
      _carbohydratesController.text =
          existingJournal['carbohydrates'].toString();
    }

    String oldName = _nameController.text;

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
                    return 'Название продукта сожержит запрещенный знак \$';
                  }
                  if (_hasName(value!) && value != oldName) {
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

