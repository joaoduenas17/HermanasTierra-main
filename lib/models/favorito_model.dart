// To parse this JSON data, do
//
//     final favoritosModels = favoritosModelsFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

FavoritosModels favoritosModelsFromJson(String str) => FavoritosModels.fromJson(json.decode(str));

String favoritosModelsToJson(FavoritosModels data) => json.encode(data.toJson());

class FavoritosModels {
  String idresta;
  String idmenu;

  FavoritosModels({
    required this.idresta,
    required this.idmenu,
  });

  factory FavoritosModels.fromJson(Map<String, dynamic> json) => FavoritosModels(
        idresta: json["idresta"],
        idmenu: json["idmenu"],
      );

  Map<String, dynamic> toJson() => {
        "idresta": idresta,
        "idmenu": idmenu,
      };
  FavoritosModels.fromSnapshot(DataSnapshot snapshot)
      : idresta = snapshot.child("idresta").value.toString(),
        idmenu = snapshot.child("idmenu").value.toString();
}
