import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/BackEnd/Strings.dart';
import 'package:educator_app/Models/teacher_Model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:educator_app/Pages/Entacom_home.dart';

class TeacherAccesss extends StatefulWidget {
  @override
  _TeacherAccesssState createState() => _TeacherAccesssState();
}

class _TeacherAccesssState extends State<TeacherAccesss> {
  String Password , employeeNumber ,teacherName,surname, RegisterClass, title , sActive;
  List<Teacher_model> teachers = new  List<Teacher_model>();
  DatabaseReference reference;
  @override
  Widget build(BuildContext context) {
    loadTeachers();
    return Scaffold(

      appBar: AppBar(
centerTitle: true,
        title: Text('Teacher Login',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent ,

      ),
      body: ListView(children: <Widget>[
      Column(
      children: <Widget>[

        SizedBox(height: 25,),
        Container(
         child: Icon(Icons.lock,color: Colors.blueAccent,size: 250,),
          //child: Image.asset("assets/logo.png",width: 250,height: 250,),
        ),
        SizedBox(height: 20,),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "Employee Number",
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) => employeeNumber = value,
              ),
          SizedBox(height: 10,),
          TextField(
          decoration: InputDecoration(
            hintText: "Password",

            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
            onChanged: (value) => Password = value,
          ),

              SizedBox(height: 10,),
              Container(child: Center(
                child: Text("Contact admin if you have not recieved login credentials",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),),
              ),width: MediaQuery.of(context).size.width - 20,),

              SizedBox(height: 20,),
              Container(
                child: OutlineButton(
                  onPressed: () async{
                    for(int i = 0 ; i < teachers.length ; i++){
                      if(Password.trim() == teachers[i].sPassword) {
                        if (employeeNumber.trim() == teachers[i].sEmployeeNumber) {
                          employeeNumber = teachers[i].sEmployeeNumber;
                          teacherName = teachers[i].sName;
                          sActive = teachers[i].sActive;
                          RegisterClass = teachers[i].sRegisterClass;
                          surname = teachers[i].sSurname;
                          Password = teachers[i].sPassword;
                          title = teachers[i].sTitle;

                          saveTeacherInformation();
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => EntacomHome()));
                          break;
                        }
                      }
                    }
                  },
                  color: Colors.black,
                  textColor: Colors.black,
                  child: Text("Login") ,),
              ),

        ],
      ),
    )
    ],
    ),
    ],),
    );
  }

  void saveTeacherInformation  () async{
    SharedPreferences teacherInformation = await SharedPreferences.getInstance();
    teacherInformation.setString('TEACHER_ID', employeeNumber);
    teacherInformation.setString('TEACHER_NAME', teacherName );
    teacherInformation.setString('TEACHER_SURNAME', surname);
    teacherInformation.setString('REGISTER_CLASS',RegisterClass );
    teacherInformation.setString('TEACHER_TITLE', title);
    teacherInformation.setBool("REGISTERED", true);

  }
  
  void loadTeachers(){

    reference = FirebaseDatabase.instance.reference().child(Strings.SCHOOL_NAME)
        .child('TEACHER_ACCESS');
    reference.onChildAdded.listen((retrieved){
      var val = retrieved.snapshot.value;
        Teacher_model teacher = new Teacher_model.blank();
        teacher.sActive = val['sActive'];
        teacher.sAddress = val['sAddress'];
        teacher.sCellNumber = val['sCellNumber'];
        teacher.sClassNumber = val['sClassNumber'];
        teacher.sCountry = val['sCountry'];
        teacher.sEmailAddress = val['sEmailAddress'];
        teacher.sEmployeeNumber = val['sEmployeeNumber'];
        teacher.sIDNumber = val['sIDNumber'];
        teacher.sName = val['sName'];
        teacher.sPassword = val['sPassword'];
        teacher.sProvince = val['sProvince'];
        teacher.sRegisterClass = val['sRegisterClass'];
        teacher.sRegistrationDate = val['sRegistrationDate'];
        teacher.sSurname = val['sSurname'];
        teacher.sTitle = val['sTitle'];
        teacher.sZipCode = val['sZipCode'];
      if(!teachers.contains(teacher)) {
        teachers.add(teacher);
      }

    });
  }


}
