
import 'package:hello/Models/note_model.dart';
import 'package:hive/hive.dart';

class Boxes{

static Box<NotesModel> getdata() => Hive.box<NotesModel>('notes'); 


}