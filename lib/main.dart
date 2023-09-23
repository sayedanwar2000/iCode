import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/controller/cubits/login_cubit.dart';
import 'package:task/controller/states/layout_states.dart';
import 'package:task/share/network/local/cache_helper/cache.dart';
import 'package:task/views/splash/splash_screen.dart';
import 'controller/cubits/layout_cubit.dart';
import 'share/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LayoutCubit()
            ..createDataBase(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit()
          ..initializeAuto(),
        ),
      ],
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
