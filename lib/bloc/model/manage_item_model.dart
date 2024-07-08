
import 'package:practice_bloc/bloc/model/item_model.dart';

class ManageItem {
   List<Item> items;

  ManageItem._internal({required this.items});

  static final ManageItem _instance = ManageItem._internal(items: []);

  factory ManageItem() {
    return _instance;
  }
  void initializeItems(List<Item> newItems) {
    items = newItems;
  }

  void updateItem(int id, String newTitle, String newBody) {
    for (var item in items) {
      if (item.id == id) {
        item = Item(userId: item.userId, id: item.id, title: newTitle, body: newBody);
        break;
      }
    }
  }

  List<Item> get getItems => items;

}