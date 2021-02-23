import 'package:SepararGrupos/providers/filter_model.dart';
import 'package:SepararGrupos/providers/person.dart';
import 'package:flutter/material.dart';
import 'package:list_ext/list_ext.dart';

class PersonProvider with ChangeNotifier {
  List<Person> _items = [];

  /* Future<void> loadPersons() async {
    final dataList = await PersonData.getData();
    _items = dataList
        .map(
          (item) => Person(
            id: item['id'],
            idade: item['idade'],
            nome: item['nome'],
            classificacao: item['classificacao'],
            isActive: false,
          ),
        )
        .toList();
    notifyListeners();
  }
 */
  List<Person> get items {
    return [..._items.reversed];
  }

  List<Person> get itemsIdade {
    List<Person> listAge = items;
    listAge.sort((a, b) => a.idade.compareTo(b.idade));
    return listAge;
  }

  int get itemsCount {
    return _items.length;
  }

  Person itemByIndex(int index) {
    return _items[index];
  }

  void add(Person person) {
    _items.add(
      Person(
        id: person.id,
        nome: person.nome,
        idade: person.idade,
        classificacao: person.classificacao,
        isActive: person.isActive,
      ),
    );
    /* try {
      PersonData.insert({
        'id': person.id,
        'nome': person.nome,
        'idade': person.idade,
        'classificacao': person.classificacao,
        'isActive': (person.isActive) ? 1 : 0,
      });
    } on DatabaseException catch (e) {
      print(e);
    } */
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((element) => element.id == id);
    // PersonData.delete([id], 'id = ?');
    notifyListeners();
  }

  void removeisActive() {
    _items.removeWhere((element) => element.isActive == true);
    /*   _items.forEach((element) {
      if (element.isActive == true) PersonData.delete([element.id], 'id = ?');
    }); */

    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    //PersonData.deleteAll();
    notifyListeners();
  }

  void toggleisActive(bool value) {
    _items.forEach((element) {
      element.isActive = value;
    });
    // PersonData.updateIsActiveAll({'isActive': value ? 1 : 0});
    notifyListeners();
  }

  void toggleisActiveById(String id, bool value) {
    //PersonData.updatebyId({'isActive': value ? 1 : 0}, id);
    notifyListeners();
  }

  List<List<Person>> dividirGrupo(
      int tam, List<Person> selectsorted, int sobra) {
    List<List<Person>> listaDividida = List();

    for (int i = 1; i < selectsorted.length; i += tam) {
      List<Person> newList = selectsorted.sublist(i - 1, (i - 1 + tam));

      listaDividida.add(newList);
    }
    if (sobra == 1) {
      listaDividida.last.add(selectsorted.last);
    }
    return listaDividida;
  }

  List<Person> dividirDiferente(int tam, List<Person> selectsorted, int qtd) {
    List<Person> newList = List();
    int tamanho = tam;
    // print('tamanho do grupo = $tam, quatidade de grupos $qtd');
    tamanho <= 3 ? tamanho = qtd : tamanho = tam;

    for (int i = 0; i < tamanho; i++) {
      for (int j = i; j < selectsorted.length; j += tamanho) {
        newList.add(selectsorted[j]);

        /*  print(
            'Letra da vez ${selectsorted[j].nome} com hab ${selectsorted[j].classificacao}'); */
      }
    }

    return newList;
  }

  int contadorHabilidade(List<Person> selectsorted, FilterModel filter) {
    List<int> cont = [
      selectsorted.countWhere((element) => element.classificacao == 5),
      selectsorted.countWhere((element) => element.classificacao == 4),
      selectsorted.countWhere((element) => element.classificacao == 3),
      selectsorted.countWhere((element) => element.classificacao == 2),
    ];
    for (int i = 0; i < cont.length; i++) {
      if (cont[i] != 0) return cont[i];
    }
    return filter.tam;
  }

  List<List<Person>> sorted(FilterModel filter) {
    List<List<Person>> chunks;
    List<Person> selectsorted;
    selectsorted = items;
    var resFilter = FilterModel.verify(filter);
    selectsorted.shuffle();
    if (resFilter == Tipos.Idade) {
      selectsorted.sort((a, b) => a.idade.compareTo(b.idade));
    } else if (resFilter == Tipos.Misto) {
      selectsorted.sort((a, b) => a.idade.compareTo(b.idade));
      selectsorted = dividirDiferente(contadorHabilidade(selectsorted, filter),
          selectsorted.reversed.toList(), filter.qtd);
    } else {
      selectsorted.sort((a, b) => a.classificacao.compareTo(b.classificacao));
      selectsorted = dividirDiferente(contadorHabilidade(selectsorted, filter),
          selectsorted.reversed.toList(), filter.qtd);
    }
    chunks = dividirGrupo(filter.tam, selectsorted, filter.sobra);
    return chunks;
  }
}
