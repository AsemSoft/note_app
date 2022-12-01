import 'package:flutter/material.dart';
import 'package:notes/view/note_editScreen.dart';

import '../config/routes/routes.dart';
import '../controller/sql_flite_controller.dart';

class NoteHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteHomeScreenState();
  }
}

class _NoteHomeScreenState extends State<NoteHomeScreen> {
  NoteSqlDb sqlDb = NoteSqlDb();
  List notes = [];
  bool isLoaded = true;

  // sort data coming
  _readData() async {
    // first way to fetch data using query
    // List<Map> response = await sqlDb.readData('SELECT * FROM Notes');
    // second way to fetch data calling table

    List<Map> response = await sqlDb.read('Notes');

    notes.addAll(response);
    isLoaded = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteHomeScreen"),
      ),
      body: isLoaded == true
          ? const Center(
              child: Text('loading ...'),
            )
          : Column(children: [
              /*  ElevatedButton(
              child: Text("insert data"),
              onPressed: () {
                sqlDb.insertData(
                    "INSERT INTO Notes (note,part) VALUES('asem','ahmed')");
                print("RaisedButton");
              }),*/
              ElevatedButton(
                  onPressed: () {
                    NoteSqlDb.deleteDataBase();
                    Navigator.pushReplacementNamed(
                        context, Routes.initialRoute);
                  },
                  child: const Text('delete data base')),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: Text('${notes[index]['id']}'),
                      title: Text('${notes[index]['note']}'),
                      subtitle:
                          Text('${notes[index]['subtitle'] ?? 'no data'}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                /*     var response = await sqlDb.deleteData(
                                    'DELETE FROM Notes WHERE id =${notes[index]['id']}');
                                if (response > 0) {
                                  notes.removeWhere((element) =>
                                      element['id'] == notes[index]['id']);
                                }*/
                                int response = await sqlDb.delete(
                                    table: 'Notes',
                                    where: 'id =${notes[index]['id']}');
                                if (response > 0) {
                                  notes.removeWhere((element) =>
                                      element['id'] == notes[index]['id']);
                                }
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                /* Navigator.pushNamed(
                                    context, Routes.editNoteScreen,
                                    arguments: EditNoteScreen(
                                      note: notes[index]['note'],
                                      title: notes[index]['title'],
                                      subTitle: notes[index]['subtitle'],
                                      color: notes[index]['color'],
                                      id: notes[index]['id'],
                                    ));*/
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NoteEditScreen(
                                              note: notes[index]['note'],
                                              title: notes[index]['title'],
                                              subTitle: notes[index]
                                                  ['subtitle'],
                                              color: notes[index]['color'],
                                              id: notes[index]['id'],
                                            )));
                              },
                              icon: const Icon(Icons.edit)),
                        ],
                      ),
                    ),
                  );
                },

                //CRUD SQLFLITE with tereminal testing
                /*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  int response = await sqlDb
                      .insertData("INSERT INTO Notes (note) VALUES('welcome')");
                  print('================');
                  print("response in insert Data is $response");
                  print('================');
                },
                child: const Text('get data')),
            ElevatedButton(
                onPressed: () async {
                  var response = await sqlDb.insertData(
                    "INSERT INTO Notes (note,name) VALUES('welcome','asem')",
                  );
                  print('================');
                  print("response in read Data is $response");
                  print('================');
                },
                child: const Text('inset with out try data')),
            // read data form DB
            ElevatedButton(
                onPressed: () async {
                  var response = await sqlDb.readData(
                    "SELECT * FROM Notes",
                  );
                  print('================');
                  print("response in read Data is $response");
                  print('================');
                },
                child: const Text('read data')),
            // delete data form DB
            ElevatedButton(
                onPressed: () async {
                  var response = await sqlDb.deleteData(
                    "DELETE FROM Notes WHERE note='welcome'",
                  );
                  print('================');
                  print("response in read Data is $response");
                  print('================');
                },
                child: const Text('delte data')),
            // update
            ElevatedButton(
                onPressed: () async {
                  var response = await sqlDb.updateData(
                    "UPDATE Notes  SET 'note'='ali' WHERE note='welcome'",
                  );
                  print('================');
                  print("response in read Data is $response");
                  print('================');
                },
                child: const Text('update data')),
          ],
        ),*/
              ),
            ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.noteAddScreen);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
