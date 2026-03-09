import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDropdown extends StatefulWidget {
  final List<String> items;
  final String hint;
  final Function(String?) onChanged;
  final String? value;

  const AppDropdown({
    super.key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.value,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1565C0), width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(widget.hint),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
          items: widget.items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onChanged(value);
          },
        ),
      ),
    );
  }
}