import 'package:educator_app/Models/Principal_message.dart';
import 'package:flutter/material.dart';
import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:educator_app/SQL_Models/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:educator_app/BackEnd/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/SQL_Models/message_model.dart';
import 'package:educator_app/SQL_Models/child_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

class BroadcastMessage extends StatefulWidget {
  @override

  List<ContactInformation> broadcastList = new List() ;


  BroadcastMessage(this.broadcastList);


  _BroadcastMessageState createState() => _BroadcastMessageState(broadcastList);
}

class _BroadcastMessageState extends State<BroadcastMessage> {
  @override

  List<ContactInformation> broadcastList = new List() ;
  String optionValue = 'Remove';
  _BroadcastMessageState(this.broadcastList);
  List<messageInformation> messageList;
  String message ='' ,teacherId = '';
  DBHelper dbHelper = new DBHelper();
  DatabaseReference databaseReference ;

  TextEditingController controller = new TextEditingController();

  Widget build(BuildContext context) {

    if (broadcastList == null){
      broadcastList = new List();

      updateListView();
    }
    getTeacherInformation();
        return Scaffold(appBar:
    AppBar(
      title: Text('Message Board'),
      centerTitle: true,
      backgroundColor: Colors.green,
    ),

          body:ListView(children:<Widget>[ Column(
            children: <Widget>[
              Container(height: MediaQuery.of(context).size.height -146,

                child: ListView.builder(itemCount: broadcastList.length,itemBuilder:(context , i)=>
                  Slidable( actionPane: SlidableBehindActionPane()  , closeOnScroll: false,
                  child:
                      ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.green,child: Text(broadcastList[i].SUBJECT_ID[0]),),
                        title: Text(broadcastList[i].SUBJECT_ID),
                        subtitle: Text(broadcastList[i].COURSE_ID),


                    ),
                  actions: <Widget>[

                  ],)
                ),
              ),
              Divider(height: 10,),
              ListTile(trailing: GestureDetector(onTap: () async{
                if(message.isEmpty || message == null){


                }else{

                  sendBroadcastMessage(message);

                }
              },
                  child:Icon(Icons.send)),
                  title: TextField(
                  onChanged: (typed) {
                    message = typed;

                  }


              ,controller: controller,))],
          ),
          ]),);}

  updateListView(){

  }

  Future<String> getTeacherInformation()async{
    SharedPreferences teacher = await SharedPreferences.getInstance();
    teacherId = teacher.getString('TEACHER_ID');
  }
  Future<int>getMessageCount()async{
    return await dbHelper.getMessageCount();
  }


  sendBroadcastMessage(String Message) async {
    messageInformation firebaseMessage;
    for (int i = 0; i < broadcastList.length; i++) {
      firebaseMessage = new messageInformation(
          await getMessageCount() + 1,
          new DateTime.now().toString(),
          teacherId,
          Message,
          '',
          new DateTime.now().toString() + broadcastList[i].SUBJECT_ID,
          broadcastList[i].SUBJECT_ID,
          '',
          '',
          'Y',
          DateTime
              .now()
              .year
              .toString(),
          '2', broadcastList[i].SET_ID);
      try {
        databaseReference =
            FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
                .child('SMESSAGES').child(teacherId)
                .child(new DateTime.now().year.toString()).child(
                broadcastList[i].COURSE_ID)
                .child(broadcastList[i].SUBJECT_ID).child(broadcastList[i].SET_ID);
        databaseReference.set(firebaseMessage.toMap());
        setState(() {
          controller.text = '';
        });
        //Send infomormation to principal App
        databaseReference = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME).child("PRINCIPAL_APP")
            .child(DateTime.now().year.toString()).child(DateTime.now().month.toString())
            .child(DateTime.now().day.toString()).child(new DateTime.now().year.toString() +
            new DateTime.now().month.toString() +
            new DateTime.now().day.toString() +
            new DateTime.now().hour.toString()+
            new DateTime.now().minute.toString() +
            new DateTime.now().second.toString() +' '+
            broadcastList[i].SUBJECT_ID);

        databaseReference.child("MESSAGE").set(firebaseMessage.toMap());
        databaseReference.child("CONTACT").set(broadcastList[i].toMap());
      } catch (e) {
        Informattion(context, 'Error', e.toString());
      }

    try {
      dbHelper.insertNewMessage(firebaseMessage);
      updateListView();
    } catch (ex) {
      Informattion(context, 'Error', ex);
    }
  }
  }

  Informattion(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }
}
