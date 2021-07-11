import 'package:flutter/material.dart';
import 'package:educator_app/SQL_Models/year_Model.dart';
import 'CreateQR.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import "package:sqflite/sqflite.dart";
import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'SendMessage.dart';
import 'StudentList.dart';
import 'BroadcastMessaging.dart';
import 'package:educator_app/SQL_Models/TeacherInformation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'QRView.dart';
import 'Entacom_home.dart';


class SubjectList extends StatefulWidget {
  @override
  YearInformation yearInformation;

  SubjectList(this.yearInformation);


  _SubjectListState createState() => _SubjectListState(yearInformation);
}

class _SubjectListState extends State<SubjectList> {
  YearInformation yearInformation;
  DBHelper dbHelper = DBHelper();
  List<ContactInformation> contactList;
  List<ContactInformation> broadcaseSubjectList = new List();
  _SubjectListState(this.yearInformation);
  String fabText= 'Add QR';
  Icon fabIcon = Icon(Icons.add_box);
  TeacherInformation ti;

  @override
  Widget build(BuildContext context) {
getTeacherInformation();
    if(contactList == null){
      contactList = List<ContactInformation>();
      updateListView(yearInformation);
    }
    if(broadcaseSubjectList.length ==0) {
      fabText= 'Add QR';
      fabIcon = Icon(Icons.add_box);
    }else{
      fabText = 'Send';
      fabIcon = Icon(Icons.message);

    }

    return Scaffold(
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: (){
        if(broadcaseSubjectList.length ==0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQR()));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => BroadcastMessage(broadcaseSubjectList )));
        }
      },
        label:Text(fabText),
        icon: fabIcon ,backgroundColor: Colors.blueAccent,),
      appBar: AppBar(backgroundColor: Colors.blueAccent,
      centerTitle: true,
      leading: FlatButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntacomHome()));
      }, child: Icon(Icons.arrow_back, color: Colors.white,)),
      title: Text("Subjects"),),
      body: WillPopScope(child: ListView.builder(itemCount: contactList.length,itemBuilder:(context,i)=>
      new Column(
        children: <Widget>[
          Divider(
            height: 10,

          ),
          Slidable(closeOnScroll: false,child:  ListTile(

            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Text(contactList[i].SUBJECT_ID[0]) ,),
            subtitle: Text("Grade:" + contactList[i].COURSE_ID+ ' Set: ' + contactList[i].SET_ID) ,
            title:Text(contactList[i].SUBJECT_ID) ,
            onLongPress: (){
              OptionPanel(context, dbHelper, "Select An Option", "", i, contactList[i], yearInformation);
            },
            onTap: (){
              broadcaseSubjectList = new List();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SendMessage(contactList[i],yearInformation)));


            },
          ), actionPane: SlidableBehindActionPane(),
            actionExtentRatio: 0.25,
            actions: <Widget>[

              IconSlideAction(
                caption: contactList[i].optionSelect,
                color: contactList[i].itemColor,
                icon: Icons.add,
                onTap: (){

                  setState(() {
                    if(contactList[i].itemColor == Colors.white){
                      broadcaseSubjectList.remove(contactList[i]);
                      contactList[i].itemColor = Colors.green;
                      contactList[i].optionSelect='Select';
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(contactList[i].SUBJECT_ID +' has been removed from broadcast List')));

                    }else{
                      Scaffold.of(context).showSnackBar(new SnackBar(content: Text(contactList[i].SUBJECT_ID +' has been added to broadcast List')));
                      broadcaseSubjectList.add(contactList[i]);
                      contactList[i].itemColor = Colors.white;
                      contactList[i].optionSelect='Remove';
                    }
                  });
                },
              ),

            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'List',
                color: Colors.purple,
                icon: Icons.view_list,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList(new DateTime.now().year.toString() , contactList[i])));
                },
              )
            ],)

        ],
      ),), onWillPop: (){
        return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntacomHome()));
      })

    );
  }



  updateListView(YearInformation year){
    final Future<Database> dbFuture = dbHelper.initDB();
    dbFuture.then((database){

      Future<List<ContactInformation>> contactListFuture = dbHelper.getContactList(year);
      contactListFuture.then((contactList){
        setState(() {
          this.contactList = contactList;
        });
      });
    });

  }

  OptionPanel(BuildContext context, DBHelper db_helper, String title,
      String description,
      int pos, ContactInformation contactInformation , YearInformation yearInformation) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                 FlatButton(onPressed: (){
                   Navigator.pop(context);
                   Navigator.push(context, MaterialPageRoute(builder: (context) => QRView(contactInformation.SUBJECT_ID, contactInformation.COURSE_ID, ti, yearInformation.SCHOLAR_YEAR ,contactInformation.SET_ID)));
                 },
                     child: Text('View QR Code'),
                   hoverColor: Colors.white,
                   color: Colors.blueAccent,


                 ),
                  FlatButton(onPressed: (){
                    db_helper.deleteContact(contactInformation, yearInformation);
                    updateListView(yearInformation);
                    Navigator.pop(context);
                  },
                    child: Text('Delete Subject'),
                    hoverColor: Colors.white,
                    color: Colors.red,
                  ),

                ],
              ),
            ),

          );
        }
    );
  }
  Confirm(BuildContext context, DBHelper db_helper, String title,
      String description , ContactInformation contactInformation) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(

            title: Text(title,),
            elevation: 7.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),

                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes',style: TextStyle(color: Colors.black)),
                onPressed: () {
                  db_helper.deleteContact(contactInformation, yearInformation);
                  updateListView(yearInformation);
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('No', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                },

              ),

            ],
          );
        }
    );
  }
  Future<TeacherInformation> getEducatorInformation() async {
    SharedPreferences teacherInformation = await SharedPreferences
        .getInstance();
    TeacherInformation teacherInfo = new TeacherInformation.blank();
    teacherInfo.teacherID = teacherInformation.getString('TEACHER_ID');
    teacherInfo.teacherName = teacherInformation.getString('TEACHER_NAME');
    teacherInfo.teacherSurname = teacherInformation.getString('TEACHER_SURNAME');
    teacherInfo.RegisterClass = teacherInformation.getString('REGISTER_CLASS');
    teacherInfo.teacherTitle = teacherInformation.getString('TEACHER_TITLE');

    return teacherInfo;
  }

  getTeacherInformation() async{
    ti = await getEducatorInformation();
  }
}
