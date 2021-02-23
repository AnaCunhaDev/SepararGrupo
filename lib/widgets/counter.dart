import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Counter extends StatefulWidget {
  void Function(int) onSubmit;

  Counter(this.onSubmit);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            setState(() {
              if (_counter >= 5) {
                _counter = 5;
              } else {
                _counter++;
              }
            });
            widget.onSubmit(_counter);
          },
        ),
        Text(_counter < 1 ? 1.toString() : _counter.toString()),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            setState(() {
              if (_counter <= 1) {
                _counter = 1;
              } else {
                _counter--;
              }
            });
            widget.onSubmit(_counter);
          },
        ),
      ],
    );
  }

/* class _CounterState extends State<Counter> {
  int _counter;

  @override
  Widget build(BuildContext context) {
    _counter = 1;
    return Row(
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _counter++;
              });
              widget.onSubmit(_counter);
            },
          ),
        ),
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Text(
            _counter < 1 ? 1.toString() : _counter.toString(),
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          color: Theme.of(context).primaryColor,
          child: IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (_counter < 1) {
                  _counter = 1;
                } else {
                  _counter--;
                }
              });
            },
          ),
        ),
      ],
    );
  } */
}
