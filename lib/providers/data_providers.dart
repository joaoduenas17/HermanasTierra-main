import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hdt_flutter/helpers/shared_preference_helper.dart';
import 'package:hdt_flutter/models/favorito_model.dart';
import 'package:hdt_flutter/models/restaurante_model.dart';

class DataProviders extends ChangeNotifier {
  DatabaseReference database = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> enveAdd;
  late StreamSubscription<DatabaseEvent> enveRemove;
  final List<RestauranteModels> resta = [];
  final List<FavoritosModels> favorites = [];
  bool loandig = true;
  DataProviders() {
    initData();
  }
  initData() {
    String idioma = SharedPreferenceHelper.getString("idioma");
    enveAdd = database.child("Datos/restaurantes/$idioma").onChildAdded.listen((event) {
      final todoresta = RestauranteModels.fromSnapshot(event.snapshot);
      resta.add(todoresta);
      loandig = false;
      notifyListeners();
    }, onError: (Object error) {
      debugPrint("$error");
    });

    enveRemove = database.child("Datos/restaurantes/$idioma").onChildRemoved.listen((event) {
      resta.removeWhere((element) => element.id == RestauranteModels.fromSnapshot(event.snapshot).id);
      loandig = false;
      notifyListeners();
    }, onError: (Object error) {
      debugPrint("$error");
    });
    database.child("test/usuarios/favoritos").onChildAdded.listen((event) {
      for (var element in event.snapshot.children) {
        final favorit = FavoritosModels.fromSnapshot(element);
        favorites.add(favorit);
        debugPrint(":${favorit.toJson()}");
      }
      loandig = false;

      notifyListeners();
    });
    database.child("test/usuarios/favoritos").onChildChanged.listen((event) {
      for (var element in event.snapshot.children) {
        final favorit = FavoritosModels.fromSnapshot(element);
        favorites.add(favorit);
      }
      loandig = false;
      debugPrint(":${favorites.length}");
      notifyListeners();
    });

    debugPrint(idioma);
    notifyListeners();
  }

  comprobarfa(FavoritosModels element) {
    bool itemExists = favorites.any((item) => item.idresta == element.idresta && item.idmenu == element.idmenu);
    return itemExists;
  }

  remover(String path, {required String idresta, required String idmenu}) {
    database.child(path).remove();
    favorites.removeWhere((element) => element.idresta == idresta && element.idmenu == idmenu);
    notifyListeners();
  }

  saveFavoritos(String path, {required Map<String, dynamic> data}) async {
    await database.child(path).set(data).whenComplete(() => debugPrint("bien ${data['idmenu']}"));
  }
}
