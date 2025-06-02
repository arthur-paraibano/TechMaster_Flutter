import 'package:flutter/material.dart';

class Dialog extends StatelessWidget {
  final String? title;
  final String? message;
  const Dialog(this.title, this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:
          () => showDialog<String>(
            context: context,
            builder:
                (BuildContext context) => AlertDialog(
                  title:
                      title.toString() == 'null'
                          ? null
                          : Text(title.toString()),
                  content:
                      message.toString() == 'null'
                          ? null
                          : Text(message.toString()),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancelar'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          ),
      child: const Text('Show Dialog'),
    );
  }
}
