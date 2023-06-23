import 'package:flutter/material.dart';
import 'package:hdt_flutter/models/restaurante_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hdt_flutter/widgets/app_bar.dart';
import 'package:hdt_flutter/widgets/card_platos.dart';

class PlatosRecomendadosView extends StatelessWidget {
  const PlatosRecomendadosView({super.key, required this.data});
  final RestauranteModels data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(context, AppLocalizations.of(context)!.platosrecomendados),
      body: ListView.builder(
        itemCount: data.menu.length,
        itemBuilder: (context, index) {
          if (data.menu[index].recomendado) {
            return CardPlatos(
              height: 200,
              menu: data.menu[index],
              onTap: () {},
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
