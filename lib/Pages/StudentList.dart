import 'package:flutter/material.dart';
import 'package:educator_app/SQL_Models/year_Model.dart';
import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:educator_app/SQL_Models/child_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:educator_app/BackEnd/Strings.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'SendMessage.dart';
import 'Messaging.dart';


class StudentList extends StatefulWidget {
  @override
  String year = '';
  String yearInformation;
  ContactInformation contactInformation;
  List<ChildInformaiton> childList;
  StudentList(this.year, this.contactInformation);

  _StudentListState createState() => _StudentListState(yearInformation,contactInformation,year);
}

class _StudentListState extends State<StudentList> {
  @override
  String yearInformation;
  ContactInformation contactInformation;
  String year, studentNum = '';
  DBHelper dbHelper = new DBHelper();
  _StudentListState(this.yearInformation, this.contactInformation, this.year);

  List<ChildInformaiton> childList;
  DatabaseReference databaseReference;
  List<ChildInformaiton> childBroadcastList = new List();
  Widget build(BuildContext context) {

    if(childList == null){
      childList = new List();
      updateListView();
    }
    getSubjectChildren();
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple,centerTitle: true, title: Text(contactInformation.SUBJECT_ID + ' Student Numbers'),
        ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Message'),
          icon: Icon(Icons.message)
          ,backgroundColor: Colors.purple,onPressed: (){
        if(childBroadcastList.length > 0){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Messaging.child(childBroadcastList, contactInformation, year)));
        }else{
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('No Students Selected.')));
        }
      }),
      body: ListView.builder(itemCount: childList.length,itemBuilder: (context,i)
      => new Column(
        children: <Widget>[
          Divider(height: 10,),
          Slidable(child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple,
              child: Text(childList[i].getSTUDENT_NAME()[0] +' '+ childList[i].getSTUDENT_SURNAAME()[0]),
            ),
            title:Text(childList[i].getSTUDENT_NAME() +' '+ childList[i].getSTUDENT_SURNAAME()) ,
            subtitle: Text('Student Number: '+childList[i].getSTUDENT_NUMBER()),

          ), actionPane: SlidableBehindActionPane(),
            closeOnScroll: false,
          actions: <Widget>[
            IconSlideAction(
              caption: childList[i].itemString,
              color: childList[i].itemColor,
              icon: Icons.add,
              onTap: (){

                setState(() {
                if (childList[i].itemColor == Colors.blueAccent){
                  childList[i].itemColor = Colors.white;
                  childList[i].itemString = 'Remove';
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(childList[i].STUDENT_NAME +' '+ childList[i].STUDENT_SURNAAME + '  has been added to broadcast List')));
                  childBroadcastList.add(childList[i]);
                }else{

                  childList[i].itemColor = Colors.blueAccent;
                  childList[i].itemString = 'Add';
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text(childList[i].STUDENT_NAME +' '+ childList[i].STUDENT_SURNAAME + '  has been removed to broadcast List')));
                  childBroadcastList.remove(childList[i]);

                }
                });
              },
            ),
          ],),
        ],
      )),

    );
  }

  updateListView() async{

    databaseReference = FirebaseDatabase.instance.reference()
        .child(Strings.SCHOOL_NAME).child('REGISTERED_STUDENTS')
        .child(await getTeacherInformation()).child(year).child(contactInformation.COURSE_ID)
        .child(contactInformation.SUBJECT_ID.trim()).child(contactInformation.SET_ID.trim());
    databaseReference.onChildAdded.listen((child){
      var val = child.snapshot.value;
      if(childList.contains(ChildInformaiton( val['STUDENT_NUMBER'].toString(), val['STUDENT_NAME']
          , val['STUDENT_SURNAME'], val['SUBJECT_ID']))){

      }else{

      setState(() {
      });
      childList.add(new ChildInformaiton( val['STUDENT_NUMBER'].toString(), val['STUDENT_NAME']
          , val['STUDENT_SURNAME'], val['SUBJECT_ID']));
    }}
    );


  }

  Future<String> getTeacherInformation()async{
    SharedPreferences teacher = await SharedPreferences.getInstance();
    return teacher.getString('TEACHER_ID');
  }

  getSubjectChildren() async{

  }
}
