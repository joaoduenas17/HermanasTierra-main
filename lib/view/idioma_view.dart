import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hdt_flutter/providers/idioma_providers.dart';
import 'package:hdt_flutter/utils/const.dart';
import 'package:provider/provider.dart';

class IdiomaView extends StatefulWidget {
  const IdiomaView({super.key});

  @override
  State<IdiomaView> createState() => _IdiomaViewState();
}

class _IdiomaViewState extends State<IdiomaView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final idioma = Provider.of<IdiomaProviders>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2),
        Text(AppLocalizations.of(context)!.selecionaidioma),
        const SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60, right: 60),
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(border: Border.all(color: tercero)),
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              value: idioma.idioma,
              isExpanded: true,
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                idioma.setIdioma(newValue!);
              },
              items: const [
                DropdownMenuItem<String>(
                  value: "es",
                  child: Text(
                    "Español",
                    style: TextStyle(
                      fontFamily: AutofillHints.creditCardGivenName,
                      // fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                DropdownMenuItem<String>(
                  value: "en",
                  child: Text("English"),
                ),
              ],
            ),
          ),
        ),
        const Spacer(flex: 2),
        FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 10,
          onPressed: () {
            context.go("/home");
          },
          child: const Icon(Icons.arrow_forward, color: Colors.black),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
