import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hdt_flutter/models/favorito_model.dart';
import 'package:hdt_flutter/models/menu_model.dart';
import 'package:hdt_flutter/models/restaurante_model.dart';
import 'package:hdt_flutter/providers/carrito_provider.dart';
import 'package:hdt_flutter/providers/data_providers.dart';
import 'package:hdt_flutter/service/notificacion_service.dart';
import 'package:hdt_flutter/utils/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show groupBy;
import 'package:hdt_flutter/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key, required this.data});
  final RestauranteModels data;
  @override
  Widget build(BuildContext context) {
    final groupedMenu = groupBy(data.menu, (MenuModels dish) => dish.categoria);
    final carrito = Provider.of<CarritoProviders>(context);
    final datos = Provider.of<DataProviders>(context);
    return Scaffold(
      appBar: appBars(context, AppLocalizations.of(context)!.menu),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: groupedMenu.length,
              itemBuilder: (context, index) {
                final category = groupedMenu.keys.toList()[index];
                final categoryDishes = groupedMenu[category]!;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        category,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      color: Colors.black12,
                      thickness: 1,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoryDishes.length,
                      itemBuilder: (context, index2) {
                        return Container(
                          decoration: BoxDecoration(color: carrito.selet == index2 && carrito.seletg == index ? Colors.grey.withOpacity(0.4) : null),
                          child: InkWell(
                            onTap: () {
                              carrito.setSelet(index, index2, 0);
                              NotificacionService.showSnackbarError("Selecione cantidad");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 8, top: 20),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  child: Text(
                                                    categoryDishes[index2].nombre,
                                                    overflow: TextOverflow.ellipsis,
                                                    softWrap: true,
                                                    style: const TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  categoryDishes[index2].precio,
                                                  style: const TextStyle(fontSize: 18),
                                                ),
                                                const SizedBox(height: 15),
                                                FittedBox(
                                                  child: TextButton(
                                                    onPressed: carrito.selet == index2 && carrito.seletg == index && carrito.cant != 0
                                                        ? () {
                                                            debugPrint("${carrito.cant * double.parse(categoryDishes[index2].precio)}");
                                                            final data1 = RestauranteModels(
                                                              id: data.id,
                                                              nombre: data.nombre,
                                                              descripcion: data.descripcion,
                                                              estado: data.estado,
                                                              imagen: data.imagen,
                                                              mesas: [],
                                                              menu: [
                                                                categoryDishes[index2],
                                                              ],
                                                            );
                                                            carrito.setaddCarrito(data1);
                                                            NotificacionService.showSnackbarError(AppLocalizations.of(context)!.agregarcarrito);
                                                            // Future.delayed(const Duration(seconds: 2), () {
                                                            //   context.push("/carrito");
                                                            // });
                                                          }
                                                        : () {
                                                            carrito.setSelet(index, index2, 0);
                                                            NotificacionService.showSnackbarError(AppLocalizations.of(context)!.select);
                                                          },
                                                    child: const Row(
                                                      children: [
                                                        Icon(Icons.add),
                                                        Text(
                                                          "Añadir al carrito ",
                                                          style: TextStyle(fontSize: 18),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            iconSize: 40, // Tamaño del icono
                                            icon: Icon(
                                              datos.comprobarfa(
                                                FavoritosModels(
                                                  idresta: data.id,
                                                  idmenu: categoryDishes[index2].id,
                                                ),
                                              )
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_outline,
                                              color: secundario,
                                            ),
                                            onPressed: datos.comprobarfa(
                                              FavoritosModels(
                                                idresta: data.id,
                                                idmenu: categoryDishes[index2].id,
                                              ),
                                            )
                                                ? () {
                                                    datos.remover(
                                                      "test/usuarios/favoritos/${data.id}/${categoryDishes[index2].id}",
                                                      idresta: data.id,
                                                      idmenu: categoryDishes[index2].id,
                                                    );
                                                  }
                                                : () {
                                                    // Acción al presionar el botón
                                                    datos.saveFavoritos(
                                                      "test/usuarios/favoritos/${data.id}/${categoryDishes[index2].id}",
                                                      data: FavoritosModels(
                                                        idresta: data.id,
                                                        idmenu: categoryDishes[index2].id,
                                                      ).toJson(),
                                                    );
                                                  },
                                          ),
                                          SizedBox(
                                            height: 110,
                                            width: 170,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: categoryDishes[index2].imagen,
                                                progressIndicatorBuilder: (context, url, downloadProgress) => Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Material(
                                                      color: Colors.transparent,
                                                      child: CircularProgressIndicator(
                                                        value: downloadProgress.progress,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                errorWidget: (context, url, error) {
                                                  return const Icon(Icons.error);
                                                },
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          categoryDishes[index2].ingredientes,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      carrito.selet == index2 && carrito.seletg == index
                                          ? FittedBox(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppLocalizations.of(context)!.cant(carrito.cant),
                                                    style: TextStyle(fontSize: 18, color: principal),
                                                  ),
                                                  Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all(0.0), // Eliminar todo el relleno
                                                        child: InkWell(
                                                          onTap: () {
                                                            // Acción a realizar cuando se toca el widget
                                                            carrito.setincreCant(1);
                                                          },
                                                          child: Icon(Icons.keyboard_arrow_up_outlined, color: principal),
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.all(0.0), // Eliminar todo el relleno
                                                        child: InkWell(
                                                          onTap: () {
                                                            // Acción a realizar cuando se toca el widget
                                                            carrito.setdecreCant(1);
                                                          },
                                                          child: Icon(Icons.keyboard_arrow_down_outlined, color: principal),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      const SizedBox(height: 20),
                                      const Divider(
                                        color: Colors.black12,
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
