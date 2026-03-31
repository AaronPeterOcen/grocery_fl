import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;

  const ProductCard({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.emoji,
    super.key,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _qty = 0;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          name: widget.name,
          subtitle: '${widget.subtitle}, Price',
          price: widget.price,
          emoji: widget.emoji,
        ),
      ),
    ),
    child: Container(
      width: 155,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(widget.emoji, style: const TextStyle(fontSize: 52)),
          ),
          const SizedBox(height: 6),
          Text(
            widget.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF2D3436),
            ),
          ),
          Text(
            widget.subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF636E72)),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
              _qty == 0
                  ? AddButton(onTap: () => setState(() => _qty++))
                  : QtyControl(
                      qty: _qty,
                      onIncrement: () => setState(() => _qty++),
                      onDecrement: () =>
                          setState(() => _qty = (_qty - 1).clamp(0, 99)),
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

class AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddButton({required this.onTap, super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFF2ECC71),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 20),
    ),
  );
}

class QtyControl extends StatelessWidget {
  final int qty;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QtyControl({
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      GestureDetector(
        onTap: onDecrement,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: const Color(0xFFF0FBF5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF2ECC71)),
          ),
          child: const Icon(Icons.remove, size: 14, color: Color(0xFF2ECC71)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text(
          '$qty',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
      GestureDetector(
        onTap: onIncrement,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: const Color(0xFF2ECC71),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add, size: 14, color: Colors.white),
        ),
      ),
    ],
  );
}
