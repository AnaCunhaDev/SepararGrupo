import 'package:SepararGrupos/providers/persons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPersons extends StatefulWidget {
  final bool isSwitched;
  final void Function() setStateLista;

  ListPersons(
    this.isSwitched,
    this.setStateLista,
  );

  @override
  _ListPersonsState createState() => _ListPersonsState();
}

class _ListPersonsState extends State<ListPersons> {
  bool isActive = false;
  Widget _createSectionContainer(Widget child) {
    var media = MediaQuery.of(context);
    return Container(
      width: media.size.width * 0.95,
      height: widget.isSwitched
          ? media.size.height * 0.32
          : media.size.height * 0.50,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 0,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  void dialogRemove(String text, void Function(String id) remove,
      [String id = '']) {
    final personProvider = Provider.of<PersonProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Tem Certeza?'),
            content: Text(text),
            actions: [
              FlatButton(
                child: Text('Não'),
                onPressed: () {
                  personProvider.toggleisActive(false);
                  setState(() {
                    isActive = false;
                  });
                  Navigator.of(ctx).pop();
                },
              ),
              FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    remove(id);
                    widget.setStateLista();
                    Navigator.of(ctx).pop();
                    setState(() {
                      isActive = false;
                    });
                  }),
            ],
          );
        });
  }

  void removeSelecionados(String x) {
    final personProvider = Provider.of<PersonProvider>(context, listen: false);
    personProvider.removeisActive();
  }

  @override
  Widget build(BuildContext context) {
    final personProvider = Provider.of<PersonProvider>(context, listen: false);
    var media = MediaQuery.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Total: ${personProvider.itemsCount}'),
            isActive
                ? Row(
                    children: [
                      TextButton(
                        child: Text('Excluir'),
                        onPressed: () {
                          dialogRemove('Quer remover estes nomes selecionados?',
                              removeSelecionados, '');
                          widget.setStateLista();
                        },
                      ),
                    ],
                  )
                : TextButton(
                    child: Text('Selecionar'),
                    onPressed: () {
                      setState(() {
                        isActive = true;
                      });
                    },
                  ),
          ],
        ),
        _createSectionContainer(
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: personProvider.itemsCount,
              itemBuilder: (ctx, i) {
                return Card(
                  child: ListTile(
                    title: Text('Nome: ${personProvider.itemByIndex(i).nome}'),
                    subtitle: Row(
                      children: [
                        Container(
                          width: media.size.height * 0.12,
                          child: Text(
                              'Idade: ${personProvider.itemByIndex(i).idade == 0 || personProvider.itemByIndex(i).idade == null ? '-' : personProvider.itemByIndex(i).idade.toString()}'),
                        ),
                        //SizedBox(width: media.size.height * 0.05),
                        Container(
                          width: media.size.height * 0.15,
                          child: Text(
                              'Habilidade: ${personProvider.itemByIndex(i).classificacao}'),
                        ),
                      ],
                    ),
                    trailing: isActive
                        ? Checkbox(
                            value: personProvider.items[i].isActive,
                            onChanged: (bool value) {
                              //print(value);
                              setState(() {
                                personProvider.items[i].isActive = value;
                              });
                            })
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              dialogRemove(
                                  'Quer remover o ${personProvider.itemByIndex(i).nome}?',
                                  personProvider.remove,
                                  personProvider.items[i].id);
                              widget.setStateLista();
                            }),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
