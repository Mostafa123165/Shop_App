import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/block_opserver/bloc_opserver.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/lay_out/on_boarding_screen.dart';
import 'package:shopapp/lay_out/shop_lay_out/Shop_Lay_Out.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_state.dart';
import 'package:shopapp/modules/login_screen/login_screen.dart';
import 'package:shopapp/modules/search/cubit/cubitSearch.dart';
import 'package:shopapp/modules/splash.dart';
import 'package:shopapp/network/cash_helper.dart';
import 'package:shopapp/network/dio_helper.dart';
import 'package:shopapp/style/colors/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;
  bool? onBoarding = CashHelper.getDate(key: 'OnBoardingScreen');
  token = CashHelper.getDate(key: 'token');
  /*if(token == null) {
    token = 'eSEYSfNtklBFL7ULeVljUMZPgtqgOwggNCvEkJv6gW6yLfleVe8b57YnA1AcSQQLijnZ8T';
  }*/
  print(token);
  bool? isLightMode = CashHelper.getDate(key: 'isLightMode');
  print('................. $isLightMode');
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayOut();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(widget, isLightMode));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget widget;

  final bool? modeApp;

  MyApp(this.widget, this.modeApp);

  @override
  Widget build(BuildContext context) {
    print('aaaaaaaaaaaaaa $modeApp');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..getDataHome()
            ..getDataCategories()
            ..changeAppMode(fromShared: modeApp),
        ),
        BlocProvider(
          create: (BuildContext context) => SearchCubit(),
        )
      ],
      child: BlocConsumer<HomeCubit, HomeMainState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            print('zzzzzzzzzzzzzzz $modeApp');
            return MaterialApp(
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    backwardsCompatibility: false,
                    backgroundColor: Colors.white24,
                    elevation: 0.0,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white24,
                        statusBarIconBrightness: Brightness.dark),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    ),
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  selectedItemColor: defaultColor,
                ),
                backgroundColor: Colors.white24,
                iconTheme: const IconThemeData(
                  color: defaultColor,
                ),
                //primaryColor: Colors.white24
              ),
              darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('15202B'),
                appBarTheme: AppBarTheme(
                  color: HexColor('15202B'),
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('15202B'),
                      statusBarIconBrightness: Brightness.light),
                  titleTextStyle: TextStyle(
                    color: HexColor('FFFFFF'),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  iconTheme: IconThemeData(
                    color: HexColor('FFFFFF'),
                  ),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor('15202B'),
                  elevation: 0.0,
                  selectedItemColor: defaultColor,
                  unselectedItemColor: HexColor('FFFFFF'),
                ),
                backgroundColor: Colors.white24,
                iconTheme: const IconThemeData(
                  color: defaultColor,
                ),
                textTheme: TextTheme(
                  bodyText2: TextStyle(
                    color: HexColor('FFFFFF'),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: TextStyle(
                    color: HexColor('FFFFFF'),
                  ),
                  iconColor: HexColor('FFFFFF'),
                  fillColor: Colors.blueGrey[900],
                  filled: true,
                ),
              ),
              debugShowCheckedModeBanner: false,
              home: SplashScreen(widget: widget),
              themeMode: HomeCubit.get(context).isLightMode != false
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
          }),
    );
  }
}
