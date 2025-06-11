import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../features/auth/domain/modules/linkes/link.dart';
import '../features/auth/domain/modules/org/org_admin.dart';
import '../features/auth/domain/modules/seeker/seeker.dart';
import '../features/auth/domain/modules/user/user.dart';
import '../utils/data_shared/app_shared_data.dart';
import '../utils/data_shared/data_const.dart';

abstract class AppProvider {
  static late Box appBox;
  static Future<void> configApp() async {
    await Hive.initFlutter();
    Future.wait([loadCountryCityData(), loadNationalities()]);
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(SeekerAdapter());
    Hive.registerAdapter(OrgAdminAdapter());
    Hive.registerAdapter(UserLinkAdapter());
    appBox = await Hive.openBox(CashingData.appBox);
    AppSharedData.user = appBox.get(CashingData.user);
  }

  static Future<void> loadCountryCityData() async {
    String jsonString = await rootBundle.loadString(
      'assets/country_city/country_city.json',
    );
    Map<String, dynamic> raw = jsonDecode(jsonString);

    AppSharedData.countryCityData.addAll(
      raw.map((key, value) => MapEntry(key, List<String>.from(value))),
    );
  }

  static Future<void> loadNationalities() async {
    String jsonString = await rootBundle.loadString(
      'assets/country_city/nationalities.json',
    );
    Map<String, dynamic> raw = jsonDecode(jsonString);
    AppSharedData.nationalities =
        List<String>.from(raw['nationalities']).cast<String>();
  }
}
