class Strings{

  static String SCHOOL_NAME = '';//'Capricorn High School';
  static String EMPLOYEE_NUMBER = '';
  static String TEACHER_NAME = '';
  static String TEACHER_SURNAME='';
  static String REGISTER_CLASS = '';
  static String TEACHER_TITLE = '';
  static String SCHOOL_LOGO = '';

  static insertTeacherInformation(String EMPLOYEENUMBER , String TEACHERNAME
      , String TEACHERSURNAME , String REGISTERCLASS, String TEACHERTITLE ){
    EMPLOYEE_NUMBER = EMPLOYEENUMBER;
    TEACHER_NAME = TEACHERNAME;
    TEACHER_SURNAME = TEACHERSURNAME;
    REGISTER_CLASS = REGISTERCLASS;
    TEACHER_TITLE = TEACHERTITLE;
  }

  static insertSchool(String schoolName , String schoolLogo){
    SCHOOL_NAME = schoolName;
    SCHOOL_LOGO = schoolLogo;
  }


/*
    teacherInformation.setString('TEACHER_ID', employeeNumber);
    teacherInformation.setString('TEACHER_NAME', teacherName );
    teacherInformation.setString('TEACHER_SURNAME', surname);
    teacherInformation.setString('REGISTER_CLASS',RegisterClass );
    teacherInformation.setString('TEACHER_TITLE', title);
    teacherInformation.setBool("REGISTERED", true);

 */

}