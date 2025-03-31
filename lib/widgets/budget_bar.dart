import 'package:flutter/material.dart';

class BudgetBar extends StatelessWidget {
  final double progress; 
  final double total;
  final double limit;
  final VoidCallback onEdit;

  const BudgetBar({
    super.key,
    required this.progress,
    required this.total,
    required this.limit,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final overAmount = total > limit ? total - limit : 0.0;
    final mainBarWidth = MediaQuery.of(context).size.width - 32; 

    final redBarWidth = (progress <= 1.0 ? progress : 1.0) * mainBarWidth;
    final blueBarWidth = overAmount > 0 ? (overAmount / limit) * mainBarWidth : 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Row(
        children: [
          Text(
            "Budget Usage: \$${total.toStringAsFixed(2)} / \$${limit.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onEdit,
              child: const Icon(Icons.edit, size: 18),
            ),
          ),
        ],
      ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Container(
              height: 16,
              width: mainBarWidth,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              height: 16,
              width: redBarWidth,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            if (overAmount > 0)
              Positioned(
                left: redBarWidth,
                child: Container(
                  height: 16,
                  width: blueBarWidth.toDouble(),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
          ],
        )
      ],
    );
  }
}
