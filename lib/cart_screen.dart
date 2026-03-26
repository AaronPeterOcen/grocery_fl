import 'package:flutter/material.dart';

const Color kGreen = Color(0xFF2ECC71);
const Color kDarkText = Color(0xFF2D3436);
const Color kGrey = Color(0xFF636E72);
const Color kLightGrey = Color(0xFFF5F5F5);
const Color kRed = Color(0xFFE74C3C);

class CartItem {
  final String name;
  final String subtitle;
  final double unitPrice;
  final String emoji;
  int qty;

  CartItem({
    required this.name,
    required this.subtitle,
    required this.unitPrice,
    required this.emoji,
    this.qty = 1,
  });

  double get total => unitPrice * qty;
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _items = [
    CartItem(name: 'Bell Pepper Red', subtitle: '1kg', unitPrice: 4.99, emoji: '🫑'),
    CartItem(name: 'Egg Chicken Red', subtitle: '4pcs', unitPrice: 1.99, emoji: '🥚'),
    CartItem(name: 'Organic Bananas', subtitle: '12kg', unitPrice: 3.00, emoji: '🍌'),
    CartItem(name: 'Ginger', subtitle: '250gm', unitPrice: 2.99, emoji: '🫚'),
  ];

  double get _subtotal => _items.fold(0, (sum, i) => sum + i.total);

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _items.isEmpty
                  ? _buildEmptyCart()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: _items.length,
                      separatorBuilder: (_, __) =>
                          Divider(color: Colors.grey.shade100, height: 1),
                      itemBuilder: (_, i) => _CartTile(
                        item: _items[i],
                        onRemove: () => _removeItem(i),
                        onQtyChanged: (qty) =>
                            setState(() => _items[i].qty = qty),
                      ),
                    ),
            ),
            if (_items.isNotEmpty) _buildCheckoutBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Center(
        child: Text('My Cart',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kDarkText)),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('🛒', style: TextStyle(fontSize: 64)),
          SizedBox(height: 16),
          Text('Your cart is empty',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kDarkText)),
          SizedBox(height: 6),
          Text('Add items to get started',
              style: TextStyle(fontSize: 14, color: kGrey)),
        ],
      ),
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: kGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Go to Checkout',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '\$${_subtotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQtyChanged;

  const _CartTile({
    required this.item,
    required this.onRemove,
    required this.onQtyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          // Product image
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: kLightGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(item.emoji, style: const TextStyle(fontSize: 38)),
            ),
          ),
          const SizedBox(width: 12),
          // Info + qty
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(item.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: kDarkText)),
                    ),
                    GestureDetector(
                      onTap: onRemove,
                      child: const Icon(Icons.close,
                          size: 18, color: kGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text('${item.subtitle}, Price',
                    style:
                        const TextStyle(fontSize: 13, color: kGrey)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _QtyBtn(
                          icon: Icons.remove,
                          color: Colors.transparent,
                          iconColor: kDarkText,
                          bordered: true,
                          onTap: () {
                            if (item.qty > 1) onQtyChanged(item.qty - 1);
                          },
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          child: Text('${item.qty}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkText)),
                        ),
                        _QtyBtn(
                          icon: Icons.add,
                          color: kGreen,
                          iconColor: Colors.white,
                          bordered: false,
                          onTap: () => onQtyChanged(item.qty + 1),
                        ),
                      ],
                    ),
                    Text(
                      '\$${item.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kDarkText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;
  final bool bordered;
  final VoidCallback onTap;

  const _QtyBtn({
    required this.icon,
    required this.color,
    required this.iconColor,
    required this.bordered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: bordered ? Border.all(color: Colors.grey.shade300) : null,
        ),
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }
}
