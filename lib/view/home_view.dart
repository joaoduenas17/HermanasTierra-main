import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hdt_flutter/widgets/card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CardWidget(
            height: 150,
            text: AppLocalizations.of(context)!.restaurante,
            image: "assets/mesarestaurante.png",
            widthimage: 100,
            heightimage: 100,
            onpre: () {
              context.goNamed("restaurante");
            },
          ),
          const SizedBox(height: 16),
          CardWidget(
            height: 150,
            image: "assets/myorden.png",
            widthimage: 100,
            heightimage: 100,
            text: AppLocalizations.of(context)!.miorden,
            onpre: () {},
          ),
        ],
      ),
    );
  }
}
