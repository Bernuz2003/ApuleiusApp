import 'package:flutter/material.dart';
import '../model/spesa.dart';

class DialogHelper {
  
  static void mostra_info_prodotto(BuildContext context, Spesa prodotto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dettagli Spesa'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text('Articolo: ${prodotto.articolo}'),
                Text('Fornitore: ${prodotto.fornitore ?? ''}'),
                Text('Timestamp: ${prodotto.timestamp ?? ''}'),
                Text('Termine: ${prodotto.termine ?? ''}'),
                Text('N. Lista: ${prodotto.n_lista ?? ''}'),
                Text('Selezione: ${prodotto.selezione ?? ''}'),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Chiudi'),
            ),
          ],
        );
      },
    );
  }
}