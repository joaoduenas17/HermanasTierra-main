// To parse this JSON data, do
//
//     final menuModels = menuModelsFromJson(jsonString);

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

MenuModels menuModelsFromJson(String str) => MenuModels.fromJson(json.decode(str));

String menuModelsToJson(MenuModels data) => json.encode(data.toJson());

class MenuModels {
  String id;
  String nombre;
  String descripcion;
  bool estado;
  String imagen;
  String categoria;
  String precio;
  String ingredientes;
  bool recomendado;

  MenuModels({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.imagen,
    required this.recomendado,
    required this.ingredientes,
    required this.categoria,
    required this.precio,
  });

  factory MenuModels.fromJson(Map<String, dynamic> json) => MenuModels(
        id: json["id"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
        estado: json["estado"],
        imagen: json["imagen"],
        recomendado: json["recomendado"],
        ingredientes: json["ingredientes"],
        categoria: json["categoria"],
        precio: json["precio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "descripcion": descripcion,
        "estado": estado,
        "imagen": imagen,
        "recomendado": recomendado,
        "ingredientes": ingredientes,
        "categoria": categoria,
        "precio": precio,
      };
  MenuModels.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key!,
        nombre = snapshot.child("nombre").value.toString(),
        descripcion = snapshot.child("descripcion").value.toString(),
        estado = snapshot.child("estado").value as bool,
        imagen = snapshot.child("imagen").value.toString(),
        recomendado = snapshot.child("recomendado").value as bool,
        categoria = snapshot.child("categoria").value.toString(),
        ingredientes = snapshot.child("ingredientes").value.toString(),
        precio = snapshot.child("precio").value.toString();
}
