import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:only_for_me/app.dart';
import 'package:only_for_me/service/hive_setting_box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('questionsBox');
  await SettingBox.init();
  bool isIntroShown = SettingBox.getData();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    )
  );


  runApp(
    MyApp(
      isIntroShown: isIntroShown,
    ),
  );
}
