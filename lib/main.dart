import 'src/constant/hive_constant.dart';
import 'src/controller/read_data/read_data_cubit.dart';
import 'src/controller/write_data/write_data_cubit.dart';
import 'src/feature/home/view/home_screen.dart';
import 'src/model/word_type_adapter.dart';
import 'src/utils/app_them.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  // initialize hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  await Hive.openBox(wordsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WriteDataCubit(),
        ),
        BlocProvider(
          create: (context) => ReadDataCubit()..getAllWords(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: AppTheme.appTheme,
        theme: ThemeData.dark(),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
