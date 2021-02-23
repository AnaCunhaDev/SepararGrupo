import 'package:SepararGrupos/providers/filter_model.dart';
import 'package:SepararGrupos/providers/person.dart';

import 'package:SepararGrupos/providers/persons.dart';
import 'package:SepararGrupos/utils/appRoutes.dart';

import 'package:SepararGrupos/widgets/information.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  FilterModel filter = FilterModel();

  void _handleCounter(Map<String, int> counter) {
    setState(() {
      filter.qtd = counter['qtd'];
      filter.tam = counter['tam'];
      filter.sobra = counter['sobra'];
    });
    //print(filter.count);
  }

  bool _verificaFiltroIdade(List<Person> lista) {
    //se possuir uma pessoa da lista com idade retorna true;
    int count = 0;
    lista.forEach((element) {
      if (element.idade != null && element.idade > 0) {
        count++;
      }
    });
    return count >= 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    PersonProvider personProvider = Provider.of(context);
    if (!_verificaFiltroIdade(personProvider.items)) {
      setState(() {
        filter.isCheckedBemAleatorio = true;
      });
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Filtros'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Como deseja dividir os grupos?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              title: const Text(
                'Idades Parecidas',
                style: TextStyle(fontSize: 18),
              ),
              secondary: const Icon(Icons.timer),
              activeColor: Colors.red,
              checkColor: Colors.yellow,
              selected: filter.isCheckedPorIdade,
              value: filter.isCheckedPorIdade,
              onChanged: !_verificaFiltroIdade(personProvider.items) ||
                      filter.isCheckedBemAleatorio ||
                      filter.isCheckedPorIdadadeEquilibrada
                  ? null
                  : (bool value) {
                      setState(() {
                        filter.isCheckedPorIdade = value;
                      });
                    },
            ),
            CheckboxListTile(
              title: const Text(
                'Idade equilibrada',
                style: TextStyle(fontSize: 18),
              ),
              secondary: const Icon(Icons.timer),
              activeColor: Colors.red,
              checkColor: Colors.yellow,
              selected: filter.isCheckedPorIdadadeEquilibrada,
              value: filter.isCheckedPorIdadadeEquilibrada,
              onChanged: !_verificaFiltroIdade(personProvider.items) ||
                      filter.isCheckedBemAleatorio ||
                      filter.isCheckedPorIdade
                  ? null
                  : (bool value) {
                      setState(() {
                        filter.isCheckedPorIdadadeEquilibrada = value;
                      });
                    },
            ),
            CheckboxListTile(
              title: const Text(
                'Aleatório',
                style: TextStyle(fontSize: 18),
              ),
              secondary: const Icon(Icons.group_work),
              activeColor: Colors.red,
              checkColor: Colors.yellow,
              selected: filter.isCheckedBemAleatorio,
              value: filter.isCheckedBemAleatorio,
              onChanged: filter.isCheckedPorIdade ||
                      filter.isCheckedPorIdadadeEquilibrada
                  ? null
                  : (bool value) {
                      setState(() {
                        filter.isCheckedBemAleatorio = value;
                      });
                    },
            ),
            Text(
              'Quantos grupos?',
              style: TextStyle(fontSize: 18),
            ),
            Information(filter, personProvider.itemsCount, _handleCounter),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(
                'Sortear',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: filter.tam < 2
                  ? null
                  : () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.SORTED, arguments: filter);
                    },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

/*  CheckboxListTile(
              title: const Text(
                'Por Sexo',
                style: TextStyle(fontSize: 18),
              ),
              secondary: const Icon(Icons.person),
              activeColor: Colors.red,
              checkColor: Colors.yellow,
              selected: filter.isCheckedPorSexo,
              value: filter.isCheckedPorSexo,
              onChanged: filter.isCheckedBemAleatorio ||
                      !_verificaFiltroSexo(personProvider.items)
                  ? null
                  : (bool value) {
                      setState(() {
                        filter.isCheckedPorSexo = value;
                      });
                    },
            ), */
