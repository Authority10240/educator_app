import 'package:flutter/material.dart';
import 'NotificationHome.dart';
import 'MessageHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/BackEnd/Strings.dart';

class EntacomHome extends StatefulWidget {
  @override
  _EntacomHomeState createState() => _EntacomHomeState();
}

class _EntacomHomeState extends State<EntacomHome> with SingleTickerProviderStateMixin {
  // TODO: implement initstate
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTeacherInformation();
    _tabController = new TabController(vsync: this,initialIndex: 0, length: 2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,centerTitle: true,title: Text('Entacom Teacher', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      elevation: 7.0 ,
      bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.blueAccent,
          tabs: <Widget>[
            new Tab(icon:  Icon(Icons.add_comment),text: "Messaging",),
            new Tab(icon: Icon(Icons.library_books),text: "Announcements")
          ]),
      ),
      body: new TabBarView(
        controller: _tabController ,
        children: <Widget>[
          new MessageHome(),
          new NotificationHome()
        ]

      )

    );
  }

  getTeacherInformation() async{
    SharedPreferences teacherInformation = await SharedPreferences.getInstance();
    Strings.TEACHER_NAME = teacherInformation.get('TEACHER_NAME');
    Strings.TEACHER_SURNAME = teacherInformation.get('TEACHER_SURNAME');
    Strings.TEACHER_TITLE = teacherInformation.get('TEACHER_TITLE');
    Strings.REGISTER_CLASS = teacherInformation.get('REGISTER_CLASS');
    Strings.EMPLOYEE_NUMBER = teacherInformation.get('TEACHER_ID');

    /*

        teacherInformation.setString('TEACHER_ID', employeeNumber);
    teacherInformation.setString('TEACHER_NAME', teacherName );
    teacherInformation.setString('TEACHER_SURNAME', surname);
    teacherInformation.setString('REGISTER_CLASS',RegisterClass );
    teacherInformation.setString('TEACHER_TITLE', title);
    teacherInformation.setBool("REGISTERED", true);

     */
  }
}
