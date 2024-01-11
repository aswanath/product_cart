import 'package:flutter/material.dart';

class QuantityModifier extends StatefulWidget {
  final int? quantity;
  final ValueChanged<int> onQuantityChanged;

  const QuantityModifier({
    super.key,
    this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<QuantityModifier> createState() => _QuantityModifierState();
}

class _QuantityModifierState extends State<QuantityModifier> {
  late int quantity;

  void _incrementCounter() {
    setState(() {
      quantity++;
    });
    widget.onQuantityChanged(quantity);
  }

  void _decrementCounter() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
    widget.onQuantityChanged(quantity);
  }

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity ?? 0;
  }

  @override
  void didUpdateWidget(covariant QuantityModifier oldWidget) {
    quantity = widget.quantity ?? quantity;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: quantity == 0 ? _incrementCounter : null,
      child: Container(
        width: size.width,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: quantity == 0
            ? const Text(
                "ADD",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementCounter,
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementCounter,
                  ),
                ],
              ),
      ),
    );
  }
}
