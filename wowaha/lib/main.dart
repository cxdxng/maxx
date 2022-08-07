// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:wowaha/AddUser.dart';
import 'package:wowaha/ChangeNumber.dart';
import 'package:wowaha/DatabaseHelper.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/":(context) => HomePage(),
      "/addPerson":(context) => ChangeNumber(),
      "/addUser":((context) => AddUser()),
    }));
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final nummerController = TextEditingController();

  String pName = "Mustermann";
  String pNummer= "0";
  String platzNummer = "A000";
  String telNr = "01724567890";

  final dbHelper = DatabaseHelper.instance;
  FlutterTts tts = FlutterTts();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,20),
              child: Text(
                "$pName (Nr.$pNummer): PLATZ $platzNummer",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                ElevatedButton(
                  onPressed:() => getSQLData(int.parse(nummerController.text)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Suchen",
                      style: TextStyle(
                        fontSize: 30
                      ),
                    ),
                  )
                ),

                TextButton(
                  onPressed:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNumber()));
                  },
                  child: Text(
                    "Stellplatz ändern",
                    style: TextStyle(
                      fontSize: 30
                    ),
                  )
                ),


                TextButton(
                  onPressed:() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddUser()));
                  },
                  child: Text(
                    "Neu Einfügen",
                    style: TextStyle(
                      fontSize: 30
                    ),
                  )
                ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Vertragsnummer',
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                controller: nummerController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,20),
              child: Text(
                "Tel.: $telNr",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
      
    );
  }


  void getSQLData(int id)async{

    List<Map<String, dynamic>> row = await dbHelper.queryOneRow(id);
    
    

    if(row.isNotEmpty){
      pNummer = (row[0]['id']).toString();
      pName = row[0]['name'];
      platzNummer = row[0]['platznr'];
      telNr = row[0]['number'];
      setState(() {
        
      });
    }

  }

  void getAllData()async{
    List<Map<String, dynamic>> row = await dbHelper.queryAllRows();
    print(row);
  }

  




}