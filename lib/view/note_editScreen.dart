import 'package:flutter/material.dart';
import 'package:notes/controller/sql_flite_controller.dart';

import '../config/routes/routes.dart';

class NoteEditScreen extends StatefulWidget {
  final String note;
  final String title;
  final String subTitle;
  final String color;
  final int id;
  @override
  State<StatefulWidget> createState() {
    return _NoteEditScreenState();
  }

  const NoteEditScreen({
    required this.note,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.id,
  });
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  NoteSqlDb sqlDb = NoteSqlDb();

  GlobalKey<FormState> formState = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    subtitle.text = widget.subTitle;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteEditScreen"),
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
                      child: Text("update to data"),
                      onPressed: () async {
                        /*     int response = await sqlDb.updateData('''
                              UPDATE Notes SET
                              note = "${note.text}",
                              title = "${title.text}",
                              subtitle ="${subtitle.text}",
                              color ="${color.text}"
                              WHERE id = ${widget.id}
                              ''');*/
                        int response = await sqlDb.update(
                            table: 'Notes',
                            values: {
                              "note": note.text,
                              "title": title.text,
                              "subtitle": subtitle.text,
                              "color": color.text
                            },
                            where: "id= ${widget.id}");
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
      ),
    );
  }
}
