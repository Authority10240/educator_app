import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/SQL_Models/TeacherInformation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:share/share.dart';
import 'package:educator_app/Pages/Entacom_home.dart';
class QRView extends StatefulWidget {
  @override
  String Subject='' , Grade='' , Employee='' , year ='' , set = '';
  TeacherInformation ti;


  QRView(this.Subject , this.Grade , this.ti, this.year, this.set);
  _QRViewState createState() => _QRViewState(Subject,Grade,ti, year,set);
}

class _QRViewState extends State<QRView> {
  @override
  String Grade='', Subject='', Employee='' , _dataString='' , year='',set='';
  GlobalKey _globalKey = new GlobalKey();
  TeacherInformation ti;

  _QRViewState(this.Subject, this.Grade, this.ti , this.year,this.set);
  Widget build(BuildContext context) {

    setQRInformation();
    checkPermissions();

    
   // _captureAndSharePng();
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      centerTitle: true,
      title: Text('Subject QR Code'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _contentWidget(),
          ],
        ),
      ),
    );
  }

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
          Divider(height: 10,),
          ListTile(
            leading: CircleAvatar(backgroundColor: Colors.blueAccent, child: Text(Subject[0].toUpperCase()),),
            title: Text('Subject : ' + Subject),
            subtitle: Text('Grade: ' + Grade+ ' Set: ' + set),
          ),
          Divider(height: 20,),

          Center(
            child: RepaintBoundary(
                key: _globalKey,
                child: QrImage(data: _dataString)
            ),
          ),
          FlatButton(child: Text('Share QR Code'),color: Colors.blueAccent,onPressed: (){
            createDirectory();
            //_shareFile();
          },),
          FlatButton(child: Text('       Finish         '),color: Colors.blueAccent,onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntacomHome() ));
            //_shareFile();
          },)
        ],
      ),
    );
  }


  Future<String> generateQRCode(TeacherInformation TI, String Subject,
      String Grade) async {
    String QRString = TI.teacherID + ':' + TI.teacherTitle + ':' + TI.teacherName + ':' +
        TI.teacherSurname
        + ':' +  TI.RegisterClass + ':' + Subject + ':' +
        Grade;
    _dataString = QRString;
    // Image img = await QrUtils.generateQR(QRString);

    return QRString;
  }


  String QRContent(){
    /*
                String Device_ID = MainScreen.cEmployeeNumber;
                String User_Department = token.nextToken();
                String User_Course = token.nextToken();
                String User_Subject = token.nextToken();
                String User_ID = token.nextToken();
                String Institution = token.nextToken(); // School name
                sSubject = User_Subject;
     */


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

  Future setQRInformation() async {

    _dataString = await generateQRCode(ti, Subject, Grade);

  }



  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext
          .findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData = await image.toByteData(
          format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
     // String bs64 = base64Encode(pngBytes);
    await writeCounter(pngBytes);
    }catch(e){
      print(e);
    }

  }
  createDirectory()async{
    final path = await localPath;
    final myDir = new Directory('$path/Entacom/QrCodes/'+year);
    myDir.exists().then((exists){
      exists ? print('created') : myDir.create();
       _capturePng().then((complete){

      });
    });
  }


  _shareFile(String URL)async{
    final path = await localPath;


  }

 Future<String> get localPath async{
    final directory = await getExternalStorageDirectory();

    return directory.path;
 }

 Future<File> get localFile async {
   final path = await localPath;
   return File('$path/Entacom/QRCodes/'+year+'/' + Subject + '_' + Grade +'.png' );
 }

 Future<File> writeCounter(Uint8List counter) async{
    try {
      final file = await localFile;
      saveFileOnline(counter);
      return file.writeAsBytes(counter);
    }catch(e){
      print(e);
    }
 }

 Future <String>saveFileOnline(Uint8List pic)async{
    final file = await localFile;
    final StorageReference storageReference = FirebaseStorage().ref().child('Entacom').child('QrCodes').child(year);
    final StorageUploadTask uploadTask = storageReference.putData(pic);
    final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event){
      print('EVENT ${event.type}');
    });
    var downURL = await(await uploadTask.onComplete).ref.getDownloadURL();
    String url = downURL.toString();
    Share.share('Thank you for using Entacom,\nPlease click link below to download QR code\n\n' + url);
    streamSubscription.cancel();
 }

 checkPermissions() async{
   PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
   if (permission.value == 0)
     {
       Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);

     }

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

                  Navigator.pop(context);



                },
              )
            ],
          );
        }
    );
  }

}
