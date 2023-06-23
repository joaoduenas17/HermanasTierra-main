import 'package:flutter/material.dart';

class MenuProviders extends ChangeNotifier {
  int itemselect = 0;
  setselect(int i) {
    itemselect = i;
    notifyListeners();
  }
}
