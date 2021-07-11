import 'package:educator_app/SQL_Models/contact_model.dart';
import 'package:educator_app/SQL_Models/message_model.dart';

class PrincipalMessage{
  messageInformation message;
  ContactInformation contactInformation;

  PrincipalMessage.blank();

  PrincipalMessage(this.message , this.contactInformation);

  Map toFirebase(){
   Map message = Map();
    message['Message'] = this.message.toMap();
    message['ContactInformation'] = this.contactInformation.toMap();

    return message;
  }
}