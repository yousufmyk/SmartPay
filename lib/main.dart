import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:mobile_banking/screen/WAHomeScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mobile_banking/screen/WASplashScreen.dart';
import 'package:mobile_banking/store/AppStore.dart';
import 'package:mobile_banking/utils/AppTheme.dart';
import 'package:mobile_banking/utils/WAConstants.dart';
import 'package:mobile_banking/utils/WADataGenerator.dart';
import 'package:showcaseview/showcaseview.dart';

import 'model/cardDetailsModel.dart';

AppStore appStore = AppStore();

void main() async {         
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token = SessionManager().get("token");
  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync(isDarkModeOnPref));

  defaultToastGravityGlobal = ToastGravity.BOTTOM;


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OMA Pay${!isMobile ? ' ${platformName()}' : ''}',
        home: ShowCaseWidget(
          builder: Builder(builder: (_) => WASplashScreen()),
           ),
         theme: !appStore.isDarkModeOn ? ThemeData(useMaterial3: true) : AppThemeData.darkTheme,
        // theme: ThemeData(
        //   useMaterial3: true,
        // ),

        navigatorKey: navigatorKey,
        scrollBehavior: SBehavior(),
        supportedLocales: LanguageDataModel.languageLocales(),
        localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
