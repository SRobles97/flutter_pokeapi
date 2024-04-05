import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget {
  final Color color;
  final String type;
  final bool displayLarge;

  const TypeCard(
      {super.key,
      required this.type,
      required this.color,
      this.displayLarge = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          type,
          style: displayLarge
              ? Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  )
              : Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
