import 'package:educator_app/Pages/Entacom_home.dart';
import 'package:flutter/material.dart';
import 'package:educator_app/BackEnd/Strings.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/SQL_Models/TeacherInformation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'QRView.dart';
import 'package:educator_app/Models/Set_Model.dart';



class CreateQR extends StatefulWidget {
  @override
  _CreateQRState createState() => _CreateQRState();
}

class _CreateQRState extends State<CreateQR> {
  String grade = '(Grade Selector)',
      Subject = '(Subject Selector)', set = '(Set Selector)';

  Image image = Image.asset('assets/logo.png');
  DBHelper dbHelper = new DBHelper();


  //QRCODE CODE
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey _globalKey = new GlobalKey();
  String _dataString = "Create QR";
  String _inputErrorText;
  final TextEditingController _textController = TextEditingController();
  TeacherInformation ti;

  @override
  Widget build(BuildContext context) {
    getTeacherInformation();
    return Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text("Create QR Code"),
          backgroundColor: Colors.blueAccent,
        leading: FlatButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntacomHome()));
        }, child: Icon(Icons.arrow_back,color: Colors.white,)),),
        

        body: WillPopScope(child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Center(
                child: Text("Select Subject Details below to create subject.",
                  style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold,),),
              ),
              SizedBox(height: 20,),
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 20,
                child: Column(
                  children: <Widget>[
                    Center(
                      child:
                      Text('Select Subject*',style:TextStyle(color: Colors.black, fontSize: 15)
                      ) ,),
                    new Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),child: DropdownButton<String>(value:Subject,hint: Text('Subject Selector'),items: <String>
                    ['(Subject Selector)','Accounting','Agricultural Practices','Agricultural Science',
                      'Agricultural Technology','Arts And Culture','Business Studies','Civil Technology','Computer Application Technology'
                      ,'Consumer Studies','Design','Dramatic Arts','Economics','Economic Management and Science','Electrical Technology'
                      ,'Engineering Graphics and Designs', 'Geography' , 'History', 'Hospitality Studies',
                      'Information Technology','Life Orientation','Mathematics','Mechnical Technology','Music',
                      'Natural Science','Physical Science','Religion Studeis','Social Science','Technology','Tourism','Visual Arts',
                      'Afrikaans', 'English' , 'Isi Ndebele' , 'Northern Sotho' , 'Southern Sotho',
                      'Isi Swati','Xitsonga','Se Tswana','Tshivenda' , 'Isi Xhosa' , 'Isi Zulu'].map((String value){
                      return new DropdownMenuItem(child: new Text(value,style:
                      TextStyle(color: Colors.black),),value: value,);
                    }).toList(), onChanged:(value){
                      setState(() {
                        Subject = value;
                      });
                    }),
                    ),
                    SizedBox(height: 10,),

                    Center(
                      child:
                      Text('Select Grade*',style:TextStyle(color: Colors.black, fontSize: 15)
                      ) ,),
                    new Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),child: DropdownButton<String>(hint: Text('(Grade Selector)'),value: grade,items: <String>
                    ['(Grade Selector)','R','1','2','3','4','5','6','7','8','9','10','11','12'].map((String value){
                      return new DropdownMenuItem(child: new Text(value,style:
                      TextStyle(color: Colors.black),),value: value);
                    }).toList(), onChanged:(value){
                      setState(() {
                        grade = value;
                      });
                    }),
                    ),

                    SizedBox(height: 10,),

                    Center(
                      child:
                      Text('Select Set*',style:TextStyle(color: Colors.black, fontSize: 15)
                      ) ,),
                    new Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),child: DropdownButton<String>(value: set,items: <String>
                    ['(Set Selector)','1','2','3','4','5','6','7'].map((String value){
                      return new DropdownMenuItem(child: new Text(value,style:
                      TextStyle(color: Colors.black),),value: value);
                    }).toList(), onChanged:(value){
                      setState(() {
                        set = value;
                      });


                    }),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      child: OutlineButton(
                        onPressed: () async {
                          Confirm(context, new DBHelper(), 'Create Subject',
                              'Would you like to create the subject with the following information?\n' +
                                  '\nSubject:' + Subject +
                                  '\nGrade: ' + grade +
                                  '\nSet: ' +set);
                        },
                        color: Colors.black,
                        textColor: Colors.black,
                        child: Text("Create Subject"),),
                    ),
                    SizedBox(height: 25,),
                    Icon(Icons.book,size: 250 , color: Colors.blueAccent,)



                  ],
                ),
              )
            ],
          ),
        ],), onWillPop: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntacomHome()));
        })

    );
  }

  Confirm(BuildContext context, DBHelper db_helper, String title,
      String description) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(

            title: Text(title,),
            elevation: 7.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
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
                onPressed: () async {
                  db_helper.insertContact(
                      new ContactInformation(grade.trim(), Subject.trim(),set.trim()));
                  Navigator.pop(context);
                  Informattion(
                      context, 'Created', 'Subject:' + Subject + ' Created');
                  setState(() async {
                    await changeQrInformation().then((value){
                      this._dataString = value;
                      // _captureAndSharePng();

                    });
                  });

                },
              )
            ],
          );
        }
    );
  }

  Future<String> changeQrInformation()async{

 return generateQRCode(await getEducatorInformation(), Subject, grade,set);
  }


  Future<String> generateQRCode(TeacherInformation TI, String Subject,
      String Grade, String set) async {
    String QRString = TI.teacherTitle + ':' + TI.teacherName + ':' +
        TI.teacherSurname
        + ':' + TI.teacherID + ':' + TI.RegisterClass + ':' + Subject + ':' +
        Grade + ':' + set;
    _dataString = QRString;
    // Image img = await QrUtils.generateQR(QRString);

    return QRString;
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QRView(Subject, grade, ti , DateTime.now().year.toString(),set )));
                  writeToFirebase();
                },
              )
            ],
          );
        }
    );
  }
writeToFirebase(){
    DatabaseReference ref = FirebaseDatabase.instance.reference();

    ref.child(Strings.SCHOOL_NAME).child(DateTime.now().year.toString()).child('GRADE').child(grade)
        .child('SUBJECTS').child(Subject).child('TEACHER').child(Strings.EMPLOYEE_NUMBER).child('EDUCATOR_DETAILS')
        .set(TeacherInformation.blank().toMap());

    ref.child(Strings.SCHOOL_NAME).child(DateTime.now().year.toString()).child('GRADE').child(grade)
        .child('SUBJECTS').child(Subject).child('TEACHER').child(Strings.EMPLOYEE_NUMBER).child('SET_NUMBER').child(set)
        .set(Subject_Set(Subject + ' ' + set, set ).toMap());



}

  //QRCODE CODE//////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////


  _contentWidget() {
    final bodyHeight = MediaQuery
        .of(context)
        .size
        .height - MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[

             Center(
              child: RepaintBoundary(
                  key: _globalKey,
                  child: QrImage(data: _dataString
                    , size: 0.5 * bodyHeight)
              ),
            ),

        ],
      ),
    );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext
          .findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');
    } catch (e) {
      print(e.toString());
    }
  }

  getTeacherInformation() async{
    ti = await getEducatorInformation();
  }
}
