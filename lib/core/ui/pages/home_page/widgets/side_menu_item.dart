import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final int itemCount;
  final String title;
  final IconData icon;
  final VoidCallback press;

  const SideMenuItem({
    super.key,
    required this.itemCount,
    required this.title,
    required this.icon,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: press,
        child: Row(
          children: [
            Icon(
              icon,
              // size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            if (itemCount != 0)
              Text(
                itemCount.toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }
}
