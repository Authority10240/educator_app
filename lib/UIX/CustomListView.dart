import 'package:flutter/material.dart';

/*
class StudentDataItem extends StatelessWidget{
  Future<List <ChildInformaiton>>studentList ;
  DBHelper dbHelper = DBHelper();
  int count = 0;
  
  StudentDataItem(this.studentList);


   @override
  Widget build(BuildContext context) {
     // TODO: implement build
     if (studentList == null) {
       studentList = Future<List<ChildInformaiton>> ();
     }

     return ListView.builder(
         itemCount: count,
         itemBuilder: (BuildContext context, int position) {
           return Card(
             color: Colors.white,
             elevation: 7.0,
             child: ListTile(
                 leading: CircleAvatar(
                   backgroundColor: Colors.cyan,
                   child: Icon(Icons.email),

                 ),

                 title: Text(studentList[position].STUDENT_NAME + ' '
                     + studentList[position].STUDENT_SURNAME),
                 subtitle: Text('Student Number ' +
                     studentList[position].STUDENT_NUMBER),
                 trailing: GestureDetector(
                   child: Icon(Icons.delete, color: Colors.cyan,),
                   onTap: () {
                     // what happens when the user taps the icon
                   },
                 )
             ),
           );
         });
   }

  Color getPriorityColor(int priority){
    switch (priority){
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.cyan;
        break;
      default: return Colors.cyan;

    }


  }

  void _delete (BuildContext context ,ChildInformaiton) async{
    //Place code to remove student
  }

}
*/