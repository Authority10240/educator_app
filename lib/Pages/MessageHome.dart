import'package:flutter/material.dart';
import 'package:educator_app/SQL_Models/year_Model.dart';
import "package:sqflite/sqflite.dart";
import 'CreateQR.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'Subject_list.dart';
    
    class MessageHome extends StatefulWidget {
      @override
      _MessageHomeState createState() => _MessageHomeState();
    }
    
    class _MessageHomeState extends State<MessageHome> {
      List<YearInformation> yearInfo ;
      DBHelper dbHelper = new DBHelper() ;
      @override
      Widget build(BuildContext context) {

        if(yearInfo == null){
          yearInfo = new List();
          updateListView();
        }
        return Scaffold(
          floatingActionButton:
          FloatingActionButton.extended(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CreateQR()));
          },
            label:Text("Add QR"),
            icon: Icon(Icons.add_box) ,backgroundColor: Colors.blueAccent,),
          body: ListView.builder(itemCount: yearInfo.length,itemBuilder:(context,i)=>
          new Column(
            children: <Widget>[
              new Divider(
                height: 10,

              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                child: Text(yearInfo[i].SCHOLAR_YEAR[2] + yearInfo[i].SCHOLAR_YEAR[3]),),
                title: Text(yearInfo[i].SCHOLAR_YEAR, style: TextStyle(color: Colors.black),),
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SubjectList(yearInfo[i])));

                },
              )
            ],
          )),
          
      //    body: ListView.builder(itemBuilder: null),
        );
      }

      updateListView(){

        final Future<Database> dbFuture = dbHelper.initDB();
        dbFuture.then((database){
          Future<List<YearInformation>> yearListFuture = dbHelper.getYearList();
          yearListFuture.then((yearList){
            setState(() {
              this.yearInfo = yearList;
            });
            });
        });
      }
    }
    