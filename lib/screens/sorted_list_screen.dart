import 'package:SepararGrupos/providers/filter_model.dart';
import 'package:SepararGrupos/providers/person.dart';
import 'package:SepararGrupos/providers/persons.dart';
import 'package:SepararGrupos/screens/form.dart';

import 'package:SepararGrupos/widgets/sortedList.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SortedListScreen extends StatefulWidget {
  @override
  _SortedListScreenState createState() => _SortedListScreenState();
}

class _SortedListScreenState extends State<SortedListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _copyText = '';

  Widget _createSectionContainer(Widget child) {
    var media = MediaQuery.of(context);
    return SingleChildScrollView(
      child: Container(
        width: media.size.height * 0.95,
        height: media.size.height * 0.75,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            child,
            Positioned(
              right: -4,
              child: IconButton(
                alignment: Alignment.topRight,
                icon: Icon(Icons.copy),
                onPressed: () {
                  //copiar para area de transferencia
                  ClipboardManager.copyToClipBoard(_copyText).then(
                    (result) {
                      final snackbar = SnackBar(
                        content: Text('Texto Copiado'),
                        duration: Duration(milliseconds: 500),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackbar);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyTextName(List<List<Person>> res) {
    int i = 1;
    res.forEach((lista) {
      _copyText += 'Grupo $i\n';
      lista.forEach((element) {
        _copyText += '- ${element.nome}\n';
      });
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PersonProvider personProvider = Provider.of(context, listen: false);
    final FilterModel filter = ModalRoute.of(context).settings.arguments;
    List<List<Person>> res = personProvider.sorted(filter);

    _copyTextName(res);
    var media = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Divisão de Grupos'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _createSectionContainer(
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: res.length,
                  itemBuilder: (ctx, i) {
                    return Column(
                      children: [
                        Text(
                          'Grupo ${i + 1}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: media.size.width * 0.35,
                              child: Text(
                                'Nome',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(width: media.size.width * 0.05),
                            Container(
                              width: media.size.width * 0.20,
                              child: Text(
                                'Idade',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            SizedBox(width: media.size.width * 0.05),
                            Container(
                              width: media.size.width * 0.20,
                              child: Text(
                                'Hab.',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        SortedList(res[i]),
                        Divider(
                          color: Colors.black87,
                        )
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      _copyText = '';
                      setState(() {
                        res = personProvider.sorted(filter);
                      });
                    },
                    child: Text('Resortear'),
                  ),
                  RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      _copyText = '';
                      personProvider.removeAll();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => FormScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text('Novo Sorteio'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
