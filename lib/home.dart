import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Box> _boxFuture;

  @override
  void initState() {
    super.initState();
    _boxFuture = Hive.openBox('Atif');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hive Database",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
            decorationColor: Colors.white,
            decorationThickness: 3,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _boxFuture,
              builder: (context, AsyncSnapshot<Box> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loading indicator while the box is being opened
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return Text('No data available'); // Handle case where the box is null
                }
                return ListTile(
                  title: Text(snapshot.data!.get("Name").toString()),
                  subtitle: Text(snapshot.data!.get("Age").toString()),
                  trailing: IconButton(
                    onPressed: (){
                      setState(() {
                        
                      });
                     snapshot.data!.put("Name",'KHAAAA');
                  }, icon: const Icon(Icons.edit)),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var box = await _boxFuture;
          box.put('Name', "Afridi");
          box.put('Age', 20);
          box.put('City', "Peshawar");
          box.put("Hkkk", {"Hello": "Developer", "Noooo": 111},);

          print(box.get('Name'));
          print(box.get('Age'));
          print(box.get('City'));
          print(box.get('Hkkk')['Hello']);
        },
        child: const Center(child: Icon(Icons.add)),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
