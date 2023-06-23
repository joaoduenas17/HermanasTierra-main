import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:hdt_flutter/models/menu_model.dart';
import 'package:hdt_flutter/models/mesa_model.dart';

RestauranteModels restauranteModelsFromJson(String str) => RestauranteModels.fromJson(json.decode(str));

String restauranteModelsToJson(RestauranteModels data) => json.encode(data.toJson());

class RestauranteModels {
  String id;
  String nombre;
  String descripcion;
  bool estado;
  String imagen;
  List<MesasModels> mesas;
  List<MenuModels> menu;

  RestauranteModels({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.imagen,
    required this.mesas,
    required this.menu,
  });

  factory RestauranteModels.fromJson(Map<String, dynamic> json) => RestauranteModels(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        imagen: json["imagen"],
        mesas: List<MesasModels>.from(json["mesas"].map((x) => x.to)),
        menu: List<MenuModels>.from(json["menu"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "imagen": imagen,
        "mesas": mesas.asMap().map((i, x) => MapEntry("Mesa$i", x.toJson())),
        "menu": menu.asMap().map((i, x) => MapEntry("Menu$i", x.toJson())),
      };

  RestauranteModels.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key!,
        nombre = snapshot.child("nombre").value.toString(),
        descripcion = snapshot.child("descripcion").value.toString(),
        estado = snapshot.child("estado").value as bool,
        imagen = snapshot.child("imagen").value.toString(),
        mesas = _parseMesas(snapshot.child("mesas")),
        menu = _parseMenu(snapshot.child("menu"));

  static List<MesasModels> _parseMesas(DataSnapshot snapshot) {
    List<MesasModels> mesas = [];
    for (var element in snapshot.children) {
      final todo = MesasModels.fromSnapshot(element);
      mesas.add(todo);
    }

    return mesas;
  }

  static List<MenuModels> _parseMenu(DataSnapshot snapshot) {
    List<MenuModels> menu = [];
    for (var element in snapshot.children) {
      final todo = MenuModels.fromSnapshot(element);
      menu.add(todo);
    }
    return menu;
  }
}
