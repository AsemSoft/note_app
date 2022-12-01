import 'package:flutter/material.dart';
import 'package:notes/controller/sql_flite_controller.dart';

import '../config/routes/routes.dart';

class NoteAddSceen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteAddSceenState();
  }
}

class _NoteAddSceenState extends State<NoteAddSceen> {
  NoteSqlDb sqlDb = NoteSqlDb();

  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteAddSceen"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: 'Write your note',
                    ),
                  ),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: 'Write your title',
                    ),
                  ),
                  TextFormField(
                    controller: subtitle,
                    decoration: const InputDecoration(
                      hintText: 'Write your subtitle',
                    ),
                  ),
                  TextFormField(
                    controller: color,
                    decoration: const InputDecoration(
                      hintText: 'Write your color',
                    ),
                  ),
                  ElevatedButton(
                      child: Text("add to data"),
                      onPressed: () async {
                        // int response = await sqlDb.insertData(
                        //     '''INSERT INTO Notes ('note','title','subtitle','color')
                        //      VALUES ("${note.text}","${title.text}","${subtitle.text}","${color.text}")
                        //     ''');
                        int response = await sqlDb.insert('Notes', {
                          'note': note.text,
                          'title': title.text,
                          'subtitle': subtitle.text,
                          'color': color.text,
                        });
                        print(response);
                        if (response > 0) {
                          Navigator.pushReplacementNamed(
                              context, Routes.initialRoute);
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
