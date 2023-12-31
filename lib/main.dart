import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task/bloc/LoginCubit/LoginCubit.dart';
import 'package:task/bloc/PostsCubit/post_Cubit.dart';
import 'package:task/models/product_model.dart';
import 'package:task/screens/login.dart';

import 'repository/authRepository/authRepo.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>("products");

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepository();
    return BlocProvider(
      create: (context) => LoginCubit(authRepository),
      child: BlocProvider(
        create: (context) => PostCubit(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: Login(),
        ),
      ),
    );
  }
}