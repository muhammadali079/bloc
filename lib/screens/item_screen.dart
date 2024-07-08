// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:practice_bloc/bloc/item_bloc/itemBloc.dart';
// import 'package:practice_bloc/bloc/item_bloc/itemEvents.dart';
// import 'package:practice_bloc/bloc/item_bloc/itemsState.dart';
// import 'package:practice_bloc/bloc/model/item_model.dart';

// class ItemScreen extends StatefulWidget {
//   const ItemScreen({Key? key}) : super(key: key);

//   @override
//   State<ItemScreen> createState() => _ItemScreenState();
// }

// class _ItemScreenState extends State<ItemScreen> {
//   List<bool> _isExpandedList = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Items')),
//       body: Center(
//         child: SingleChildScrollView(
//           child: BlocBuilder<ItemBloc, ItemState>(
//             builder: (context, state) {
//               if (state is ItemInitial) {
//                 return Center(child: Text('Press the button to fetch items'));
//               } else if (state is ItemLoading) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (state is ItemLoaded) {
//                 _isExpandedList = List<bool>.filled(state.items.length, false);

//                 return Center(
//                   child: DataTable(
//                     columns: [
//                       DataColumn(label: Text('ID')),

//                     ],
//                     rows: List<DataRow>.generate(state.items.length, (index) {
//                       return DataRow(
//                         cells: [
//                           DataCell(
//                             InkWell(
//                               child: Text(state.items[index].id.toString()),
//                               onTap: () {
//                                 _toggleExpansion(index, state.items);
//                               },
//                             ),
//                           ),

//                         ],
//                       );
//                     }),
//                   ),
//                 );
//               } else if (state is ItemError) {
//                 return Center(
//                     child: Text('Failed to fetch items: ${state.message}'));
//               }
//               return Container();
//             },
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => context.read<ItemBloc>().add(FetchItems()),
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc/bloc/item_bloc/itemBloc.dart';
import 'package:practice_bloc/bloc/item_bloc/itemEvents.dart';
import 'package:practice_bloc/bloc/item_bloc/itemsState.dart';
import 'package:practice_bloc/bloc/model/item_model.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<bool> _isExpandedList = [];

  void _toggleExpansion(int index, List<Item> items) {
    setState(() {
      _isExpandedList[index] = !_isExpandedList[index];
      if (_isExpandedList[index]) {
        _showDetailsDialog(context, index, items);
      }
    });
  }

  void _showDetailsDialog(BuildContext context, int index, List<Item> items) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Details for ID: ${items[index].id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${items[index].title}'),
              SizedBox(height: 8),
              Text('Body: ${items[index].body}'),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _openPopToUpdateItem(context, index+1, items[index].title,
                          items[index].body);
                    },
                    child: Text('Update Item'),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _openPopToUpdateItem(
      BuildContext context, int index, String oldTitle, String oldBody) {
    TextEditingController titleController = TextEditingController();
    TextEditingController bodyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Details for ID: $index'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  label: Text("Enter new Title "),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                  label: Text("Enter new Body "),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (titleController.text == "") {
                          titleController.text = oldTitle;
                        }
                        if (bodyController.text == "") {
                          bodyController.text = oldBody;
                        }
                        context.read<ItemBloc>().add(UpdateItem(
                            id: index,
                            title: titleController.text,
                            body: bodyController.text));
                             Navigator.pop(context);
                      },
                      child: Text("Confirm")),
                ],
              )
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  int _rowsPerPage = 10;
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              if (state is ItemInitial) {
                return Center(child: Text('Press the button to fetch items'));
              } else if (state is ItemLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ItemLoaded || state is ItemUpdated) {
                List<Item> items = [];
                if (state is ItemLoaded) {
                  items = state.items;
                } else if (state is ItemUpdated) {
                  items = state.items;
                }
                _isExpandedList = List<bool>.filled(items.length, false);

                return PaginatedDataTable(
                  header: Text('Items List'),
                  rowsPerPage: _rowsPerPage,
                  columns: [
                    DataColumn(label: Text('ID')),
                  ],
                  source: ItemDataSource(
                      items, _pageIndex, _rowsPerPage, _toggleExpansion),
                  onPageChanged: (pageIndex) {
                    setState(() {
                      //_pageIndex = pageIndex;
                    });
                    print('Page changed to: $pageIndex');
                  },
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.navigate_before),
                      onPressed: _pageIndex == 0
                          ? null
                          : () {
                              setState(() {
                                _pageIndex--;
                              });
                            },
                    ),
                    IconButton(
                      icon: Icon(Icons.navigate_next),
                      onPressed:
                          (_pageIndex + 1) * _rowsPerPage >= items.length
                              ? null
                              : () {
                                  setState(() {
                                    _pageIndex++;
                                  });
                                },
                    ),
                  ],
                );
              } else if (state is ItemError) {
                return Center(
                    child: Text('Failed to fetch items: ${state.message}'));
              }
              return Container();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ItemBloc>().add(FetchItems()),
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ItemDataSource extends DataTableSource {
  final List<Item> _items;
  final int _pageIndex;
  final int _rowsPerPage;
  final Function(int, List<Item>) _toggleExpansion;

  ItemDataSource(
      this._items, this._pageIndex, this._rowsPerPage, this._toggleExpansion);

  @override
  DataRow getRow(int index) {
    int dataIndex = _pageIndex * _rowsPerPage + index;
    if (dataIndex >= _items.length) {
      throw FlutterError(
          'Index $index is out of bounds for data source with ${_items.length} items.');
    }
    Item item = _items[dataIndex];
    return DataRow.byIndex(
      index: dataIndex,
      cells: [
        DataCell(
          InkWell(
            child: Text(item.id.toString()),
            onTap: () {
              _toggleExpansion(dataIndex, _items);
            },
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _items.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
