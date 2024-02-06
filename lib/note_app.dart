

import 'package:flutter/material.dart';
import 'package:hello/Models/note_model.dart';
import 'package:hello/boxes/boxes.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
//import 'package:hive/hive.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

TextEditingController title = TextEditingController();
TextEditingController description = TextEditingController();

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes app"),
      backgroundColor: Colors.greenAccent,),
      body: ValueListenableBuilder<Box<NotesModel>>(
        
        valueListenable: Boxes.getdata().listenable(), 
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return SafeArea(
            child: ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context, index) {
                return Card(
                  
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(data[index].title.toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                           const  Spacer(),
                       
                           IconButton(onPressed: (){
                            Delete(data[index]);
                            }, icon: const Icon(Icons.delete,color: Colors.red,))  ,

                            IconButton(
                              onPressed: (){
                            _Edit(data[index],data[index].title.toString(),data[index].Description.toString());
                            }, icon: const Icon(Icons.edit))  
                           
                      
                          ],
                        ),
                        
                      
                        Text(data[index].Description.toString()),
                      ],
                    ),
                  ),
                );
              },),
          ) ;
        },)     ,
       floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: ()async{
        _showMydialogue();
         
      },child:const  Icon(Icons.note_add_outlined,color: Colors.white,),),
    );

     
  }

  void Delete (NotesModel notesModel)async{
    await notesModel.delete();

  } 
 
Future<void>_showMydialogue() async{

     return showDialog(
      context: context, 
      builder: (context){
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 11,),
            TextFormField(
              controller: description,
              decoration:const InputDecoration(
                hintText: 'Decsription',
                border: OutlineInputBorder(),
              ),
            )
          ]),
      ),
      title: const Text("Add Notes",style: TextStyle(fontWeight: FontWeight.bold),),
      actions: [
        TextButton(
          onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancle")),
        
         TextButton(
          onPressed: (){
        
        final data = NotesModel(title: title.text, Description: description.text);

        var box = Boxes.getdata();
        box.add(data);
       data.save();
       title.clear();
       description.clear();
        print(data);
       Navigator.pop(context);
        }, child: const Text("Add")),

      ],
    );
      });
  }
 

 Future<void>_Edit(NotesModel notesModel , String Title , String Description) async{

title.text=Title;
description.text=Description;

     return showDialog(
      context: context, 
      builder: (context){
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: title,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 11,),
            TextFormField(
              controller: description,
              decoration:const InputDecoration(
                hintText: 'Decsription',
                border: OutlineInputBorder(),
              ),
            )
          ]),
      ),
      title: const Text("Edit",style: TextStyle(fontWeight: FontWeight.bold),),
      actions: [
        TextButton(
          onPressed: (){
          Navigator.pop(context);
        }, child: const Text("Cancle")),
        
         TextButton(
          onPressed: ()async{
         
         notesModel.title= title.text.toString();
         notesModel.Description= description.text.toString();
         await notesModel.save();
         title.clear();
         description.clear();
         
       
       Navigator.pop(context);
        }, child: const Text("Edit")),

      ],
    );
      });
  }
 

 
}
