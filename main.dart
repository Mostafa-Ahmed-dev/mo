import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/Core/utils/Cache.dart';
import 'package:shopapp/Core/utils/DioHelper.dart';
import 'package:shopapp/Core/utils/Themes.dart';
import 'package:shopapp/Features/Home/presentation/HomeView.dart';
import 'package:shopapp/Features/LoginView/presentation/views/LoginView.dart';
import 'package:shopapp/Features/OnBoardingView/Presentation/views/OnBoardingView.dart';

import 'Core/utils/Observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await Cache.intit();
  Bloc.observer = MyBlocObserver();
  dynamic token = await Cache.getData(key: 'token');

  dynamic onBoarding = await Cache.getData(key: 'onBoarding');

  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeView();
    } else {
      widget = const LoginView();
    }
  } else {
    widget = const OnBoardingView();
  }
  runApp(ShopApp(
    startWidget: widget,
  ));
}

class ShopApp extends StatelessWidget {
  const ShopApp({
    super.key,
    required this.startWidget,
  });
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: darkTheme,
      theme: lightTheme,
      home: startWidget,
    );
  }
}
