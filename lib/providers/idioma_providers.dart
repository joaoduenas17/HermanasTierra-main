import 'package:flutter/material.dart';
import 'package:hdt_flutter/helpers/shared_preference_helper.dart';

class IdiomaProviders extends ChangeNotifier {
  late String idioma;
  IdiomaProviders() {
    getidioma();
    debugPrint(idioma);
  }
  setIdioma(String id) {
    idioma = id;
    SharedPreferenceHelper.setString("idioma", id);
    notifyListeners();
  }

  getidioma() {
    if (SharedPreferenceHelper.getString("idioma") == 'N/A') {
      idioma = 'es';
      SharedPreferenceHelper.setString("idioma", 'es');
    } else {
      idioma = SharedPreferenceHelper.getString("idioma");
    }
    notifyListeners();
  }
}
