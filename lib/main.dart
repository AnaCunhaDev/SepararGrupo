import 'package:SepararGrupos/providers/persons.dart';
import 'package:SepararGrupos/screens/filter_screen.dart';
import 'package:SepararGrupos/screens/form.dart';
import 'package:SepararGrupos/screens/sorted_list_screen.dart';
import 'package:SepararGrupos/utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new PersonProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Divisão de Grupos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          AppRoutes.HOME: (ctx) => FormScreen(),
          AppRoutes.FILTER: (ctx) => FilterScreen(),
          AppRoutes.SORTED: (ctx) => SortedListScreen(),
        },
      ),
    );
  }
}
