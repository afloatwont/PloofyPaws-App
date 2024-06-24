class Message {
  String? text, id;
  Message({required this.text, required this.id});

  Message.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    text = data['text'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}
