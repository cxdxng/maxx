// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wowaha/DatabaseHelper.dart';

class ChangeNumber extends StatelessWidget {
  ChangeNumber({ Key? key }) : super(key: key);

  TextEditingController idController = TextEditingController();
  TextEditingController stellplatzController = TextEditingController();
  TextEditingController telController = TextEditingController();
  
  final dbHelper = DatabaseHelper.instance;


  @override
  Widget build(BuildContext context) {

    
    return SafeArea(
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(50,80,50,10),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Vertragsnummer',
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                  controller: idController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(50,10,50,10),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Neue Stellplatznummer (Bsp.: A043)',
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                  controller: stellplatzController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40),
                ),
              ),


              Padding(
                padding: const EdgeInsets.fromLTRB(50,10,50,10),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Neue Telefonnummer',
                      hintStyle: TextStyle(color: Colors.grey)
                    ),
                  controller: telController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40),
                ),
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed:(){
                      insertSQLData();
                      var snackBar = SnackBar(content: Text('Gespeichert', style: TextStyle(fontSize: 50),));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Speichern",
                        style: TextStyle(
                          fontSize: 36
                        ),
                      ),
                    )
                  ),

                  ElevatedButton(
                    onPressed:() {
                      
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Zurück",
                        style: TextStyle(
                          fontSize: 36
                        ),
                      ),
                    )
                  ),
                ],
              )


              
            ],
          ),
        ),
      ),
    );
  }




  void insertSQLData(){


    var value = {
     'id': idController.text,
     'platznr': stellplatzController.text,
     'number': telController

   };
    
    dbHelper.update(value);
  }
}