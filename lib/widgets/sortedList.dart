import 'package:SepararGrupos/providers/person.dart';
import 'package:flutter/material.dart';

class SortedList extends StatelessWidget {
  final List<Person> list;

  SortedList(this.list);
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (ctx, j) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: media.size.width * 0.35,
                child: Text(
                  list[j].nome,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(width: media.size.width * 0.05),
              Container(
                width: media.size.width * 0.20,
                child: Text(
                  list[j].idade != 0 ? list[j].idade.toString() : '-',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(width: media.size.width * 0.05),
              Container(
                width: media.size.width * 0.20,
                child: Text(
                  list[j].classificacao.toString(),
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/*  */
