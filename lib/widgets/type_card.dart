import 'package:flutter/material.dart';

class TypeCard extends StatelessWidget {
  final Color color;
  final String type;
  final bool displayLarge;

  const TypeCard(
      {Key? key,
      required this.type,
      required this.color,
      this.displayLarge = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          type,
          style: displayLarge
              ? Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 28,
                  )
              : Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
