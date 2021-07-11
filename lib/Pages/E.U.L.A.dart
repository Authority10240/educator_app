import 'package:flutter/material.dart';
import 'Entacom_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/Pages/NoSubscription.dart';
import 'TeacherAccess.dart';
import 'package:educator_app/Pages/NoAuthority.dart';
import 'package:educator_app/Pages/Select_School.dart';
import 'loginpage.dart';
import 'package:educator_app/Models/School_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educator_app/Pages/SplashScreen.dart';
import 'package:educator_app/BackEnd/Strings.dart';
class EULA extends StatefulWidget {
  @override
  _EULAState createState() => _EULAState();
}

class _EULAState extends State<EULA> {
  @override

  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('End User License Agrement'),),

      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width - 200,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                    "Entacom Inc. provides instant messaging, and  document distribution to different, large scale population organizations. Please read our terms of service. By signing this contract you agree to our Terms of Service."
                        +
                        "By clicking agree you accept our terms and conditions and take knowledge you have read the End user License below."


                        +
                        "No Access to emergency services, there are multiple and crucial differences between Entacom and your mobile SMS services. Our services do not provide access to emergency services, or emergency services provides, including the police, fire departments or hospitals, or otherwise connect to public safety  answering points. You should ensure that you are able to connect relevant emergency services providers through alternative means aside from Edulnk."
                        + "About our services"
                        +
                        "Registration, after signing this contract every user is required to register by using accurate email information. Once registered you have agreed to receiving messages from the respectful sources chosen by you."
                        +
                        "Devices and Software, you must provide certain devices, software and data connections to use Entacom services, as long as you are an Entacom user, you consent to download updates."
                        +
                        "Fees and taxes, you are responsible for all carrier data plans and fees for the use of service will be paid once of within the contract agreement. we do not provide refunds for our service, accept as required by law."
                        + "Privacy Policy"
                        +
                        "Entacom cares about your privacy , with Entacom there are not many concerns with privacy as the software does not require any user to share any personal or contact information, ( Cell Phone Numbers , Email Address, Pins , Passwords, Identification Numbers e.t.c) All information captured during the registration process will be kept confidential in Edulink itself and under no circumstances will this information be disclosed to anyone, this information is just for registration and statistics use only."
                        + "Acceptable use of our Services"
                        +
                        "Our terms and polies, you must use our services accordingly to our terms and posted polices. If we disable your account, you will not be able to recreate an account, without our permission."
                        +
                        "Legal and acceptable use, you must access and use our services only for legal, authorized and acceptable purposes."
                        + "You will not use our services in ways that"
                        +
                        "a.	 Violate, misappropriate, or infringe the rights of Entacom our users or others, including privacy, publicity, intellectual property, or other proprietary right."
                        +
                        "b.	Are illegal, obscene, defamatory, threatening, intimidating, harassing, hateful, racially or ethnically offensive, or instigate or encourage conduct that will be illegal, or otherwise inappropriate, including promoting violent crimes."
                        +
                        "c.	Involve publishing falsehoods, misrepresentation or misleading statement, or content."
                        + "d.	Impersonate someone."
                        +
                        "e.	Involve sending illegal or impermissible communications, such as bulk messaging, auto messaging and the like, or involve any nonprofessional use of our services."
                        + "Harm to Entacom or its users."
                        +
                        "You must not (or assist others to ) access, use , copy, adapt , modify, prepare derivative works based upon, distributive, license, sublicense, transfer, display, perform, or otherwise, exploit our services. Any impermissible or unauthorized manners, or in ways that burden, impair or harm us, our services, systems, our users, or others,"
                        +
                        "The Entacom Entities make no warranty and disclaim all responsibility and liability for: (i) the completeness, accuracy, availability, timeliness, security or reliability of the Services or any Content; (ii) any harm to your computer system, mobile systems, loss of data, or other harm that results from your access to or use of the Services or any Content; (iii) the deletion of, or the failure to store or to transmit, any Content and other communications maintained by the Services; and (iv) whether the Services will meet your requirements or be available on an uninterrupted, secure, or error-free basis. No advice"
                        +
                        "Including that you must not directly, or through automated means."
                        +
                        "a.	Reveres engineer, alter, modify, create derivative works from, decompile or extract code from our services."
                        +
                        "b.	Send, store or transmit viruses or other harmful computer called through or unto our services."
                        +
                        "c.	Gain or attempt to gain unauthorized access to our services or systems."
                        +
                        "d.	Interfere with, or disrupt the integrity or performance of our services."
                        +
                        "e.	Create accounts for our services through unauthorized or automated means."
                        +
                        "f.	Collect the information of or about our users in any impermissible or unauthorized manner."
                        + "g.	Sell, resell, rent, or charge for our services."
                        +
                        "h. Sharing this app or sending it to others is strictly prohibited and legal action can be taken against you. By clicking agree you agree not to distribute this app with anyone"
                        +
                        "Keeping your account secure, as a broadcaster and a receiver you are responsible for keeping your devices and Your Edulink Account safe and secure, Edulink will not be held Liable for any information, content, distributed from your account, you must notify us promptly of any unauthorized use or security breach of your account or our services."

                        + "Third-party services"
                        +
                        "Our services may allow you to access, use , or interact with third party websites, storage. (such as Firebase) that are integrated with our app."
                        + "Licenses"


                        +
                        "Edulink owns all copyrights, trademarks, domains, logos, trade dress, trade secrets, patents and other intellectual trip rights associated with our services. You may not use our copyright trademarks, domains and logos, trade dress, patents, and other intellectual  property right unless you have our express permission."
                ),
                SizedBox(height: 10,),
                Row(children: <Widget>[
                  Container(width: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
                    child: OutlineButton(onPressed: () async {
                      setEULA();

                      choosePage();
                    },
                        color: Colors.black,
                        textColor: Colors.black,
                        child: Text("Agree")

                    ),),


                ],)
              ],
            ),
          )
        ],
      ),
    );
  }

  checkSchools() async {
    SharedPreferences sp = await  SharedPreferences.getInstance();
    if(sp.getString('SCHOOL_LOGO') == null ) {

    }else{

      Strings.insertSchool(sp.getString('SCHOOL_NAME'), sp.getString('SCHOOL_LOGO'));
    }

      return sp.getString('SCHOOL_LOGO');
  }
  void setEULA() async {
    SharedPreferences EULA = await SharedPreferences.getInstance();
    EULA.setBool('EULA', true);
  }

  void choosePage() async {
        if(await checkSchools() == null){
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => School_Select()));
        }
        else if (await checkVirginity() == null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        }else if (await checkRegistration() == null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TeacherAccesss()));
        }else if (await checkUserAuth() == false) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoAuthority()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EntacomHome()));
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