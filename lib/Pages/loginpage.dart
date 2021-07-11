import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:educator_app/Pages/Entacom_home.dart';
import 'package:educator_app/SQL_Models/child_model.dart';
import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:educator_app/SQL_Models/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:educator_app/UIX/Dialogs.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TeacherAccess.dart';
import 'package:educator_app/BackEnd/Strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:educator_app/Pages/Select_School.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageSate createState()=>_LoginPageSate();
}
class _LoginPageSate extends State<LoginPage>{
  String _email;
  String schoolAuthentication;
  String   _password;
  String schoolName, teacherID, subField, subDepartment, subID, studentNumber;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  DBHelper dbaccess = new DBHelper();
  Dialogs dialogs = new Dialogs();
  //google sign
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  final formkey=new GlobalKey<FormState>();
  checkFields(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }



  LoginUser(){
    if (checkFields()){
      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
          .then((user){

        Navigator.of(context).pushReplacementNamed('/userpage');
      }).catchError((e){
        print(e);
        dialogs.Informattion(context, "ERROR", e.toString());

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Material(
      color: Colors.blueAccent,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 150, //220
            width: 150, //110
            margin: EdgeInsets.only(top: 50.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain),

              borderRadius: BorderRadius.only
                (
                  bottomLeft: Radius.circular(500.0),
                  bottomRight: Radius.circular(500.0)
              ),

           ),
          ),

         Center(
           child : Text(
            "Entacom Teacher",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontFamily: "Sans",
              fontSize: 35.0,
            ),
          ),
         ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width - 200,
            child: Center(
              child: Padding(

                padding: const EdgeInsets.all(28.0),
                child: Center(
                    child: Form(

                      key: formkey,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[

              new Padding(padding: EdgeInsets.all(8.0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                            children: <Widget>[

                              Expanded(
                                flex: 1,
                                child: OutlineButton(
                                  color: Colors.white,
                                    //child: Text("login with google"),
                                   // child: ImageIcon(AssetImage("images/google1.png"),semanticLabel: "login",),
                                    child: Image(image: AssetImage("assets/google1.png"),height:28.0,fit: BoxFit.fitHeight),
                                    onPressed: () async{
                                      await _signIn().then(( FirebaseUser user){
                                       if(user.isEmailVerified) {
                                         choosePage();
                                       }
                                      }).catchError((e){
                                          e.toString();
                                          dialogs.Informattion(context, "ERROR", e.toString());
                                      });
                                    }),
                              )

                            ],
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              launch('https://entacom.qubitengineering.co.za/Policies/Privacypolicy/index.html');
                            },child:
                          SizedBox(child: Text(
                            "By Logging in you agree to our Privacy Policy and Terms & Conditions.",
                            style: TextStyle(fontFamily: 'Montserrat', color: Colors.blueAccent),maxLines: 3,textAlign: TextAlign.center,
                          ), width: 300,),
                          ),

                        ],
                      ),

                    ],

                  ),

                ),
              ),),

                          ],

                        ),
                      ),
                    )
                ),
              ),
            ),
          ),
        ],
      ) ,
    );
  }
  Widget _input(String validation,bool ,String label,String hint, save ){
    return new TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          fillColor: Colors.white,
          labelText: label,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
      ),
      obscureText: bool,
      validator: (value)=>
      value.isEmpty ? validation: null,
      onSaved: save ,

    );

  }



PopUpNotification(String){

}

Future<FirebaseUser>_signIn()async{

  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = (await _auth.signInWithCredential(credential));
  setVirginity();
  return user;

}

setVirginity() async{
    SharedPreferences virginity = await SharedPreferences.getInstance();
    virginity.setBool('Virginity', true);
}

setSchoolSubscription()async{

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

  void choosePage() async {
    if (await checkSchools() == null) {
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => School_Select()));
    }
   else if (await checkRegistration() == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TeacherAccesss()));
    } else{
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => EntacomHome()));
    }
  }

    Future<bool>checkRegistration() async{
      SharedPreferences registration = await SharedPreferences.getInstance();
      return registration.getBool('registration');
    }

    Future<bool> checkVirginity() async {
      SharedPreferences virginity = await SharedPreferences.getInstance();

      return virginity.getBool('Virginity');
    }

    Future<bool> checkSchoolAuth() async {
      SharedPreferences schoolAuth = await SharedPreferences.getInstance();

      return schoolAuth.getBool("SchoolAuth");
    }

    Future<bool> checkUserAuth() async {
      SharedPreferences userUath = await SharedPreferences.getInstance();

      return userUath.getBool("UserAuth");
    }





}

