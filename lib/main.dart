

import 'package:flutter/material.dart';
import 'package:hello/Models/note_model.dart';
// import 'package:hello/home.dart';
import 'package:hello/note_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main()async{

WidgetsFlutterBinding.ensureInitialized();
var document = await getApplicationDocumentsDirectory();
Hive.init(document.path);
Hive.registerAdapter(NotesModelAdapter());
await Hive.openBox<NotesModel>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Notes(),
    );
  }
}

