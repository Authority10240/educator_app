import 'package:flutter/material.dart';
import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:educator_app/SQL_Models/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:educator_app/BackEnd/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/SQL_Models/firebase_message.dart';
import 'package:educator_app/SQL_Models/child_model.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:educator_app/Models/Principal_message.dart';
import 'package:educator_app/SQL_Models/year_Model.dart';
    class Messaging extends StatefulWidget {
      @override

      ContactInformation contactInformation = ContactInformation.blank();
      List<ChildInformaiton> childList = new List();
      int messageType = -1;
      String yearInformation;

      Messaging.child(this.childList,this.contactInformation, this.yearInformation);


        _MessagingState createState() => _MessagingState.child(childList,contactInformation, yearInformation);


    }

    class _MessagingState extends State<Messaging> {
      @override
      TextEditingController controller = new TextEditingController();
      DBHelper dbHelper = new DBHelper();
      List<ChildInformaiton> childList;
      ContactInformation contactInformation;
      String yearInformation;

      _MessagingState.child(this.childList, this.contactInformation, this.yearInformation);

      int messageType;

      List<messageInformation> messageList;
      DatabaseReference databaseReference ;
      String message ='' ,teacherId = '';




      Widget build(BuildContext context) {
        getTeacherInformation();
        if (messageList == null){
          messageList = new List();

          updateListView();
        }
        return Scaffold(appBar:
        AppBar(
          title: Text('Student Messaging'),
          centerTitle: true,
          backgroundColor: Colors.purple,

        ),
          body:ListView(children:<Widget>[ Column(
            children: <Widget>[
              Container(height: MediaQuery.of(context).size.height -146,
                child: ListView.builder(
                  itemCount: childList.length,itemBuilder:(context , i)=>
                    ListTile(
                      leading: CircleAvatar(backgroundColor: Colors.purple, child: Text(childList[i].STUDENT_NAME[0]+ childList[i].STUDENT_SURNAAME[0]),),
                      title: Text(childList[i].STUDENT_NAME + ' ' + childList[i].STUDENT_SURNAAME),
                      subtitle: Text(childList[i].STUDENT_NUMBER),
                    ),),
              ),
              Divider(height: 10,),
              ListTile(trailing: GestureDetector(onTap: () async{
                if(message.isEmpty || message == null){

                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Empty Message Body')));


                }else{

                  Confirm(context, 'Sending Message', 'Message will be sent to ' + childList.length.toString() + ' Individual Parent(s). \nContinue?' );
                }
              },
                  child:Icon(Icons.send)),title:
              TextField(
                onChanged: (typed) {
                  message = typed;
                },
                controller: controller,
              ))
            ],
          ),
          ]),);}

      Confirm(BuildContext context, String title,
          String description
          ) {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title,),

                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text(description),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel', style: TextStyle(color: Colors.black)),
                    onPressed: () {

                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Confirm', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      sendStudentsMessage(message);
                      setState(() {
                        controller.text='';
                      });
                      Navigator.pop(context);

                    },
                  )
                ],
              );
            }
        );
      }

      updateListView(){

        final Future<Database> dbFuture = dbHelper.initDB();
        dbFuture.then((database){

          Future<List<messageInformation>> messageListFuture = dbHelper.getMessageList(contactInformation.SUBJECT_ID, yearInformation , contactInformation.SET_ID);
          messageListFuture.then((contactList){
            setState(() {
              this.messageList = contactList;
            });
          });
        });

      }
      sendStudentsMessage(String message )async{
        PrincipalMessage princMessage = PrincipalMessage.blank();
        messageInformation firebaseMessage = new messageInformation(
          await getMessageCount() + 1,
            new DateTime.now().toString() ,
            teacherId,
            message,
            '',
            new DateTime.now().toString() + contactInformation.SUBJECT_ID,
            contactInformation.SUBJECT_ID,
            '',
            '',
            'Y',
            DateTime.now().year.toString(),
            '1',contactInformation.SET_ID);

        for (int i = 0 ; i < childList.length ; i++){
            //writes to firebase
          try {
            databaseReference =
                FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
                    .child('SMESSAGES').child(teacherId)
                    .child(new DateTime.now().year.toString()).child(
                    contactInformation.COURSE_ID)
                    .child(contactInformation.SUBJECT_ID).child(contactInformation.SET_ID)
                    .child(childList[i].STUDENT_NUMBER)
                    .child(new DateTime.now().year.toString() +
                    new DateTime.now().month.toString() +
                    new DateTime.now().day.toString() +
                    new DateTime.now().hour.toString()+
                    new DateTime.now().minute.toString() +
                    new DateTime.now().second.toString() +' '+
                    contactInformation.SUBJECT_ID);
            databaseReference.set(firebaseMessage.toMap());

            databaseReference = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME).child("PRINCIPAL_APP")
                .child(DateTime.now().year.toString()).child(DateTime.now().month.toString())
                .child(DateTime.now().day.toString()).child(new DateTime.now().year.toString() +
                new DateTime.now().month.toString() +
                new DateTime.now().day.toString() +
                new DateTime.now().hour.toString()+
                new DateTime.now().minute.toString() +
                new DateTime.now().second.toString() +' '+
                contactInformation.SUBJECT_ID);

            databaseReference.child("MESSAGE").set(firebaseMessage.toMap());
            databaseReference.child("CONTACT").set(contactInformation.toMap());
          }catch(e){
            Informattion(context, 'Error', e.toString());
          }

          //writes to SQL database

          try{
            dbHelper.insertNewMessage(firebaseMessage);
            updateListView();
          }catch(ex){
            Informattion(context, 'Error', ex);

          }


        }

      }
      Future<int>getMessageCount()async{
        return await dbHelper.getMessageCount();
      }



      sendMessage(String message)async{
        try {

          messageInformation firebaseMessage = new messageInformation(
              await getMessageCount() + 1,
              new DateTime.now().toString(),
              teacherId,
              message,
              '',
              new DateTime.now().toString() + contactInformation.SUBJECT_ID,
              contactInformation.SUBJECT_ID,
              '',
              '',
              'Y',
              DateTime.now().year.toString(),
              '1',contactInformation.SET_ID);
          databaseReference =
              FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
                  .child('SMESSAGES').child(teacherId)
                  .child(new DateTime.now().year.toString()).child(
                  contactInformation.COURSE_ID)
                  .child(contactInformation.SUBJECT_ID);
          databaseReference.set(firebaseMessage);

          databaseReference = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME).child("PRINCIPAL_APP")
              .child(DateTime.now().year.toString()).child(DateTime.now().month.toString())
              .child(DateTime.now().day.toString()).child(new DateTime.now().year.toString() +
              new DateTime.now().month.toString() +
              new DateTime.now().day.toString() +
              new DateTime.now().hour.toString()+
              new DateTime.now().minute.toString() +
              new DateTime.now().second.toString() +' '+
              contactInformation.SUBJECT_ID);

          databaseReference.child("MESSAGE").set(firebaseMessage.toMap());
          databaseReference.child("CONTACT").set(contactInformation.toMap());


        }catch(e){
          Informattion(context, 'Error', e.toString());
        }

      }




      Future<String> getTeacherInformation()async{
        SharedPreferences teacher = await SharedPreferences.getInstance();
        teacherId = teacher.getString('TEACHER_ID');
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
