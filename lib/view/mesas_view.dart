import 'package:flutter/material.dart';
import 'package:hdt_flutter/models/restaurante_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hdt_flutter/widgets/app_bar.dart';

class MesasView extends StatelessWidget {
  const MesasView({super.key, required this.data});
  final RestauranteModels data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(context, AppLocalizations.of(context)!.mesasdisponibles),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(AppLocalizations.of(context)!.mesa),
              Text(AppLocalizations.of(context)!.cantpersonas),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.mesas.length,
              padding: const EdgeInsets.all(24),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: data.mesas[index].estado ? Colors.red[200] : Colors.green[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("#${index + 1}"),
                        Text(AppLocalizations.of(context)!.pers(data.mesas[index].canti)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
