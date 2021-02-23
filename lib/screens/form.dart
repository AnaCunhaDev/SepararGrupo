import 'dart:math';

import 'package:SepararGrupos/providers/person.dart';
import 'package:SepararGrupos/providers/persons.dart';
import 'package:SepararGrupos/utils/appRoutes.dart';
import 'package:SepararGrupos/widgets/counter.dart';
import 'package:SepararGrupos/widgets/list_persons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _form = GlobalKey<FormState>();
  Person _person = new Person();
  List<Person> persons = [];
  FocusNode myFocusNode;
  bool isSwitched = false;

  void _saveForm() {
    FocusScope.of(context).unfocus(); // esconder teclado
    final PersonProvider personProvider =
        Provider.of<PersonProvider>(context, listen: false);
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    _person.id = Random().nextDouble().toString();
    _person.idade = _person.idade == null ? 0 : _person.idade;

    personProvider.add(_person);

    persons.clear();
    setState(() {
      persons = personProvider.items.reversed.toList();
    });
    _form.currentState.reset();
  }

  void _setStateLista() {
    final PersonProvider personProvider =
        Provider.of<PersonProvider>(context, listen: false);
    setState(() {
      persons = personProvider.items.reversed.toList();
    });
  }

  void _onSubmit(int cont) {
    setState(() {
      _person.classificacao = cont;
    });
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // limpa o no focus quando o form for liberado.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var media = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Separar Grupos'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          icon: Icon(Icons.person),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(myFocusNode);
                        },
                        validator: (value) {
                          bool isEmpty = value.trim().isEmpty;
                          bool isInvalid = value.trim().length < 1;
                          if (isEmpty || isInvalid) {
                            return 'Informe um nome com pelo menos 1 caracter';
                          }
                          return null;
                        },
                        onSaved: (value) => _person.nome = value,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Campos Opcionais',
                            style: TextStyle(fontSize: 20),
                          ),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                //print(isSwitched);
                              });
                            },
                            activeTrackColor: Colors.lightBlue,
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                      if (isSwitched)
                        TextFormField(
                          focusNode: myFocusNode,
                          //initialValue: _person.idade.toString(),
                          decoration: InputDecoration(
                            labelText: 'Idade',
                            icon: Icon(Icons.alarm),
                            hintText: 'Opcional',
                          ),

                          keyboardType: TextInputType.numberWithOptions(),
                          onSaved: (value) => _person.idade =
                              int.tryParse(value) == null
                                  ? 0
                                  : int.tryParse(value),
                        ),
                      if (isSwitched)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Nivel de Habilidade: ',
                              style: TextStyle(fontSize: 18),
                            ),
                            Counter(_onSubmit),
                          ],
                        ),
                      if (isSwitched) SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RaisedButton(
                            onPressed: _saveForm,
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              'Adicionar Pessoa',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          RaisedButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text(
                              'Próximo',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: persons.length <= 3
                                ? null
                                : () {
                                    //print(persons.length);
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.FILTER,
                                    );
                                  },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                persons.length <= 0
                    ? Text('Pessoas ainda não cadastradas')
                    //SizedBox(height: 10),
                    : ListPersons(isSwitched, _setStateLista),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* if (isSwitched)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              new Radio<Sexo>(
                                value: Sexo.Homem,
                                groupValue: _person.sexo,
                                onChanged: _handleRadioValueSexo,
                              ),
                              new Text(
                                'Homem',
                                style: new TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                          if (isSwitched)
                            Row(
                              children: [
                                new Radio<Sexo>(
                                  value: Sexo.Mulher,
                                  groupValue: _person.sexo,
                                  onChanged: _handleRadioValueSexo,
                                ),
                                new Text(
                                  'Mulher',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    SizedBox(height: 10), */
