import 'package:flutter/material.dart';
import 'package:hdt_flutter/models/restaurante_model.dart';

class CarritoProviders extends ChangeNotifier {
  int selet = -1;
  int seletg = -1;

  int cant = 0;
  List<RestauranteModels> todoCarrito = [];
  setSelet(int i, int j, int k) {
    seletg = i;
    selet = j;
    cant = k;
    notifyListeners();
  }

  setincreCant(int i) {
    cant = cant + i;
    notifyListeners();
  }

  setdecreCant(int i) {
    if (cant != 0) {
      cant = cant - i;
    }
    notifyListeners();
  }

  setaddCarrito(RestauranteModels data1) {
    todoCarrito.add(data1);
    notifyListeners();
  }
}
