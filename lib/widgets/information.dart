import 'package:SepararGrupos/providers/filter_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Information extends StatefulWidget {
  void Function(Map<String, int>) onSubmit;
  FilterModel filter;
  int listLength;

  Information(this.filter, this.listLength, this.onSubmit);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  int _selectItem;
  List<Map<String, int>> calculaPosibilidade() {
    List<Map<String, int>> res = List();

    for (int i = 2; i <= widget.listLength / 2; i++) {
      if (possibilidades(i)) {
        var rs = {
          'tam': (widget.listLength / i).floor(),
          'qtd': i,
          'diferente': widget.listLength % i == 1 ? 1 : 0,
        };
        res.add(rs);
      }
    }

    return res;
  }

  String possibilidadesText(int tam, int qtd) {
    String res = '';
    if (widget.listLength % qtd == 0) {
      res = '$qtd grupos de  $tam pessoas';
    } else if (widget.listLength % qtd == 1) {
      res =
          '${qtd - 1} grupos de  $tam pessoas e 1 grupo de ${tam + 1} pessoas';
    } else {
      res = null;
    }
    return res;
  }

  bool possibilidades(int i) {
    if (widget.listLength % i == 0 || widget.listLength % i == 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, int>> res = calculaPosibilidade();
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: res.length,
      itemBuilder: (ctx, i) {
        return Container(
          child: ListTile(
              title: Text(
                possibilidadesText(res[i]['tam'], res[i]['qtd']),
                style: TextStyle(fontSize: 18),
              ),
              selected: i == _selectItem,
              onTap: () {
                setState(() {
                  _selectItem = i;
                });

                widget.onSubmit({
                  'qtd': res[i]['qtd'],
                  'tam': res[i]['tam'],
                  'sobra': res[i]['diferente'],
                });
              }),
        );
      },
    );
    //return Text('Tste');
  }
}
