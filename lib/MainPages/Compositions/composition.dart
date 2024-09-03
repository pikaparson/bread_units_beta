import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../DataBase/data_base.dart';

class CompositionClass extends StatefulWidget {
  const CompositionClass({super.key});

  @override
  State<CompositionClass> createState() => _CompositionClassState();
}

class _CompositionClassState extends State<CompositionClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _compositionAppBar(),
      body: _compositionBody(),
      floatingActionButton: _compositionFloatingActionButton(),
    );
  }

  AppBar _compositionAppBar() {
    return AppBar(
      title: Text('${dishName}: ингредиенты', style: TextStyle(fontSize: 20),),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, 'dish_base');
          },
          icon: Icon(Icons.arrow_back)),
    );
  }

  ListView _compositionBody() {
    return ListView.builder(
        itemCount: _journals.length,
        itemBuilder: (context, index) => Card (
          color: Colors.grey[100],
          margin: const EdgeInsets.all(15),
          child: ListTile(
            title:  FutureBuilder<String>(
                future: SQLhelper().controlGetGrams(_journals[index]['id_comp'], dishId),
                builder: (context, snapshot) {
                  return Text('${_journals[index]['name_product']}\n${snapshot.data} грамм(ов)', style: TextStyle(fontSize: 18));
                }
            ),
            subtitle: FutureBuilder<String>(
                future: SQLhelper().controlGetBU(_journals[index]['id_comp'], dishId),
                builder: (context, snapshot) {
                  return Text('${snapshot.data} ХЕ', style: TextStyle(fontSize: 18));
                }
            ),
            trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _showForm(_journals[index]['id_comp']);
                          });
                        },
                        icon: const Icon(Icons.edit)
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _deleteItem(_journals[index]['id_comp']);
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

  FloatingActionButton _compositionFloatingActionButton() {
    return FloatingActionButton(
        onPressed: () {
          if (_journalsProducts == null) {
            showDialog(
               context: context,
               builder: (BuildContext context) {
                 return AlertDialog(
                    title: Text('Ошибка!', textAlign: TextAlign.center,),
                    content: Text('Нет продуктов!'),
                    actions: [
                      TextButton(onPressed: () { Navigator.of(context).pop(); },
                          child: Text('Продолжить', style: TextStyle(color: Colors.black),))
                     ],
                 );
               }
           );
          }
          else {
            _showForm(null);
          }
        },
        child: Icon(Icons.add, color: Colors.black,),
        backgroundColor: Colors.blueAccent[100],
    );
  }

  String dishName = '';
  int dishId = 0,
      productId = 0;
  List<Map<String, dynamic>> _journals = [];
  List<Map<String, dynamic>> _journalsProducts = [];
  bool _isLoading = true;


  Future<void> _refreshJournals() async {
    dishName = await SQLhelper().controlDishName();
    dishId = await SQLhelper().controlDishId(dishName);

    final data = await SQLhelper().controlGetDishItem(dishId);
    final dataProducts = await SQLhelper().getProductItem();
    setState(() {
      if(data != null)
      {
        _journals = data;
      }
      if(dataProducts != null) {
        productId = int.parse('${dataProducts[0]['id']}');
        _journalsProducts = dataProducts;
      }
      _isLoading = false;
    });
  }
  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }


  //Вставить новый объект в базу данных
  Future<void> _addItem() async {
    await SQLhelper().createCompositionItem(dishId, productId, int.parse('${_gramsController.text}'));
    await _refreshJournals();
  }
  //Обновить существующий объект
  Future<void> _updateItem(int id, int id_pr, double g) async {
    await SQLhelper().updateCompositionItem(id, dishId, id_pr, g);
    await _refreshJournals();
  }
  //Удалить существующий объект
  void _deleteItem(int id) async{
    await SQLhelper().deleteCompositionItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Успешное удаление объекта!'),
    ));
    await _refreshJournals();
  }

  final TextEditingController _gramsController = TextEditingController();
  void _showForm(int? id) async {
    //если id == 0, то шторка для создания элемента
    if (id != null) {
      //final p = _journalsProducts.firstWhere((element) => element['id'] == id);
      final help = _journals.firstWhere((element) => element['id_comp'] == id);
      _gramsController.text = help['grams'].toString();
      productId = help['id_product'];
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
                Container(
                  child: Text('Выберите продукт'),
                ),
                //выбор продукта
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Название блюда',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Ввод названия блюда',
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  disabledHint: productId != null //можно удалить
                      ? Text(_journalsProducts.firstWhere((item) => item["id"] == productId)["name"])
                      : null,
                  isExpanded: false,
                  value: productId,
                  items: _journalsProducts.map<DropdownMenuItem<int>>((e) {
                    return DropdownMenuItem
                      (
                      child: Text(
                        e["name"],
                      ),
                      value: e["id"],
                    );
                  }).toList(),
                  onChanged: (t) {
                    setState(() {
                      productId = t!;
                      MediaQuery.of(context).viewInsets.bottom;
                    });
                  },
                ),
                SizedBox(
                    height: 15,
                ),
                // ввод граммов
                TextField(
                  controller: _gramsController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Граммы',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Ввод граммов',
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
                    if (id == null){
                      await _addItem();
                    } else if (id != null) {
                      await _updateItem(id, productId, double.parse('${_gramsController.text}'));
                    }
                    _gramsController.text = '';
                    await _refreshJournals();
                    // Закрываем шторку
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  },
                  child: Text('Добавить', style: TextStyle(color: Colors.black)),
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
}
