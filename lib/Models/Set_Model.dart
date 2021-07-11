class Subject_Set{
  String _set_ID = '',_set_number = '';

  String get set_ID => _set_ID;

  set set_ID(String value) {
    _set_ID = value;
  }

  get set_number => _set_number;

  Subject_Set(this._set_ID, this._set_number);

  set set_number(value) {
    _set_number = value;
  }

  Map<String , dynamic> toMap(){

    Map<String, dynamic> map = new Map();

    map['SET_ID'] = this._set_ID;
    map['SET_NUMBER'] = this._set_number;

    return map;
  }


}