class SchoolInformation{

  int id;


  String SCHOOL_TABLE ;
  String SCHOOL_NAME;
  String SCHOOL_LOCATION ;
  String SCHOOL_EMAIL ;
  String SCHOOL_CONTACTS ;
  String SCHOOL_PRINCIPAL ;

  SchoolInformation.blank();

  //convert from list to map
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    if ( id != null ) {
      map['id'] = id;
    }
    map['SCHOOL_NAME'] = SCHOOL_NAME;
    map['SCHOOL_LOCATION'] = SCHOOL_LOCATION;
    map['SCHOOL_CONTACT'] = SCHOOL_CONTACTS;
    map['SCHOOl_EMAIL'] = SCHOOL_EMAIL;
    map['SCHOOL_PRINCIPAL'] = SCHOOL_PRINCIPAL;

    return map;
  }

  //extract a child object from the Map object
  SchoolInformation.fromMapObject(Map<String ,dynamic> map){
    this.id = map['id'];
    this.SCHOOL_NAME = map['SCHOOL_NAME'];
    this.SCHOOL_LOCATION = map['SCHOOL_LOCATION'];
    this.SCHOOL_CONTACTS = map['SCHOOL_CONTACTS'];
    this.SCHOOL_EMAIL = map['SCHOOL_EMAIL'];
    this.SCHOOL_PRINCIPAL = map['SCHOOL_PRINCIPAL'];
  }


  SchoolInformation(this.id, this.SCHOOL_TABLE, this.SCHOOL_NAME,
      this.SCHOOL_LOCATION, this.SCHOOL_EMAIL, this.SCHOOL_CONTACTS,
      this.SCHOOL_PRINCIPAL);

  String getSCHOOL_TABLE () {
    return SCHOOL_TABLE;
  }

    setSCHOOL_TABLE(String value) {
      SCHOOL_TABLE = value;
    }

    String getSCHOOL_NAME () {
      return SCHOOL_NAME;
    }

    String getSCHOOL_PRINCIPAL() {
      return SCHOOL_PRINCIPAL;
    }

    setSCHOOL_PRINCIPAL(String value) {
      SCHOOL_PRINCIPAL = value;
    }

    String getSCHOOL_CONTACTS () {
      return SCHOOL_CONTACTS;
    }

    setSCHOOL_CONTACTS(String value) {
      SCHOOL_CONTACTS = value;
    }

    String getSCHOOL_EMAIL () {
      return SCHOOL_EMAIL;
    }

    setSCHOOL_EMAIL(String value) {
      SCHOOL_EMAIL = value;
    }

    String getSCHOOL_LOCATION () {
      return SCHOOL_LOCATION;
    }

    setSCHOOL_LOCATION(String value) {
      SCHOOL_LOCATION = value;
    }

    setSCHOOL_NAME(String value) {
      SCHOOL_NAME = value;
    }

    int getid() {
      return id;
    }

    setid(int value) {
      id = value;
    }
  }

