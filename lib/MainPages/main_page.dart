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
      //floatingActionButton: _mainPageFloatingActionButton(),
    );
  }
  AppBar _mainPageAppBar() {
    return AppBar(
      title: Text('Прием пищи'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
    );
  }

  //Padding _mainPageFloatingActionButton() {
  //  return Padding(
  //    padding: const EdgeInsets.only(bottom: 40.0),
  //    child: FloatingActionButton(
  //      onPressed: () {
  //        _showForm(null);
  //      },
  //      child: Icon(Icons.add, color: Colors.black,),
  //      backgroundColor: Colors.blueAccent[100],
  //    ),
  //  );
  //}

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

  Widget _mainPageBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15,),
          _mainPageBreakfast(),
          SizedBox(height: 5,),
          _mainPageCardsBreakfast(),
          SizedBox(height: 5,),
          _mainPageLateBreakfast(),
          SizedBox(height: 5,),
          _mainPageCardsLateBreakfast(),
          SizedBox(height: 5,),
          _mainPageLunch(),
          SizedBox(height: 5,),
          _mainPageCardsLunch(),
          SizedBox(height: 5,),
          _mainPageLateLunch(),
          SizedBox(height: 5,),
          _mainPageCardsLateLunch(),
          SizedBox(height: 5,),
          _mainPageDinner(),
          SizedBox(height: 5,),
          _mainPageCardsDinner(),
          SizedBox(height: 5,),
          _mainPageLateDinner(),
          SizedBox(height: 5,),
          _mainPageCardsLateDinner(),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
  Widget _mainPageBreakfast() {
    return Flexible(
        child: Container(
          color: Colors.blue[100],
          padding: EdgeInsets.only(left: 30, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Завтрак', style: TextStyle(fontSize: 20),),
              Container(
                padding: EdgeInsets.only(right: 18),
                child: Row(
                  children: [
                    Text("${BUbreakfast} ХE"),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.question_mark)
                    ),
                    IconButton(
                        onPressed: () {
                          _showFormChoiceAdd(0);
                        },
                        icon: Icon(Icons.add)
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Widget _mainPageLateBreakfast() {
    return Flexible(
        child: Container(
          color: Colors.blue[100],
          padding: EdgeInsets.only(left: 30, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Поздний завтрак', style: TextStyle(fontSize: 20),),
              Container(
                padding: EdgeInsets.only(right: 18),
                child: Row(
                  children: [
                    Text("${BULbreakfast} ХE"),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.question_mark)
                    ),
                    IconButton(
                        onPressed: () {
                          _showFormChoiceAdd(1);
                        },
                        icon: Icon(Icons.add)
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Widget _mainPageLunch() {
    return Flexible(
        child: Container(
          color: Colors.blue[100],
          padding: EdgeInsets.only(left: 30, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Обед', style: TextStyle(fontSize: 20),),
              Container(
                padding: EdgeInsets.only(right: 18),
                child: Row(
                  children: [
                    Text("${BUlunch} ХE"),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.question_mark)
                    ),
                    IconButton(
                        onPressed: () {
                          _showFormChoiceAdd(2);
                        },
                        icon: Icon(Icons.add)
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Widget _mainPageLateLunch() {
    return Flexible(
        child: Container(
          color: Colors.blue[100],
          padding: EdgeInsets.only(left: 30, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Поздний обед', style: TextStyle(fontSize: 20),),
              Container(
                padding: EdgeInsets.only(right: 18),
                child: Row(
                  children: [
                    Text("${BULlunch} ХE"),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.question_mark)
                    ),
                    IconButton(
                        onPressed: () {
                          _showFormChoiceAdd(3);
                        },
                        icon: Icon(Icons.add)
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Widget _mainPageDinner() {
    return Flexible(
        child: Container(
          color: Colors.blue[100],
          padding: EdgeInsets.only(left: 30, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ужин', style: TextStyle(fontSize: 20),),
              Container(
                padding: EdgeInsets.only(right: 18),
                child: Row(
                  children: [
                    Text("${BUdinner} ХE"),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.question_mark)
                    ),
                    IconButton(
                        onPressed: () {
                          _showFormChoiceAdd(4);
                        },
                        icon: Icon(Icons.add)
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
  Widget _mainPageLateDinner() {
    return Flexible(
        child: Container(
          color: Colors.blue[100],
          padding: EdgeInsets.only(left: 30, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Поздний ужин', style: TextStyle(fontSize: 20),),
              Container(
                padding: EdgeInsets.only(right: 18),
                child: Row(
                  children: [
                    Text("${BULdinner} ХE"),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.question_mark)
                    ),
                    IconButton(
                        onPressed: () {
                          _showFormChoiceAdd(5);
                        },
                        icon: Icon(Icons.add)
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }



  void _showFormChoiceAdd(int time) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        elevation: 5,
        backgroundColor: Colors.white,
        isDismissible: false,
        builder: (_) => Container(
             padding: EdgeInsets.only(
               top: 25,
               left: 75,
               right: 75,
               bottom: 200
             ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showFormAddProduct(time);
                    },
                    child: Text("Добавить продукт", style: TextStyle(color: Colors.black, fontSize: 14),)
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _showFormAddDish(time);
                    },
                    child: Text("Добавить свое блюдо", style: TextStyle(color: Colors.black, fontSize: 14))
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Отмена",style: TextStyle(color: Colors.black, fontSize: 14))
                ),
              ],
            )
        )
    );
  }

  List<Map<String, dynamic>> _journalsBreakfast = [],
                             _journalsLateBreakfast = [],
                             _journalsLunch = [],
                             _journalsLateLunch = [],
                             _journalsDinner = [],
                             _journalsLateDinner = [],
                             _journalsProducts = [],
                             _journalsDish = [];
  String BUbreakfast = '',
        BULbreakfast = '',
        BUlunch = '',
        BULlunch = '',
        BUdinner = '',
        BULdinner = '';
  bool _isLoading = true;
  Future<void> _refreshJournals() async {
    BUbreakfast = await SQLhelper().returnBUSumma(0);
    BULbreakfast = await SQLhelper().returnBUSumma(1);
    BUlunch = await SQLhelper().returnBUSumma(2);
    BULlunch = await SQLhelper().returnBUSumma(3);
    BUdinner = await SQLhelper().returnBUSumma(4);
    BULdinner = await SQLhelper().returnBUSumma(5);

    final dataLateDinner = await SQLhelper().getLateDinnerItem();
    final dataDinner = await SQLhelper().getDinnerItem();
    final dataLateLunch = await SQLhelper().getLateLunchItem();
    final dataLunch = await SQLhelper().getLunchItem();
    final dataLateBreakfast = await SQLhelper().getLateBreakfastItem();
    final dataBreakfast = await SQLhelper().getBreakfastItem();
    final dataProducts = await SQLhelper().getProductItem();
    final dataDish = await SQLhelper().getDishItem();
    setState(() {
      if(dataLateDinner != null)
      {
        _journalsLateDinner = dataLateDinner;
      }
      if(dataDinner != null)
      {
        _journalsDinner = dataDinner;
      }
      if(dataLateLunch != null)
      {
        _journalsLateLunch = dataLateLunch;
      }
      if(dataLunch != null)
      {
        _journalsLunch = dataLunch;
      }
      if(dataLateBreakfast != null)
      {
        _journalsLateBreakfast = dataLateBreakfast;
      }
      if(dataBreakfast != null)
      {
        _journalsBreakfast = dataBreakfast;
      }
      if(dataProducts != null){
        _journalsProducts = dataProducts;
      }
      if(dataDish != null) {
        _journalsDish = dataDish;
      }
      _isLoading = false;
    });

  }
  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  final TextEditingController _gramsController = TextEditingController();
  void _showFormAddProduct(int time) {
    int productId = 0;
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
              bottom: MediaQuery.of(context).viewInsets.bottom + 50,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //выбор продукта
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Выберите продукт',
                    labelStyle: TextStyle(color: Colors.black),
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
                SizedBox(height: 15,),
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
                    _addItem(null, productId, int.parse("${_gramsController.text}"), time);
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
  void _showFormAddDish(int time) {
    int dishId = _journalsDish[0]['id'];
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
              bottom: MediaQuery.of(context).viewInsets.bottom + 50,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //выбор продукта
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Выберите блюдо',
                    labelStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black54),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  isExpanded: false,
                  value: dishId,
                  items: _journalsDish.map<DropdownMenuItem<int>>((e) {
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
                      dishId = t!;
                      MediaQuery.of(context).viewInsets.bottom;
                    });
                  },
                ),
                SizedBox(height: 15,),
                // ввод граммов
                SizedBox(height: 15,),
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
                    _addItem(dishId, null, int.parse("${_gramsController.text}"), time);
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


  Widget _mainPageCardsBreakfast() {
    return SizedBox(
      height: _journalsBreakfast.length * 82,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _journalsBreakfast.length,
          itemBuilder: (context, index) => Card (
            color: Colors.grey[100],
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text('${_journalsBreakfast[index]['name']}'),
              subtitle: Text('${_journalsBreakfast[index]['grams']} грамм(ов/а)\n${(double.parse('${_journalsBreakfast[index]['grams']}') * double.parse('${_journalsBreakfast[index]['carbohydrates']}') / 100 / 12).toStringAsFixed(2)} ХЕ'),
              trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _showFormEdit(_journalsBreakfast[index]['id'], 0);
                            });
                          },
                          icon: const Icon(Icons.edit)
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _deleteItem(_journalsBreakfast[index]['id'], 0);
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
    );
  }
  Widget _mainPageCardsLateBreakfast() {
    return SizedBox(
      height: _journalsLateBreakfast.length * 82,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _journalsLateBreakfast.length,
          itemBuilder: (context, index) => Card (
            color: Colors.grey[100],
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text('${_journalsLateBreakfast[index]['name']}'),
              //toStringAsExponential(3)
              subtitle: Text('${_journalsLateBreakfast[index]['grams']} грамм(ов/а)\n${(double.parse('${_journalsLateBreakfast[index]['grams']}') * double.parse('${_journalsLateBreakfast[index]['carbohydrates']}') / 100 / 12).toStringAsFixed(2)} ХЕ'),
              trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _showFormEdit(_journalsLateBreakfast[index]['id'], 1);
                            });
                          },
                          icon: const Icon(Icons.edit)
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _deleteItem(_journalsLateBreakfast[index]['id'], 1);
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
    );
  }
  Widget _mainPageCardsLunch() {
    return SizedBox(
      height: _journalsLunch.length * 82,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _journalsLunch.length,
          itemBuilder: (context, index) => Card (
            color: Colors.grey[100],
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text('${_journalsLunch[index]['name']}'),
              //toStringAsExponential(3)
              subtitle: Text('${_journalsLunch[index]['grams']} грамм(ов/а)\n${(double.parse('${_journalsLunch[index]['grams']}') * double.parse('${_journalsLunch[index]['carbohydrates']}') / 100 / 12).toStringAsFixed(2)} ХЕ'),
              trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _showFormEdit(_journalsLunch[index]['id'], 2);
                            });
                          },
                          icon: const Icon(Icons.edit)
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _deleteItem(_journalsLunch[index]['id'], 2);
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
    );
  }
  Widget _mainPageCardsLateLunch() {
    return SizedBox(
      height: _journalsLateLunch.length * 82,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _journalsLateLunch.length,
          itemBuilder: (context, index) => Card (
            color: Colors.grey[100],
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text('${_journalsLateLunch[index]['name']}'),
              //toStringAsExponential(3)
              subtitle: Text('${_journalsLateLunch[index]['grams']} грамм(ов/а)\n${(double.parse('${_journalsLateLunch[index]['grams']}') * double.parse('${_journalsLateLunch[index]['carbohydrates']}') / 100 / 12).toStringAsFixed(2)} ХЕ'),
              trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _showFormEdit(_journalsLateLunch[index]['id'], 3);
                            });
                          },
                          icon: const Icon(Icons.edit)
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _deleteItem(_journalsLateLunch[index]['id'], 3);
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
    );
  }
  Widget _mainPageCardsDinner() {
    return SizedBox(
      height: _journalsDinner.length * 82,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _journalsDinner.length,
          itemBuilder: (context, index) => Card (
            color: Colors.grey[100],
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text('${_journalsDinner[index]['name']}'),
              //toStringAsExponential(3)
              subtitle: Text('${_journalsDinner[index]['grams']} грамм(ов/а)\n${(double.parse('${_journalsDinner[index]['grams']}') * double.parse('${_journalsDinner[index]['carbohydrates']}') / 100 / 12).toStringAsFixed(2)} ХЕ'),
              trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _showFormEdit(_journalsDinner[index]['id'], 4);
                            });
                          },
                          icon: const Icon(Icons.edit)
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _deleteItem(_journalsDinner[index]['id'], 4);
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
    );
  }
  Widget _mainPageCardsLateDinner() {
    return SizedBox(
      height: _journalsLateDinner.length * 82,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _journalsLateDinner.length,
          itemBuilder: (context, index) => Card (
            color: Colors.grey[100],
            margin: const EdgeInsets.all(5),
            child: ListTile(
              title: Text('${_journalsLateDinner[index]['name']}'),
              //toStringAsExponential(3)
              subtitle: Text('${_journalsLateDinner[index]['grams']} грамм(ов/а)\n${(double.parse('${_journalsLateDinner[index]['grams']}') * double.parse('${_journalsLateDinner[index]['carbohydrates']}') / 100 / 12).toStringAsFixed(2)} ХЕ'),
              trailing: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _showFormEdit(_journalsLateDinner[index]['id'], 5);
                            });
                          },
                          icon: const Icon(Icons.edit)
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _deleteItem(_journalsLateDinner[index]['id'], 5);
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
    );
  }


  void _showFormEdit(int id, int time) async {
    String name = '';
    final existingJournal = _journalsBreakfast.firstWhere((element) => element['id'] == id);
    _gramsController.text = "${existingJournal['grams']}";
    name = existingJournal['name'];

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
              bottom: MediaQuery.of(context).viewInsets.bottom + 50,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Изменить граммы: ${name}"),
                const SizedBox(
                  height: 15,
                ),
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
                ElevatedButton(
                  onPressed: () async {
                    int grams = int.parse('${_gramsController.text}');
                    if (existingJournal['product'] == null) {
                      int idD = int.parse('${existingJournal['dish']}');
                      await _updateItem(idD, null, id, grams, time);
                    } else if (existingJournal['dish'] == null) {
                      int idP = int.parse('${existingJournal['product']}');
                      await _updateItem(null, idP, id, grams, time);
                    }
                    // Очистим поле
                    _gramsController.text = '';
                    await _refreshJournals();
                    // Закрываем шторку
                    if (!mounted) return;
                    Navigator.of(context).pop();
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

  //Вставить новый объект в базу данных
  Future<void> _addItem(int? idDish, int? idProduct, int grams, int time) async {
    await SQLhelper().createTimeItem(idDish, idProduct, grams, time);
    await _refreshJournals();
  }
  //Обновить существующий объект
  Future<void> _updateItem(int? idDish, int? idProduct, int id, int grams, int time) async {
    await SQLhelper().updateTimeItem(idDish, idProduct, id, grams, time);
    await _refreshJournals();
  }
  //Удалить существующий объект
  void _deleteItem(int id, int time) async{
    await SQLhelper().deleteTimeItem(id, time);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Успешное удаление объекта!'),
    ));
    await _refreshJournals();
  }

}