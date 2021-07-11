class YearInformation{
    int _id;
   String _SCHOLAR_YEAR;
   String _STUDENT_NUMBER;

   YearInformation.blank();

   YearInformation(this._id,this._SCHOLAR_YEAR, this._STUDENT_NUMBER);

    int get id => _id;

    set id(int value) {
      _id = value;
    }

    String get STUDENT_NUMBER => _STUDENT_NUMBER;

   set STUDENT_NUMBER(String value) {
     _STUDENT_NUMBER = value;
   }

   String get SCHOLAR_YEAR => _SCHOLAR_YEAR;

   set SCHOLAR_YEAR(String value) {
     _SCHOLAR_YEAR = value;
   }


    Map<String, dynamic> toMap(){
      var map = Map<String, dynamic>();
      if ( _id != null ) {
        map['id'] = _id;
      }
      map['STUDENT_NUMBER'] = this.STUDENT_NUMBER;
      map['SCHOLAR_YEAR'] = this.SCHOLAR_YEAR;
      return map;
    }

    //extract a child object from the Map object
    YearInformation.fromMapObject(Map<String ,dynamic> map){
      this._id = map['id'];
      this.STUDENT_NUMBER = map['STUDENT_NUMBER'];
      this.SCHOLAR_YEAR = map['SCHOLAR_YEAR'];
    }


}

