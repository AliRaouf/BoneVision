class Message {
  late String text;
  late DateTime time;
  late String sender;
  late String groupName;

  Message({ required this.text, required this.time, required this.sender, required this.groupName});


  Map<String,dynamic> toMap()
  {
    return {
      'text':text,
      'time':time,
      'sender':sender,
      'groupName':groupName
    };
  }


}