
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
        print("Item found in inventory");
         item.title = newTitle;
         item.body=newBody;
        break;
      }
    }
  }

  List<Item> get getItems => items;

}