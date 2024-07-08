import 'dart:typed_data';

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
      //print("data: $data");
      List<Item> items =  data.map((json) => Item.fromJson(json)).toList();
      ManageItem manageItem = ManageItem();
      manageItem.initializeItems(items);
      // items.forEach((element) {
      //   print("data type:  ${element.userId.runtimeType}");
      //   print("userID : ${element.userId}");
      //   print("ID : ${element.id}");
      //   print("Title : ${element.title}");
      //   print("Body : ${element.body}");
      // });
      Map<int , List<Item>> groupedItems = {};
      items.forEach((item) {
            if(groupedItems.containsKey(item.userId)){
              groupedItems[item.userId]!.add(item);
             // print("user found map : ${groupedItems[item]}");
            }else{
              groupedItems[item.userId]=[item];
             // print("new  user  map : ${groupedItems[item]}");
            }
       });
      // print("grouped items:  ${groupedItems[1]}");
       // return groupedItems[1]!.toList();
       return items;
    } else {
      throw Exception('Failed to load items');
    }
  }
}