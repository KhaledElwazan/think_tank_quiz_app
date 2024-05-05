import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MultiChoiceItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  const MultiChoiceItem(
      {super.key, required this.isSelected, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected
                ? Theme.of(context).primaryColor
                : Theme.of(context).secondaryHeaderColor),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            if (isSelected)
              const FaIcon(
                FontAwesomeIcons.check,
                color: Colors.white,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
