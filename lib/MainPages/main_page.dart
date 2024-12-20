import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DataBase/data_base.dart';
import 'package:searchfield/searchfield.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;

class MainPageClass extends StatefulWidget {
  const MainPageClass({super.key});

  @override
  State<MainPageClass> createState() => _MainPageClassState();
}

class _MainPageClassState extends State<MainPageClass> {

  DateTime _selectedDate = DateTime.now();
  bool _isCalendarVisible = false;
  String productBU = "";

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: _mainPageAppBar(),
          body: _mainPageBody(),
          drawer: _mainPageDrawer(),
        ),
    );
  }

  AppBar _mainPageAppBar() {
    return AppBar(
      title: Text('Прием пищи'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent[100],
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _isCalendarVisible = !_isCalendarVisible;
            });
          },
          icon: Icon(
            Icons.calendar_month,
            color: _isCalendarVisible ? Colors.white : Colors.black,

          ),
        ),
        IconButton(
          onPressed: () {appBarTime();},
          icon: Icon(Icons.add, color: Colors.black,),
        ),
      ],
    );
  }

  void appBarTime() {
    String datetime = DateTime.now().toString();
    int hour = int.parse(datetime[11]) * 10 + int.parse(datetime[12]);
    int minute = int.parse(datetime[14]) * 10 + int.parse(datetime[15]);
    if ((0 <= hour && hour <= 8)) {
      _showFormChoiceAdd(0);
    } else if ((9 <= hour && hour <= 11)) {
      _showFormChoiceAdd(1);
    } else if ((12 <= hour && hour < 14) || (hour == 14 && minute <= 29)) {
      _showFormChoiceAdd(2);
    } else if ((hour == 14 && minute >= 30) || (15 == hour || hour == 16)) {
      _showFormChoiceAdd(3);
    } else if ((17 == hour || hour == 18) || (hour == 19 && minute <= 29)) {
      _showFormChoiceAdd(4);
    } else if ((hour == 19 && minute >= 30) || (20 <= hour || hour <= 23)) {
      _showFormChoiceAdd(5);
    }
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

  Widget _calendar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) async {
          setState(() => _selectedDate = date);
          await _refreshJournals();
        },
        todayBorderColor: Colors.white,
        todayButtonColor: Colors.white,
        selectedDayBorderColor: Colors.white,
        selectedDayButtonColor: Colors.white,
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.blue,
        selectedDateTime: _selectedDate,
        customDayBuilder: (
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
            ) {
          if (isSelectedDay) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent[100],  // цвет заливки выбранного дня
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: textStyle,
                ),
              ),
            );
          } else if (isToday) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pinkAccent[100],  // цвет заливки сегодняшнего дня
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: textStyle,
                ),
              ),
            );
          }
          return null;  // использовать стиль по умолчанию для остальных дней
        },
        weekFormat: false,
        height: 430.0,
        daysHaveCircularBorder: true,
        locale: 'ru',
        isScrollable: false,
        pageScrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buSum() {
    return Container(
      child: Center(
        child:
            Text("$BUsum ХЕ", style: TextStyle(fontSize: 46),
        ),
      ),
    );
  }

  Widget _mainPageBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if(_isCalendarVisible)
            _calendar(),
          SizedBox(height: 5,),
          _buSum(),
          SizedBox(height: 5,),
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
                        onPressed: () {
                          _showAboutDialog(0);
                        },
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
                        onPressed: () {
                          _showAboutDialog(1);
                        },
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
                        onPressed: () {
                          _showAboutDialog(2);
                        },
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
                        onPressed: () {
                          _showAboutDialog(3);
                        },
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
                        onPressed: () {
                          _showAboutDialog(4);
                        },
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
                        onPressed: () {
                          _showAboutDialog(5);
                        },
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

  void _showAboutDialog(int time) {
    String contentText = '', titleText = '';
    if (time == 0) {
      titleText = "Завтрак";
      contentText = "Промежуток времени: 00:00 - 08:59";
    } else if (time == 1) {
      titleText = "Поздний завтрак";
      contentText = "Промежуток времени: 09:00 - 11:59";
    } else if (time == 2) {
      titleText = "Обед";
      contentText = "Промежуток времени: 12:00 - 14:29";
    } else if (time == 3) {
      titleText = "Поздний обед";
      contentText = "Промежуток времени: 14:30 - 16:29";
    } else if (time == 4) {
      titleText = "Ужин";
      contentText = "Промежуток времени: 17:00 - 19:29";
    } else if (time == 5) {
      titleText = "Поздний";
      contentText = "Промежуток времени: 19:30 - 23:59";
    }

    Widget okButton = TextButton(
      child: Text("OK", style: TextStyle(color: Colors.black),),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(titleText, style: TextStyle(color: Colors.black),),
      content: Text(contentText, style: TextStyle(color: Colors.black),),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
               left: 110,
               right: 110,
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
        BULdinner = '',
        BUsum = '';
  bool _isLoading = true;
  Future<void> _refreshJournals() async {
    BUbreakfast = await SQLhelper().returnBUSumma(0, _selectedDate);
    BULbreakfast = await SQLhelper().returnBUSumma(1, _selectedDate);
    BUlunch = await SQLhelper().returnBUSumma(2, _selectedDate);
    BULlunch = await SQLhelper().returnBUSumma(3, _selectedDate);
    BUdinner = await SQLhelper().returnBUSumma(4, _selectedDate);
    BULdinner = await SQLhelper().returnBUSumma(5, _selectedDate);
    BUsum = "${double.parse(BUbreakfast) + double.parse(BULbreakfast) + double.parse(BUlunch) + double.parse(BULlunch) +double.parse(BUdinner) + double.parse(BULdinner)}";

    final dataLateDinner = await SQLhelper().getLateDinnerItem(_selectedDate);
    final dataDinner = await SQLhelper().getDinnerItem(_selectedDate);
    final dataLateLunch = await SQLhelper().getLateLunchItem(_selectedDate);
    final dataLunch = await SQLhelper().getLunchItem(_selectedDate);
    final dataLateBreakfast = await SQLhelper().getLateBreakfastItem(_selectedDate);
    final dataBreakfast = await SQLhelper().getBreakfastItem(_selectedDate);
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
                SearchField<Map<String, dynamic>>(
                  hint: "Поиск по названию продукта",
                  suggestions: _journalsProducts
                      .map(
                        (e) => SearchFieldListItem<Map<String, dynamic>>(
                      e["name"],
                      item: e,

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(e["name"]),
                          ],
                        ),
                      ),
                    ),
                  ).toList(),
                  onSuggestionTap: (suggestion) {
                    productId = suggestion.item?['id'];
                  },
                    searchInputDecoration: SearchInputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)),
                      ),
                    ),
                    maxSuggestionsInViewPort: 3,
                ),

                SizedBox(height: 15,),
                // ввод граммов
                TextField(
                  controller: _gramsController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Граммы',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(4.0)),
                      borderSide: BorderSide(color: Colors.blueAccent),
                    ),
                    focusColor: Colors.blueAccent,
                  ),
                ),
                //Text("ХЕ: " + _getBu(productId, int.parse("${_gramsController.text}")).toString(), style: TextStyle(color: Colors.black)),
                FutureBuilder<String>(
                  future: _formatBU(_gramsController.text, productId), // async work
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting: return Text('Loading....');
                      default:
                        if (snapshot.hasError)
                          return Text('Error: ${snapshot.error}');
                        else
                          return Text('Result: ${snapshot.data}');
                    }
                  },
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

  Future<String> _formatBU(String grams, int productId) async {
    if (grams == "") {
      return "";
    }
    return "${await _getBu(productId, int.parse("${grams}"))}";
  }

  void _showFormAddDish(int time) {
    if (_journalsDish.isEmpty) {
      Widget okButton = ElevatedButton(
        child: Text("Хорошо, я добавлю", style: TextStyle(color: Colors.black),),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      AlertDialog alert = AlertDialog(
        content: Center(
          heightFactor: 2,
          child: Text("В базе данных нет блюд", style: TextStyle(color: Colors.black),),
        ),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    else {
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
                  SearchField<Map<String, dynamic>>(
                    hint: "Поиск по названию блюда",
                    suggestions: _journalsDish
                        .map(
                          (e) => SearchFieldListItem<Map<String, dynamic>>(
                        e["name"],
                        item: e,

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(e["name"]),
                            ],
                          ),
                        ),
                      ),
                    ).toList(),
                    onSuggestionTap: (suggestion) {
                      dishId = suggestion.item?['id'];
                    },
                    searchInputDecoration: SearchInputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                        borderRadius: BorderRadius.all(
                            Radius.circular(4.0)),
                      ),
                    ),
                    maxSuggestionsInViewPort: 3,
                  ),
                  const SizedBox(height: 15,),
                  // ввод граммов
                  const SizedBox(height: 15,),
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
                      _addItem(dishId, null, int.parse(_gramsController.text), time);
                      _gramsController.text = '';
                      await _refreshJournals();
                      // Закрываем шторку
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: const Text('Добавить', style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Отмена', style: TextStyle(color: Colors.black),))
                ],
              )
          )
      );
    }
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

    List<Map<String, dynamic>> currentList;

    switch (time) {
      case 0:
        currentList = _journalsBreakfast;
        break;
      case 1:
        currentList = _journalsLateBreakfast;
        break;
      case 2:
        currentList = _journalsLunch;
        break;
      case 3:
        currentList = _journalsLateLunch;
        break;
      case 4:
        currentList = _journalsDinner;
        break;
      case 5:
        currentList = _journalsLateDinner;
        break;
      default:
        return; // если не подошло, выход из метода
    }

    final existingJournal = currentList.firstWhere(
          (element) => element['id'] == id,
    );

   // final existingJournal = _journalsBreakfast.firstWhere((element) => element['id'] == id);
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
  //Узнать углеводы на определенное количество грамм продукта из БД
  Future<double> _getBu(int idProduct, int grams) async {
    var str = await SQLhelper().getProductClearBU(idProduct);
    var bu = double.parse(str);
    return Future.value((bu * grams) / 100);
  }
  
  //Вставить новый объект в базу данных
  Future<void> _addItem(int? idDish, int? idProduct, int grams, int time) async {
    await SQLhelper().createTimeItem(idDish, idProduct, grams, time, _selectedDate);
    await _refreshJournals();
  }
  //Обновить существующий объект
  Future<void> _updateItem(int? idDish, int? idProduct, int id, int grams, int time) async {
    await SQLhelper().updateTimeItem(idDish, idProduct, id, grams, time, _selectedDate);
    await _refreshJournals();
  }
  //Удалить существующий объект
  void _deleteItem(int id, int time ) async{
    await SQLhelper().deleteTimeItem(id, time, _selectedDate);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Успешное удаление объекта!'),
    ));
    await _refreshJournals();
  }

}