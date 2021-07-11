class chat_Model{
  final String teacher_Name;
  final String messageContent;
  final String dateAndTime;
  final String avaterURL;

  chat_Model({this.teacher_Name,this.messageContent,this.dateAndTime,this.avaterURL});

}

List<chat_Model> messageDate = [
  new chat_Model(
      teacher_Name: 'Mr Mathebula',
      dateAndTime: new DateTime.now().toString(),
      messageContent: 'Homework is due tomorrow',
      avaterURL: ''
  )
];