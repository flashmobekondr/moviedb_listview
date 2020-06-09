import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movidblist/core/bloc/simple_bloc_delegate.dart';
import 'package:movidblist/pages/moviedb_catalog/moviedb_catalog_page.dart';
import 'package:movidblist/pages/moviedb_detail/bloc/bloc.dart';


import 'moviedb_injection_container.dart' as di;
import 'package:movidblist/pages/moviedb_catalog/bloc/bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CatalogPageBloc>(
            create: (context) =>di.sl<CatalogPageBloc>()..add(CatalogPageFetchEvent()),
          ),
          BlocProvider<DetailPageBloc>(
            create: (context) => di.sl<DetailPageBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: CatalogPage(),
        ),
    );
  }
}

