import 'package:flutter/material.dart';

const Color kGreen = Color(0xFF2ECC71);
const Color kDarkText = Color(0xFF2D3436);
const Color kGrey = Color(0xFF636E72);
const Color kLightGrey = Color(0xFFF5F5F5);

class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;

  const ProductDetailScreen({
    super.key,
    this.name = 'Naturel Red Apple',
    this.subtitle = '1kg, Price',
    this.price = '\$4.99',
    this.emoji = '🍎',
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _qty = 1;
  bool _isFavourite = false;
  bool _detailExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSection(context),
                    _buildInfoSection(),
                    _buildDivider(),
                    _buildDetailSection(),
                    _buildDivider(),
                    _buildNutritionRow(),
                    _buildDivider(),
                    _buildReviewRow(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildAddToBasket(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Container(
      height: 280,
      color: const Color(0xFFFAFAFA),
      child: Stack(
        children: [
          Center(
            child: Text(widget.emoji, style: const TextStyle(fontSize: 160)),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 16, color: kDarkText),
              ),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: const Icon(Icons.ios_share_outlined, size: 18, color: kDarkText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold, color: kDarkText)),
                    const SizedBox(height: 2),
                    Text(widget.subtitle,
                        style: const TextStyle(fontSize: 14, color: kGrey)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _isFavourite = !_isFavourite),
                child: Icon(
                  _isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavourite ? Colors.red : kGrey,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _QtyButton(
                icon: Icons.remove,
                onTap: () => setState(() => _qty = (_qty - 1).clamp(1, 99)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('$_qty',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: kDarkText)),
              ),
              _QtyButton(
                icon: Icons.add,
                onTap: () => setState(() => _qty++),
              ),
              const Spacer(),
              Text(
                widget.price,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: kDarkText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _detailExpanded = !_detailExpanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Product Detail',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, color: kDarkText)),
                Icon(
                  _detailExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: kGrey,
                ),
              ],
            ),
          ),
          if (_detailExpanded) ...[
            const SizedBox(height: 10),
            const Text(
              'Apples Are Nutritious. Apples May Be Good For Weight Loss. '
              'Apples May Be Good For Your Heart. As Part Of A Healthful And Varied Diet.',
              style: TextStyle(fontSize: 14, color: kGrey, height: 1.6),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNutritionRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Nutritions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kDarkText)),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: kLightGrey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('100gr',
                    style: TextStyle(fontSize: 12, color: kGrey)),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, size: 14, color: kGrey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Review',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kDarkText)),
          Row(
            children: [
              ...List.generate(
                  5,
                  (i) => const Icon(Icons.star, color: Colors.amber, size: 18)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, size: 14, color: kGrey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(color: Colors.grey.shade100, thickness: 1, height: 1);

  Widget _buildAddToBasket() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: kGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: const Text('Add To Basket',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: kDarkText),
      ),
    );
  }
}
