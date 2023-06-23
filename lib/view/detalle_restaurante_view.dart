import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hdt_flutter/models/restaurante_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hdt_flutter/widgets/app_bar.dart';
import 'package:hdt_flutter/widgets/card_detalles.dart';
import 'package:hdt_flutter/widgets/card_widget.dart';

class DetalleRestauranteView extends StatelessWidget {
  const DetalleRestauranteView({super.key, required this.data});
  final RestauranteModels data;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBars(context, data.nombre),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            CardDetallesWidget(
              height: 150,
              text: AppLocalizations.of(context)!.platosrecomendados,
              image: "assets/platos.png",
              onpre: () {
                context.push("/platosRecomendados", extra: data);
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CardWidget(
                    height: size.height * 0.35,
                    text: AppLocalizations.of(context)!.mesasdisponibles,
                    image: "assets/mesas disponibles.png",
                    onpre: () {
                      context.push("/Mesas", extra: data);
                    },
                    widthimage: 100,
                    heightimage: 0,
                    posicion: false,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: CardWidget(
                    height: size.height * 0.35,
                    text: "",
                    image: "assets/menu.png",
                    widthimage: 230,
                    heightimage: 123,
                    onpre: () {
                      context.push("/menu", extra: data);
                    },
                    posicion: true,
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
