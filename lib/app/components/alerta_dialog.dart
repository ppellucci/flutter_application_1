import 'package:flutter/material.dart';

class AlertaDialog extends StatelessWidget {
final String text;
final String buttonText;
final Function onPressed;

  const AlertaDialog({Key key, this.text, this.buttonText, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(this.text),
      actions: [
        FlatButton(
            child: Text(this.buttonText),
            onPressed: () {
              this.onPressed();
            })
      ],
    );
  }
}
