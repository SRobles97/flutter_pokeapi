import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget {
  final Color color;
  final String type;

  const TypeCard({Key? key, required this.type, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          type,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
