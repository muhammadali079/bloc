// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:practice_bloc/bloc/counter_bloc/counterBloc.dart';
// import 'package:practice_bloc/bloc/item_bloc/itemBloc.dart';
// import 'package:practice_bloc/screens/counter_screen.dart';
// import 'package:practice_bloc/bloc/repository/item_repository.dart';
// import 'package:practice_bloc/screens/item_screen.dart';

// void main() {
 
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//    final itemRepository = ItemRespository(apiUrl: 'https://jsonplaceholder.typicode.com/posts');
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: BlocProvider(
//         create: (context) => ItemBloc(itemRepository),
//         child:ItemScreen(),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_bloc/bloc/item_bloc/itemBloc.dart';
import 'package:practice_bloc/bloc/repository/item_repository.dart';
import 'package:practice_bloc/screens/item_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final itemRepository = ItemRespository(apiUrl: 'https://jsonplaceholder.typicode.com/posts');
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(
          create: (context) => ItemBloc(itemRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ItemScreen(),
      ),
    );
  }
}

