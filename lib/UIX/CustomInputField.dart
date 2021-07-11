import 'package:flutter/material.dart';






    class CustomInputField extends StatelessWidget{

      Icon fieldIcon;
      String hintTExt;
      CustomInputField(this.hintTExt, this.fieldIcon);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return // Email textbox
      Container(
        width: MediaQuery
            .of(context)
            .size
            .width - 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),

        child: Material(
          elevation: 7.0,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.cyan,
          child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: fieldIcon,

                ),
                TextField(

                    style: TextStyle(

                        fontSize: 20.0,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(hintText: hintTExt,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0))),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onChanged: (value) {
                      //  setState(() {
                      //  _email = value;
                    }
                ),
              ]
          ),
        ),
      );
  }}