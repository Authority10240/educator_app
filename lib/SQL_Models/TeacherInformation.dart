import 'package:educator_app/BackEnd/Strings.dart';
class TeacherInformation{
  String teacherID , teacherName, teacherSurname, RegisterClass, teacherTitle;

  TeacherInformation(this.teacherID, this.teacherName, this.teacherSurname,
      this.RegisterClass, this.teacherTitle);

  TeacherInformation.blank();

  Map<String , dynamic> toMap (){
    var map = Map<String, dynamic>();
    map['sTitle'] = Strings.TEACHER_TITLE;
    map['sName'] = Strings.TEACHER_NAME;
    map['sSurname'] = Strings.TEACHER_SURNAME;
    map['sEmployeeNumber'] =  Strings.EMPLOYEE_NUMBER;
    map['sRegisterClass'] = Strings.REGISTER_CLASS;


    return map;

  }
}