import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(this.choiceText, this.onPress, {Key? key}) : super(key: key);

  final VoidCallback onPress;
  final String choiceText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        choiceText,
        style: const TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(25),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.green,
        elevation: 10,
        backgroundColor: Colors.black54,
        foregroundColor: Colors.green[300],
      ),
    );
  }
}
