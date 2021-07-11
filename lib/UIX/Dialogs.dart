import 'package:flutter/material.dart';
import 'package:educator_app/BackEnd/DBHelper.dart';
import 'package:educator_app/SQL_Models/child_model.dart';
class Dialogs {

  static String text ;

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
                },
              )
            ],
          );
        }
    );
  }

  Waiting(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
          );
        }
    );
  }

  Input(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
              TextField(
                decoration: InputDecoration(
                  hintText: description,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) => text = value,
              ),
              FlatButton(
                child: Text('Cancel'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                color: Colors.cyan,
                onPressed: () {
                  text = '';
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Confirm'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                color: Colors.cyan,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        }
    );
  }




  void AddChildProcess(BuildContext context, DBHelper db_helper,
      ChildInformaiton childInfo) async {
    // if (!await db_helper.CheckUser(childInfo)) {
    db_helper.addNewStudent(childInfo);
    Informattion(context, 'Student Added', 'Student succesfully Added.');
    /*} else {
      Informattion(
          context, 'Already Added', 'This student has already been Added.');
    }*/
  }

  EULA(BuildContext context, String Description) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("End User License Agreement",),

            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(Description),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Decline', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  text = '';
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('Accept', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
