import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:hdt_flutter/helpers/shared_preference_helper.dart';
import 'package:hdt_flutter/models/menu_model.dart';
import 'package:hdt_flutter/models/mesa_model.dart';
import 'package:hdt_flutter/models/restaurante_model.dart';
import 'package:hdt_flutter/providers/data_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hdt_flutter/widgets/app_bar.dart';
import 'package:hdt_flutter/widgets/card_restaurantes.dart';
import 'package:provider/provider.dart';

class RestaurantesView extends StatelessWidget {
  const RestaurantesView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProviders>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBars(context, AppLocalizations.of(context)!.restaurante),
      body: data.loandig
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  data.resta.isEmpty
                      ? SizedBox(
                          width: size.width,
                          height: size.height * 0.50,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(AppLocalizations.of(context)!.nodatos),
                              ],
                            ),
                          ),
                        )
                      : CardRestaurantes(
                          restaurante: data.resta[0],
                          height: 175,
                          onTap: () {
                            context.push("/detalleRestaurante", extra: data.resta[0]);
                          },
                        ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: data.resta.isEmpty ? 0 : (data.resta.length ~/ 2) * 185,
                    child: GridView.builder(
                      itemCount: data.resta.isEmpty ? 0 : data.resta.length - 1,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Número de columnas en la cuadrícula
                        mainAxisSpacing: 5.0, // Espacio vertical entre los elementos
                        crossAxisSpacing: 5.0, // Espacio horizontal entre los elementos
                        childAspectRatio: 1.1,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        int i = index + 1;
                        return CardRestaurantes(
                          restaurante: data.resta[i],
                          onTap: () {
                            context.push("/detalleRestaurante", extra: data.resta[i]);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

save() {
  // int ranCant = Random().nextInt(100);
  // for (var i = 0; i < ranCant; i++) {
  List<String> nomRestaurantesES = [
    "El Sazón Portovejense",
    "La Parrilla Manabita",
    "Sabores de la Costa",
    "Cevichería El Puerto",
    "Mariscos y Pescados Portoviejo",
    "Restaurante El Encanto",
    "Cocina Manabita",
    "El Rincón del Sabor",
    "La Taberna del Sur",
    "El Coral Portovejense",
    "Picantería Manabita",
    "La Casa del Buen Comer",
    "Sabores Manabitas",
    "Restaurante El Oasis",
    "El Patio de los Sabores",
    "Cevichería El Manglar",
    "Marisquería El Puerto",
    "Restaurante La Canoa",
    "El Sabor de la Costa",
    "Café del Mar",
    "El Ceviche Feliz",
    "Restaurante El Pargo",
    "Sabores del Mar",
    "Mariscos La Perla",
    "La Casona Manabita",
    "Restaurante El Bucanero"
  ];
  List<String> nomRestaurantesEN = [
    "Portoviejo's Flavor",
    "Manabita Grill",
    "Coastal Flavors",
    "The Port Seafood",
    "Portoviejo's Fish and Chips",
    "The Enchanting Restaurant",
    "Manabita Cuisine",
    "The Taste Corner",
    "The Southern Tavern",
    "Portoviejo's Coral",
    "Manabita Delights",
    "The House of Good Eating",
    "Manabí Flavors",
    "The Oasis Restaurant",
    "The Flavor Patio",
    "Mangrove Ceviche",
    "The Port Seafood",
    "La Canoa Restaurant",
    "Taste of the Coast",
    "Café by the Sea",
    "The Happy Ceviche",
    "Red Snapper Restaurant",
    "Flavors of the Sea",
    "Pearl Seafood",
    "The Manabita Mansion",
    "The Buccaneer Restaurant"
  ];

  List<Map<String, dynamic>> dishes = [
    {"name_en": "Shrimp ceviche", "category_en": "Seafood", "name_es": "Ceviche de camarón", "category_es": "Mariscos", "price": 10.99},
    {"name_en": "Mixed grill", "category_en": "Meat", "name_es": "Parrillada mixta", "category_es": "Carne", "price": 18.99},
    {"name_en": "Seafood rice", "category_en": "Rice", "name_es": "Arroz marinero", "category_es": "Arroz", "price": 12.99},
    {"name_en": "Garlic langostinos", "category_en": "Seafood", "name_es": "Langostinos al ajillo", "category_es": "Mariscos", "price": 14.99},
    {"name_en": "Grilled corvina", "category_en": "Fish", "name_es": "Corvina a la plancha", "category_es": "Pescado", "price": 16.99},
    {"name_en": "Encebollado soup", "category_en": "Soup", "name_es": "Encebollado", "category_es": "Sopa", "price": 8.99},
    {"name_en": "Green plantain ball", "category_en": "Appetizer", "name_es": "Bolón de verde", "category_es": "Aperitivo", "price": 5.99},
    {"name_en": "Coconut fish stew", "category_en": "Seafood", "name_es": "Encocado de pescado", "category_es": "Mariscos", "price": 13.99},
    {"name_en": "Crab feast", "category_en": "Seafood", "name_es": "Cangrejada", "category_es": "Mariscos", "price": 19.99},
    {"name_en": "Fish sango soup", "category_en": "Soup", "name_es": "Sango de pescado", "category_es": "Sopa", "price": 9.99},
    {"name_en": "Plantain chips and green plantain", "category_en": "Appetizer", "name_es": "Chifles y patacones", "category_es": "Aperitivo", "price": 6.99},
    {"name_en": "Fried fish", "category_en": "Fish", "name_es": "Pescado frito", "category_es": "Pescado", "price": 11.99},
    {"name_en": "Rice with shells", "category_en": "Rice", "name_es": "Arroz con conchas", "category_es": "Arroz", "price": 10.99},
    {"name_en": "Tripe soup", "category_en": "Soup", "name_es": "Caldo de manguera", "category_es": "Sopa", "price": 7.99},
    {"name_en": "Coconut breaded shrimp", "category_en": "Seafood", "name_es": "Camarones al coco", "category_es": "Mariscos", "price": 15.99},
    {"name_en": "Seafood casserole", "category_en": "Seafood", "name_es": "Cazuela de mariscos", "category_es": "Mariscos", "price": 17.99},
    {"name_en": "Grilled lobster", "category_en": "Seafood", "name_es": "Langosta a la parrilla", "category_es": "Mariscos", "price": 25.99},
    {"name_en": "Mixed ceviche", "category_en": "Seafood", "name_es": "Ceviche mixto", "category_es": "Mariscos", "price": 13.99},
    {"name_en": "Rice with stewed beans", "category_en": "Rice", "name_es": "Arroz con menestra", "category_es": "Arroz", "price": 10.99},
    {"name_en": "Fish dumplings", "category_en": "Appetizer", "name_es": "Bollos de pescado", "category_es": "Aperitivo", "price": 6.99},
    {"name_en": "Seafood soup", "category_en": "Soup", "name_es": "Sopa marinera", "category_es": "Sopa", "price": 9.99},
    {"name_en": "Plantain chips with hogao", "category_en": "Appetizer", "name_es": "Patacones con hogao", "category_es": "Aperitivo", "price": 6.99},
    {"name_en": "Garlic fish fillet", "category_en": "Fish", "name_es": "Filete de pescado al ajillo", "category_es": "Pescado", "price": 14.99},
    {"name_en": "Corviches", "category_en": "Appetizer", "name_es": "Corviches", "category_es": "Aperitivo", "price": 5.99},
    {"name_en": "Breaded shrimp", "category_en": "Seafood", "name_es": "Camarones apanados", "category_es": "Mariscos", "price": 12.99},
    {"name_en": "Garlic langostinos", "category_en": "Seafood", "name_es": "Langostinos al ajillo", "category_es": "Mariscos", "price": 14.99},
    {"name_en": "Meat grill", "category_en": "Meat", "name_es": "Parrillada de carne", "category_es": "Carne", "price": 18.99},
    {"name_en": "Rice with shells", "category_en": "Rice", "name_es": "Arroz con conchas", "category_es": "Arroz", "price": 10.99},
    {"name_en": "Encebollado soup", "category_en": "Soup", "name_es": "Encebollado", "category_es": "Sopa", "price": 8.99},
    {"name_en": "Grilled corvina", "category_en": "Fish", "name_es": "Corvina a la plancha", "category_es": "Pescado", "price": 16.99},
    {"name_en": "Seafood casserole", "category_en": "Seafood", "name_es": "Cazuela de mariscos", "category_es": "Mariscos", "price": 17.99},
    {"name_en": "Green plantain ball", "category_en": "Appetizer", "name_es": "Bolón de verde", "category_es": "Aperitivo", "price": 5.99},
    {"name_en": "Coconut fish stew", "category_en": "Seafood", "name_es": "Encocado de pescado", "category_es": "Mariscos", "price": 13.99},
    {"name_en": "Crab feast", "category_en": "Seafood", "name_es": "Cangrejada", "category_es": "Mariscos", "price": 19.99},
    {"name_en": "Seafood rice", "category_en": "Rice", "name_es": "Arroz marinero", "category_es": "Arroz", "price": 12.99},
    {"name_en": "Plantain chips and green plantain", "category_en": "Appetizer", "name_es": "Chifles y patacones", "category_es": "Aperitivo", "price": 6.99},
    {"name_en": "Fried fish", "category_en": "Fish", "name_es": "Pescado frito", "category_es": "Pescado", "price": 11.99},
    {"name_en": "Rice with stewed beans", "category_en": "Rice", "name_es": "Arroz con menestra", "category_es": "Arroz", "price": 10.99},
    {"name_en": "Tripe soup", "category_en": "Soup", "name_es": "Caldo de manguera", "category_es": "Sopa", "price": 7.99},
    {"name_en": "Coconut breaded shrimp", "category_en": "Seafood", "name_es": "Camarones al coco", "category_es": "Mariscos", "price": 15.99},
    {"name_en": "Fish sango soup", "category_en": "Soup", "name_es": "Sango de pescado", "category_es": "Sopa", "price": 9.99},
    {"name_en": "Mixed ceviche", "category_en": "Seafood", "name_es": "Ceviche mixto", "category_es": "Mariscos", "price": 13.99},
    {"name_en": "Grilled lobster", "category_en": "Seafood", "name_es": "Langosta a la parrilla", "category_es": "Mariscos", "price": 25.99},
    {"name_en": "Fish dumplings", "category_en": "Appetizer", "name_es": "Bollos de pescado", "category_es": "Aperitivo", "price": 6.99},
    {"name_en": "Seafood soup", "category_en": "Soup", "name_es": "Sopa marinera", "category_es": "Sopa", "price": 9.99},
    {"name_en": "Plantain chips with hogao", "category_en": "Appetizer", "name_es": "Patacones con hogao", "category_es": "Aperitivo", "price": 6.99},
    {"name_en": "Garlic fish fillet", "category_en": "Fish", "name_es": "Filete de pescado al ajillo", "category_es": "Pescado", "price": 14.99},
    {"name_en": "Corviches", "category_en": "Appetizer", "name_es": "Corviches", "category_es": "Aperitivo", "price": 5.99},
    {"name_en": "Breaded shrimp", "category_en": "Seafood", "name_es": "Camarones apanados", "category_es": "Mariscos", "price": 12.99},
  ];

  for (var i = 0; i < nomRestaurantesES.length; i++) {
    int id = DateTime.now().millisecondsSinceEpoch;
    int ranMenu = Random().nextInt(dishes.length);
    int ranMesa = Random().nextInt(10);
    final RestauranteModels es = RestauranteModels(
      id: "$id",
      nombre: nomRestaurantesES[i],
      descripcion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur felis ante, placerat id blandit vitae, dapibus id mi. Nam lacus magna, aliquam ut mattis ut, porttitor sed quam. Vivamus erat.",
      estado: true,
      imagen: 'https://via.placeholder.com/640x480.png/a59090/000000?Text=640x480',
      mesas: List.generate(
        ranMesa,
        (index) {
          int ranCant = Random().nextInt(10);
          bool sss = Random().nextBool();
          return MesasModels(
            id: "id$index",
            nombre: "Mesa $index",
            estado: sss,
            imagen: 'https://via.placeholder.com/640x480.png/a59090/000000?Text=640x480',
            canti: ranCant,
          );
        },
      ),
      menu: List.generate(
        ranMenu,
        (indexm) {
          return MenuModels(
            id: "id$indexm",
            nombre: dishes[indexm]['name_es']!,
            descripcion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur felis ante, placerat id blandit vitae, dapibus id mi. Nam lacus magna, aliquam ut mattis ut, porttitor sed quam. Vivamus erat.",
            estado: Random().nextBool(),
            imagen: 'https://via.placeholder.com/640x480.png/a59090/000000?Text=640x480',
            recomendado: Random().nextBool(),
            categoria: dishes[indexm]['category_es']!,
            ingredientes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur felis ante, placerat id blandit vitae, dapibus id mi. Nam lacus magna, aliquam ut mattis ut, porttitor sed quam. Vivamus erat.",
            precio: "${dishes[indexm]['price']}",
          );
        },
      ),
    );

    final RestauranteModels en = RestauranteModels(
      id: "$id",
      nombre: nomRestaurantesEN[i],
      descripcion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur felis ante, placerat id blandit vitae, dapibus id mi. Nam lacus magna, aliquam ut mattis ut, porttitor sed quam. Vivamus erat.",
      estado: true,
      imagen: 'https://via.placeholder.com/640x480.png/a59090/000000?Text=640x480',
      mesas: List.generate(
        ranMesa,
        (index) {
          int ranCant = Random().nextInt(10);
          bool sss = Random().nextBool();
          return MesasModels(
            id: "id$index",
            nombre: "Mesa $index",
            estado: sss,
            imagen: 'https://via.placeholder.com/640x480.png/a59090/000000?Text=640x480',
            canti: ranCant,
          );
        },
      ),
      menu: List.generate(
        ranMenu,
        (indexm) => MenuModels(
          id: "id$indexm",
          nombre: dishes[indexm]['name_en']!,
          descripcion: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur felis ante, placerat id blandit vitae, dapibus id mi. Nam lacus magna, aliquam ut mattis ut, porttitor sed quam. Vivamus erat.",
          estado: Random().nextBool(),
          imagen: 'https://via.placeholder.com/640x480.png/a59090/000000?Text=640x480',
          recomendado: Random().nextBool(),
          categoria: dishes[indexm]['category_en']!,
          ingredientes: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur felis ante, placerat id blandit vitae, dapibus id mi. Nam lacus magna, aliquam ut mattis ut, porttitor sed quam. Vivamus erat.",
          precio: "${dishes[indexm]['price']}",
        ),
      ),
    );
    FirebaseDatabase.instance.ref().child("Datos/restaurantes/es/$id").set(es.toJson()).whenComplete(() {
      debugPrint("bien es");

      FirebaseDatabase.instance.ref().child("Datos/restaurantes/en/$id").set(en.toJson()).whenComplete(() {
        debugPrint("bien en");
      }).onError((error, stackTrace) {
        debugPrint("Error: $error");
      });
    }).onError((error, stackTrace) {
      debugPrint("Error: $error");
    });
  }
}
