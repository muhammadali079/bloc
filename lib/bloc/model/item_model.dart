class Item {
   int userId;
   int id;
   String title;
   String body;

  Item({required this.userId,required this.id, required this.title ,required this.body});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      userId: json['userId'],
      id: json['id'],
      title : json['title'],
      body : json['body'],
    );
  }
}