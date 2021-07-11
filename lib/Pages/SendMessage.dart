import 'package:educator_app/Pages/Subject_list.dart';
import 'package:flutter/material.dart';
import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:educator_app/SQL_Models/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:educator_app/BackEnd/Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/SQL_Models/message_model.dart';
import 'package:educator_app/SQL_Models/child_model.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:educator_app/SQL_Models/year_Model.dart';
import 'package:educator_app/Models/Principal_message.dart';


class SendMessage extends StatefulWidget {
  @override
  List<ContactInformation> broadcastList = new List() ;
  ContactInformation contactInformation = ContactInformation.blank();
  List<ChildInformaiton> childList = new List();
  YearInformation yearInformation ;
  int messageType = -1;

  

  SendMessage(this.contactInformation, this.yearInformation);



  _SendMessageState createState() => _SendMessageState(contactInformation, yearInformation);
}

class _SendMessageState extends State<SendMessage> {
  List<ContactInformation> broadcastList ;
  List<ChildInformaiton> childList;
  ContactInformation contactInformation;
  YearInformation yearInformation ;
  int messageType;
  String value='';
  TextEditingController controller = new TextEditingController();

  _SendMessageState(this.contactInformation,this.yearInformation);


  List<messageInformation> messageList;
  DBHelper dbHelper = new DBHelper();
  DatabaseReference databaseReference ;
  String message ='' ,teacherId = '';
  
  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.8;
    if (messageList == null){
      messageList = new List();

      updateListView();
    }

    getTeacherInformation();
    return Scaffold(appBar:
    AppBar(
      title: Text('Message Board'),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      leading: FlatButton(onPressed: (){
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubjectList(yearInformation)));
      }, child: Icon(Icons.arrow_back, color: Colors.white,))

    ),
      body:WillPopScope(child: ListView(children:<Widget>[ Column(
        children: <Widget>[
          Container(height: MediaQuery.of(context).size.height -146,

            child: ListView.builder(itemCount: messageList.length,itemBuilder:(context , i)=>
                Card(
                  color: getMessageColor(messageList[i]),

                  child:

                  ListTile(
                    title: Text(messageList[i].MESSAGE_CONTENT),
                    subtitle: Text(messageList[i].ARRIVAL_DATE),

                  ),
                ),
            ),
          ),
          Divider(height: 10,),
          ListTile(trailing:
          GestureDetector(onTap: () async{
            if(message.isEmpty || message == null){


            }else{

              sendMessage(message);
              setState(() {
                controller.text = '';
              });

            }
          },
              child:Icon(Icons.send)),title: Container(width: c_width,padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              textAlign: TextAlign.left,
              maxLines: 5,
              onChanged: (typed) {
                message = typed;
              },




            ),
          ))],
      ),
      ]), onWillPop: (){
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubjectList(yearInformation)));
      }));}

  updateListView(){

    final Future<Database> dbFuture = dbHelper.initDB();
    dbFuture.then((database){

      Future<List<messageInformation>> messageListFuture = dbHelper.getMessageList(contactInformation.SUBJECT_ID, yearInformation.SCHOLAR_YEAR, contactInformation.SET_ID );
      messageListFuture.then((contactList){
        setState(() {
          this.messageList = contactList;
        });
      });
    });

  }
 /* sendStudentsMessage(String message ){

    messageInformation firebaseMessage = new messageInformation(
        new DateTime.now().toString() + contactInformation.SUBJECT_ID,
        teacherId,
        message,
        '',
        new DateTime.now().toString() + contactInformation.SUBJECT_ID,
        contactInformation.SUBJECT_ID,
        '',
        '',
        'Y',
        '0');

    for (int i = 0 ; i < childList.length ; i++){

      try {
        databaseReference =
            FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
                .child('SMESSAGES').child(teacherId)
                .child(new DateTime.now().year.toString()).child(
                contactInformation.COURSE_ID)
                .child(contactInformation.SUBJECT_ID).child(childList[i].STUDENT_NUMBER);
        databaseReference.set(firebaseMessage.toMap());
      }catch(e){
        Informattion(context, 'Error', e.toString());
      }

    }

  }*/

 Future<int>getMessageCount()async{
   return await dbHelper.getMessageCount();
 }
  sendMessage(String message) async{

    messageInformation firebaseMessage ;
    try {

      firebaseMessage = new messageInformation(
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
          '0',contactInformation.SET_ID);
      databaseReference =
          FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
              .child('SMESSAGES').child(teacherId)
              .child(new DateTime.now().year.toString()).child(
              contactInformation.COURSE_ID)
              .child(contactInformation.SUBJECT_ID)
              .child(contactInformation.SET_ID)
              .child('GROUPED')
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


      try{
        dbHelper.insertNewMessage(firebaseMessage);
        updateListView();
      }catch(ex){
        Informattion(context, 'Error', ex);

      }
        updateListView();
    }catch(e){
    Informattion(context, 'Error', e.toString());
    }


  }
/*
  
  sendBroadcastMessage(String Message) async{

    for(int i = 0; i < broadcastList.length ; i++) {
      Messaage firebaseMessage = new FirebaseMessage(
          new DateTime.now().toString() + broadcastList[i].SUBJECT_ID,
          teacherId,
          Message,
          '',
          new DateTime.now().toString() + broadcastList[i].SUBJECT_ID,
          broadcastList[i].SUBJECT_ID,
          '',
          '',
          'Y',
          '0');
      try {
        databaseReference =
            FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
                .child('SMESSAGES').child(teacherId)
                .child(new DateTime.now().year.toString()).child(
                broadcastList[i].COURSE_ID)
                .child(broadcastList[i].SUBJECT_ID);
        databaseReference.set();
      }catch(e){
        Informattion(context, 'Error', e.toString());
      }
    }
  }
*/
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

  Color getMessageColor(messageInformation current){
    Color color;
    if(current.MESSAGE_PRIORITY =='0'){
      color = Colors.white70;
    }
    else if(current.MESSAGE_PRIORITY == '1'){
      color = Colors.purple;
    }else if(current.MESSAGE_PRIORITY == '2'){
      color = Colors.green;
    }

    return color;
  }
}
