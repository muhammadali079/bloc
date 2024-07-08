import 'package:practice_bloc/bloc/model/item_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:practice_bloc/bloc/model/manage_item_model.dart';

class ItemRespository {
  String apiUrl;
  ItemRespository({required this.apiUrl});
  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Item> items =  data.map((json) => Item.fromJson(json)).toList();
      ManageItem manageItem = ManageItem();
      manageItem.initializeItems(items);
       return items;
    } else {
      throw Exception('Failed to load items');
    }
  }
}