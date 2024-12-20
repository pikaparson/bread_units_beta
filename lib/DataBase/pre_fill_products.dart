import 'package:sqflite/sqflite.dart';

// Предзаполнить таблицу products
Future<void> preFillProducts(Database database) async{
  String query = ("""INSERT INTO products VALUES (0, "Хлеб ржаной", 42.5, 1, 10.00),
(1, "Хлеб пшеничный. грубый", 45.2, 1, 10.00),
(2, "Хлеб пшеничный. лучший", 56.1, 1, 10.00),
(3, "Булки городские", 53.0, 1, 10.00),
(4, "Батоны", 49.5, 1, 10.00),
(5, "Сухари ржаные", 64.0, 1, 10.00),
(6, "Сухари пшеничные", 68.5, 1, 10.00),
(7, "Сухари дорожные", 69.0, 1, 10.00),
(8, "Галеты «Поход»", 68.8, 1, 10.00),
(9, "Баранки. сушки", 56.8, 1, 10.00),
(10, "Печенье сухое", 58.4, 1, 10.00),
(11, "Печенье сахарное", 67.7, 1, 10.00),
(12, "Пряники", 72.5, 1, 10.00),
(13, "Мука ржаная", 66.2, 1, 10.00),
(14, "Мука пшеничная", 65.5, 1, 10.00),
(15, "Молоко коровье цельное", 4.5, 1, 10.00),
(16, "Молоко коровье обезжиренное", 4.6, 1, 10.00),
(17, "Молоко коровье: цельное сухое", 36.3, 1, 10.00),
(18, "Молоко сухое обезжиренное", 48.0, 1, 10.00),
(19, "Молоко овечье", 3.8, 1, 10.00),
(20, "Молоко козье", 4.1, 1, 10.00),
(21, "Кислое молоко", 4.5, 1, 10.00),
(22, "Кефир", 2.5, 1, 10.00),
(23, "Кумыс", 3.7, 1, 10.00),
(24, "Молоко сгущеное с сахаром", 63.5, 1, 10.00),
(25, "Молоко сгущеное без сахара", 9.6, 1, 10.00),
(26, "Сливки 10%-ной жирности", 4.2, 1, 10.00),
(27, "Сливки 35%-ной жирности", 3.0, 1, 10.00),
(28, "Сливки сухие без сахара", 28.9, 1, 10.00),
(29, "Сливки сгущеные с сахаром", 45.9, 1, 10.00),
(30, "Сметана", 3.1, 1, 10.00),
(31, "Творог нежирный", 3.5, 1, 10.00),
(32, "Творог 9% жирности", 3.3, 1, 10.00),
(33, "Творог 20% жирности", 3.0, 1, 10.00),
(34, "Сырковая масса жирная", 27.0, 1, 10.00),
(35, "Сырковая масса нежирная", 15.8, 1, 10.00),
(36, "Сыр 40% жирности", 3.4, 1, 10.00),
(37, "Сыр 45% жирности", 2.0, 1, 10.00),
(38, "Сыр 50% жирности", 2.5, 1, 10.00),
(39, "Брынза 40% жирности", 1.9, 1, 10.00),
(40, "Сыр плавленый 40% жирности", 1.9, 1, 10.00),
(41, "Масло сливочное вологодское", 0.6, 1, 10.00),
(42, "Масло сливочное шоколадное", 18.9, 1, 10.00),
(43, "Масло сливочное несоленое", 0.5, 1, 10.00),
(44, "Масло топленое", 0, 1, 10.00),
(45, "Масло подсолнечное", 0, 1, 10.00),
(46, "Масло хлопковое", 0, 1, 10.00),
(47, "Маргарин столовый", 0.8, 1, 10.00),
(48, "Маргарин молочный", 0.4, 1, 10.00),
(49, "Грудинка копченая", 0, 1, 10.00),
(50, "Корейка копченая", 0, 1, 10.00),
(51, "Яйцо", 0.5, 1, 10.00),
(52, "Яичный порошок", 0, 1, 10.00),
(53, "Говядина жирная", 0, 1, 10.00),
(54, "Говядина средняя", 0, 1, 10.00),
(55, "Говядина тощая", 0, 1, 10.00),
(56, "Баранина жирная", 0, 1, 10.00),
(57, "Свинина жирная", 0, 1, 10.00),
(58, "Свинина мясная", 0, 1, 10.00),
(59, "Телятина жирная", 0, 1, 10.00),
(60, "Телятина постная", 0, 1, 10.00),
(61, "Солонина", 0, 1, 10.00),
(62, "Кролик", 0, 1, 10.00),
(63, "Куры", 0, 1, 10.00),
(64, "Колбаса сырокопченая", 0, 1, 10.00),
(65, "Колбаса полукопченая", 0, 1, 10.00),
(66, "Колбаса любительская вареная", 0, 1, 10.00),
(67, "Колбаса чайная", 1.0, 1, 10.00),
(68, "Колбаса ливерная", 22.2, 1, 10.00),
(69, "Сосиски говяжьи", 5.5, 1, 10.00),
(70, "Ветчина", 0, 1, 10.00),
(71, "Свинина тушеная консерв.", 0.3, 1, 10.00),
(72, "Говядина тушеная консерв.", 0.4, 1, 10.00),
(73, "Баранина тушеная консерв.", 0.3, 1, 10.00),
(74, "Гуляш говяжий консерв.", 1.7, 1, 10.00),
(75, "Почки в томатном соусе консерв.", 3.2, 1, 10.00),
(76, "Язык говяжий в желе консерв. ", 1.8, 1, 10.00),
(77, "Паштет мясной консерв.", 3.1, 1, 10.00),
(78, "Паштет печеночный консерв.", 1.0, 1, 10.00),
(79, "Куриное филе консерв.", 0.1, 1, 10.00),
(80, "Говядина консерв. с горохом", 10.2, 1, 10.00),
(81, "Говядина консерв. с макаронами", 10.2, 1, 10.00),
(82, "Говядина консерв. с фасолью", 9.5, 1, 10.00),
(83, "Свинина консерв. с фасолью", 11.9, 1, 10.00),
(84, "Завтрак туриста (говядина)", 0, 1, 10.00),
(85, "Колбасный фарш консерв.", 2.8, 1, 10.00),
(86, "Судак свежий", 0, 1, 10.00),
(87, "Треска", 0, 1, 10.00),
(88, "Севрюга", 0, 1, 10.00),
(89, "Семга", 0, 1, 10.00),
(90, "Кета", 0, 1, 10.00),
(91, "Горбуша", 0, 1, 10.00),
(92, "Чавыча", 0, 1, 10.00),
(93, "Кижач", 0, 1, 10.00),
(94, "Щука", 0, 1, 10.00),
(95, "Лещ", 0, 1, 10.00),
(96, "Сом", 0, 1, 10.00),
(97, "Карп", 0, 1, 10.00),
(98, "Навага", 0, 1, 10.00),
(99, "Сельдь свежая", 0, 1, 10.00),
(100, "Корюшка", 0, 1, 10.00),
(101, "Кета соленая", 0, 1, 10.00),
(102, "Сельдь соленая", 0, 1, 10.00),
(103, "Сельдь копченая", 0, 1, 10.00),
(104, "Вобла сушеная", 0, 1, 10.00),
(105, "Судак бланширов. ", 0, 1, 10.00),
(106, "Сельдь бланширов.", 0, 1, 10.00),
(107, "Сардины бланширов.", 0, 1, 10.00),
(108, "Печень трески бланширов.", 0, 1, 10.00),
(109, "Шпроты в масле", 0.7, 1, 10.00),
(110, "Кефаль в масле", 0.3, 1, 10.00),
(111, "Треска копченая в масле", 0, 1, 10.00),
(112, "Салака копченая в масле", 0, 1, 10.00),
(113, "Корюшка копченая в масле", 0, 1, 10.00),
(114, "Осетр в собственном соку", 1.0, 1, 10.00),
(115, "Горбуша в собственном соку", 0.5, 1, 10.00),
(116, "Кета в собственном соку", 0, 1, 10.00),
(117, "Белуга в собственном соку", 0, 1, 10.00),
(118, "Судак в собственном соку", 0, 1, 10.00),
(119, "Печень трески в собственном соку", 1.2, 1, 10.00),
(120, "Лещ в томате", 2.8, 1, 10.00),
(121, "Сом в томате", 4.3, 1, 10.00),
(122, "Судак в томате", 3.7, 1, 10.00),
(123, "Щука в томате", 3.6, 1, 10.00),
(124, "Печень трески в томате", 2.9, 1, 10.00),
(125, "Камбала в томате", 4.8, 1, 10.00),
(126, "Севрюга в томате", 2.8, 1, 10.00),
(127, "Килька пряного посола", 0, 1, 10.00),
(128, "Икра черная зернистая", 0, 1, 10.00),
(129, "Икра черная паюсная", 0, 1, 10.00),
(130, "Вобла копченая", 0, 1, 10.00),
(131, "Вобла вяленая", 0, 1, 10.00),
(132, "Лещ копченый", 0, 1, 10.00),
(133, "Горох", 50.1, 1, 10.00),
(134, "Гречневая", 63.4, 1, 10.00),
(135, "Кукуруза", 64.9, 1, 10.00),
(136, "Манная", 70.4, 1, 10.00),
(137, "Овсяная", 59.8, 1, 10.00),
(138, "Перловая", 66.2, 1, 10.00),
(139, "Пшено", 62.4, 1, 10.00),
(140, "Пшеничная крупа", 71.8, 1, 10.00),
(141, "Рис", 72.8, 1, 10.00),
(142, "Толокно", 62.7, 1, 10.00),
(143, "Фасоль", 50.7, 1, 10.00),
(144, "Ячневая", 66.2, 1, 10.00),
(145, "Макароны, лапша, вермишель", 70.9, 1, 10.00),
(146, "Сахар0рафинад. песок", 99.8, 1, 10.00),
(147, "Мед", 77.2, 1, 10.00),
(148, "Карамель леденцовая", 89.2, 1, 10.00),
(149, "Карамель с помадной начинкой", 83.4, 1, 10.00),
(150, "Карамель с фруктовой начинкой", 82.6, 1, 10.00),
(151, "Карамель с шоколадно0ореховой начинкой", 76.5, 1, 10.00),
(152, "Драже помадное", 83.9, 1, 10.00),
(153, "Драже ореховое в шоколаде", 66.1, 1, 10.00),
(154, "Конфеты шоколадные грильяж", 62.2, 1, 10.00),
(155, "Конфеты шоколадные, помадные", 71.8, 1, 10.00),
(156, "Конфеты шоколадные фруктовые", 66.6 , 1, 10.00),
(157, "Батончики ореховые", 39.7, 1, 10.00),
(158, "Тянучка сливочная", 73.7, 1, 10.00),
(159, "Помадка фруктовая", 86.5, 1, 10.00),
(160, "Ирис «Золотой ключик»", 72.2, 1, 10.00),
(161, "Шоколад ванильный", 55.3, 1, 10.00),
(162, "Шоколад «Золотой ярлык»", 46.5, 1, 10.00),
(163, "Шоколад молочный (десертиый)", 44.2, 1, 10.00),
(164, "Какао (порошок)", 17.9, 1, 10.00),
(165, "Мармелад желейный формовой", 69.9, 1, 10.00),
(166, "Мармелад яблочный формовой", 64.7, 1, 10.00),
(167, "Пастила", 80.4, 1, 10.00),
(168, "Зефир", 78.5, 1, 10.00),
(169, "Халва арахисовая", 39.2, 1, 10.00),
(170, "Халва подсолнечная", 36.7, 1, 10.00),
(171, "Халва тахинрая", 40.3, 1, 10.00),
(172, "Повидло яблочное", 62.0, 1, 10.00),
(173, "Варенье", 74.2, 1, 10.00),
(174, "Капуста белокачанная", 4.5, 1, 10.00),
(175, "Капуста квашеная", 1.8, 1, 10.00),
(176, "Капуста сушеная", 47.6, 1, 10.00),
(177, "Картофель", 20.0, 1, 10.00),
(178, "Картофель сушеный или крупка", 72.3, 1, 10.00),
(179, "Морковь", 7.4, 1, 10.00),
(180, "Морковь сушеная", 54.6, 1, 10.00),
(181, "Свекла", 8.8, 1, 10.00),
(182, "Свекла сушеная", 54.3, 1, 10.00),
(183, "Лук репчатый", 8.9, 1, 10.00),
(184, "Лук репчатый сушеный", 47.8, 1, 10.00),
(185, "Лук зеленый (перо)", 4.3, 1, 10.00),
(186, "Чеснок", 21.6, 1, 10.00),
(187, "Огурцы", 2.0, 1, 10.00),
(188, "Помидоры", 3.2, 1, 10.00),
(189, "Репа", 6.4, 1, 10.00),
(190, "Редис", 4.2, 1, 10.00),
(191, "Щавель", 2.9, 1, 10.00),
(192, "Горошек зеленый свежий", 10.3, 1, 10.00),
(193, "Горошек зеленый консерв.", 6.8, 1, 10.00),
(194, "Перец фаршированный консерв.", 9.9, 1, 10.00),
(195, "Икра баклажанная, кабачковая", 6.8, 1, 10.00),
(196, "Томатная паста", 15.0, 1, 10.00),
(197, "Борщ консерв.", 8.8, 1, 10.00),
(198, "Рассольник консерв.", 11.8, 1, 10.00),
(199, "Щи из свежей капусты консерв.", 8.1, 1, 10.00),
(200, "Грибы белые сушеные", 29.3, 1, 10.00),
(201, "Грибы белые свежие", 5.0, 1, 10.00),
(202, "Маслята свежие", 3.3, 1, 10.00),
(203, "Опята свежие", 3.8, 1, 10.00),
(204, "Яблоки", 11.5, 1, 10.00),
(205, "Смородина черная ", 9.8, 1, 10.00),
(206, "Смородина красная", 10.5, 1, 10.00),
(207, "Малина", 9.2, 1, 10.00),
(208, "Земляника", 8.9, 1, 10.00),
(209, "Абрикосы", 10.9, 1, 10.00),
(210, "Слива, алыча", 12.6, 1, 10.00),
(211, "Клюква", 8.6, 1, 10.00),
(212, "Арбуз", 7.7, 1, 10.00),
(213, "Дыня", 9.6, 1, 10.00),
(214, "Лимон", 9.3, 1, 10.00),
(215, "Сухофрукты в ассортименте", 62.0, 1, 10.00),
(216, "Абрикосы с косточкой (урюк)", 67.5, 1, 10.00),
(217, "Абрикосы без косточки (курага)", 65.9, 1, 10.00),
(218, "Виноград (изюм)", 70.9, 1, 10.00),
(219, "Виноград (кишмиш)", 71.2, 1, 10.00),
(220, "Груши сушеные", 62.1, 1, 10.00),
(221, "Персики (курага)", 68.5, 1, 10.00),
(222, "Чернослив", 65.6, 1, 10.00),
(223, "Яблоки сушеные", 68.0, 1, 10.00),
(224, "Орехи грецкие", 11.7, 1, 10.00),
(225, "Орехи лесные", 7.7, 1, 10.00),
(226, "Орехи кедровые", 12.3, 1, 10.00),
(227, "Миндаль", 11.9, 1, 10.00),
(228, "Кофе с молоком", 19.6, 1, 10.00),
(229, "Айран", 2.6, 1, 10.00),
(230, "Молоко кипяченое", 4.7, 1, 10.00),
(231, "Какао", 32.8, 1, 10.00)
 """);

  await database.execute(query);
}