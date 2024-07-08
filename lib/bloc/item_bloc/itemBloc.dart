import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc/bloc/item_bloc/itemEvents.dart';
import 'package:practice_bloc/bloc/item_bloc/itemsState.dart';
import 'package:practice_bloc/bloc/model/item_model.dart';
import 'package:practice_bloc/bloc/model/manage_item_model.dart';
import 'package:practice_bloc/bloc/repository/item_repository.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRespository itemRepository;

  ItemBloc(this.itemRepository) : super(ItemInitial()) {
    on<FetchItems>((event, emit) async {
      emit(ItemLoading());
      try {
        final items = await itemRepository.fetchItems();
        emit(ItemLoaded(items));
      } catch (e) {
        emit(ItemError(e.toString()));
      }
    });
    on<UpdateItem>((event, emit)async {

      ManageItem manageItem = ManageItem();
      print("printing logs from bloc");
      print("id : ${event.id}");
       print("title : ${event.title}");
        print("body : ${event.body}");
      manageItem.updateItem(event.id, event.title, event.body);
      List<Item> items = manageItem.getItems;
      items.forEach((element) {
           print("id : ${element.id}");
       print("title : ${element.title}");
        print("body : ${element.body}");
      },);
      
      emit((ItemUpdated(items: items)));
          
    });
    
  }
}