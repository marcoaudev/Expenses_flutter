import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final dynamic value;
  final double percentage;

  const ChartBar(
      {super.key,
      required this.label,
      required this.value,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
      return Column(
        children: [
          SizedBox(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text('${value.toStringAsFixed(2)}'))),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.60,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(8)),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label)),
          )
        ],
      );
    });
  }
}
