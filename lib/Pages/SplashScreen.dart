import 'dart:async';
import 'package:educator_app/Pages/Entacom_home.dart';
import 'package:educator_app/Pages/Select_School.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:educator_app/Pages/loginpage.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/Pages/NoSubscription.dart';
import 'package:educator_app/Pages/NoAuthority.dart';
import 'E.U.L.A.dart';
import 'TeacherAccess.dart';
import 'NoAuthority.dart';
import 'package:educator_app/BackEnd/Strings.dart';
import 'NoSubscription.dart';

/// Run first apps open
void main() {
  runApp(myApp());
}

/// Set orienttation
class myApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    /// To set orientation always portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    ///Set color status bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent, //or set color with: Color(0xFF0000FF)
    ));
    return new MaterialApp(
      title: "+Up",
      theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          primaryColorLight: Colors.cyan,
          primaryColorBrightness: Brightness.light,
          primaryColor: Colors.cyan),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      /// Move splash screen to ChoseLogin Layout
      /// Routes
      routes: <String, WidgetBuilder>{
    //    "login": (BuildContext context) => new LoginPage(),
      },
    );
  }
}

/// Component UI
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends  State<SplashScreen> {
  DatabaseReference reference ;
  SharedPreferences sp;

  @override

  /// Setting duration in splash screen
  startTime() async {
    return new Timer(Duration(milliseconds: 4500), NavigatorPage);
  }

  /// To navigate layout change
  void NavigatorPage() {
    choosePage();
  }

  /// Declare startTime to InitState
  @override
  void initState() {
    super.initState();

    startTime();

  }

  /// Code Create UI Splash Screen
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(

        /// Set Background image in splash screen layout (Click to open code)
        decoration: BoxDecoration(
        ),
        child: Container(

          /// Set gradient black in image splash screen (Click to open code)
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.3),
                    Color.fromRGBO(0, 0, 0, 0.4)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                    ),

                    /// Text header "Welcome To" (Click to open code)
                    Hero(
                      tag: "Logo",
                      child: Image.asset(
                        'assets/logo.png',
                        width: 120.0,
                        height: 120.0,

                      ),

                    ),
                    Text(
                      "Entacom Teacher",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Sans",
                        fontSize: 35.0,
                      ),
                    ),

                    /// Animation text Treva Shop to choose Login with Hero Animation (Click to open code)
                    Hero(
                      tag: "+Up",
                      child: Text(
                        "By Educators, For Educators",
                        style: TextStyle(
                          fontFamily: 'Sans',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                          letterSpacing: 0.4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Hero(tag: 'School',
                        child: Image.network(Strings.SCHOOL_LOGO,
                          width: 180.0,
                          height: 180.0,),
                    )


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<bool> checkVirginity() async {
    bool virgin;
    SharedPreferences virginity = await SharedPreferences.getInstance();
    virgin = virginity.getBool('Virginity');
    return virgin;
  }

  Future<bool> checkSchoolAuth() async {
    bool auth;
    SharedPreferences schoolAuth = await SharedPreferences.getInstance();
    auth = schoolAuth.getBool("SchoolAuth");
    return auth;
  }

  Future<bool> checkUserAuth() async {
    bool auth;
    SharedPreferences userUath = await SharedPreferences.getInstance();
    auth = userUath.getBool("UserAuth");
    return auth;
  }

  void choosePage() async {

    if (await checkEULAAgreement() == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EULA()));
    } else if(await checkVirginity() == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }else if (await checkSchools() == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => School_Select()));
    }else if (await checkRegistration() == null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeacherAccesss()));
    }else if (await checkUserAuth() == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoAuthority()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntacomHome()));
    }
  }

Future<String>   checkSchools() async {
  SharedPreferences sp = await  SharedPreferences.getInstance();
  if(sp.getString('SCHOOL_LOGO') == '' ) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => School_Select()));
  }else{

    Strings.insertSchool(sp.getString('SCHOOL_NAME'), sp.getString('SCHOOL_LOGO'));
    setState(() {

    });
  }

return sp.getString('SCHOOL_LOGO');
}

  Future<bool>checkRegistration() async{
    SharedPreferences registration = await SharedPreferences.getInstance();
    return registration.getBool('REGISTERED');
  }






  Future<bool> checkEULAAgreement() async{
    SharedPreferences EULAAgree = await SharedPreferences.getInstance();

    return EULAAgree.getBool('EULA');
  }

  setSubScription() async{
    SharedPreferences subscription = await SharedPreferences.getInstance();
    reference = FirebaseDatabase.instance.reference().child('ClientPassword')
    .child('Password').child('Capricorn High School');
    




  }
  setAuthority() async {
    SharedPreferences authority = await SharedPreferences.getInstance();
    reference = FirebaseDatabase.instance.reference().child("Capricorn High School")
        .child('TEAHER_ACCESS').child('teacherID');
    reference.onChildChanged.listen((change){

    });
  }
}
