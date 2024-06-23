import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Models/Cubit.dart';
import 'package:weather_app/Models/States.dart';

import 'Modules/Home_Screen.dart';
import 'Modules/Select_City.dart';
import 'Shared/Cache_Helper.dart';
import 'Shared/Dio_Helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();


  DateTime dateTime = DateTime.now();
  print(dateTime.hour);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>WeatherCubit(),//..GetCityData(),
      child: BlocConsumer<WeatherCubit,WeatherStates>(
        builder: (BuildContext context, WeatherStates state) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SelectCity(),
          );
        },
        listener: (BuildContext context, WeatherStates state) {  },

      ),
    );
  }
}

