import 'package:flutter/material.dart';

void main() {
  runApp(const GroceryApp());
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh Grocery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2ECC71)),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const HomeScreen(),
    );
  }
}

// ─── Data Models ────────────────────────────────────────────────────────────

class Product {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;

  const Product({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.emoji,
  });
}

// ─── Home Screen ────────────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBannerIndex = 0;
  int _selectedNavIndex = 0;

  static const Color _green = Color(0xFF2ECC71);
  static const Color _darkGreen = Color(0xFF27AE60);

  final List<Product> _exclusiveOffers = const [
    Product(name: 'Organic Bananas', subtitle: '7pcs', price: '\$4.99', emoji: '🍌'),
    Product(name: 'Red Apple', subtitle: '1kg', price: '\$4.99', emoji: '🍎'),
    Product(name: 'Fresh Mango', subtitle: '500g', price: '\$3.49', emoji: '🥭'),
  ];

  final List<Product> _bestSelling = const [
    Product(name: 'Bell Pepper', subtitle: '3pcs', price: '\$2.99', emoji: '🫑'),
    Product(name: 'Ginger Root', subtitle: '200g', price: '\$1.99', emoji: '🫚'),
    Product(name: 'Broccoli', subtitle: '1 head', price: '\$2.49', emoji: '🥦'),
  ];

  final List<Map<String, String>> _banners = const [
    {
      'title': 'Fresh Vegetables',
      'subtitle': 'Get Up To 40% OFF',
      'emoji': '🥦',
      'bg': 'vegetable',
    },
    {
      'title': 'Tropical Fruits',
      'subtitle': 'New Arrivals Daily',
      'emoji': '🍍',
      'bg': 'fruit',
    },
    {
      'title': 'Organic Dairy',
      'subtitle': 'Farm to Table',
      'emoji': '🥛',
      'bg': 'dairy',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader()),
                  SliverToBoxAdapter(child: _buildSearchBar()),
                  SliverToBoxAdapter(child: _buildBanner()),
                  SliverToBoxAdapter(child: _buildSectionHeader('Exclusive Offer')),
                  SliverToBoxAdapter(child: _buildProductRow(_exclusiveOffers)),
                  SliverToBoxAdapter(child: _buildSectionHeader('Best Selling')),
                  SliverToBoxAdapter(child: _buildProductRow(_bestSelling)),
                  const SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        children: [
          const Text('🥕', style: TextStyle(fontSize: 32)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.location_on, color: Color(0xFF2ECC71), size: 18),
              SizedBox(width: 4),
              Text(
                'Dhaka, Banassre',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3436),
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: Color(0xFF636E72), size: 18),
            ],
          ),
        ],
      ),
    );
  }

  // ── Search Bar ──────────────────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const TextField(
          decoration: InputDecoration(
            hintText: 'Search Store',
            hintStyle: TextStyle(color: Color(0xFFB2BEC3), fontSize: 15),
            prefixIcon: Icon(Icons.search, color: Color(0xFFB2BEC3)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }

  // ── Banner ──────────────────────────────────────────────────────────────

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 140,
              child: PageView.builder(
                itemCount: _banners.length,
                onPageChanged: (i) => setState(() => _currentBannerIndex = i),
                itemBuilder: (context, index) {
                  final banner = _banners[index];
                  final colors = index == 0
                      ? [const Color(0xFFD4EDDA), const Color(0xFFA8D5B5)]
                      : index == 1
                          ? [const Color(0xFFFFF3CD), const Color(0xFFFFD88A)]
                          : [const Color(0xFFD1ECF1), const Color(0xFF9DD8E0)];
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: colors),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Text(
                          banner['emoji']!,
                          style: const TextStyle(fontSize: 64),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                banner['title']!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2D3436),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                banner['subtitle']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF2ECC71),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _banners.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _currentBannerIndex ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == _currentBannerIndex ? _green : const Color(0xFFDFE6E9),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Section Header ──────────────────────────────────────────────────────

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'See all',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2ECC71),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Product Row ─────────────────────────────────────────────────────────

  Widget _buildProductRow(List<Product> products) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        itemBuilder: (context, index) => _ProductCard(product: products[index]),
      ),
    );
  }

  // ── Bottom Nav ──────────────────────────────────────────────────────────

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.storefront_outlined, 'activeIcon': Icons.storefront, 'label': 'Shop'},
      {'icon': Icons.search_outlined, 'activeIcon': Icons.search, 'label': 'Explore'},
      {'icon': Icons.shopping_cart_outlined, 'activeIcon': Icons.shopping_cart, 'label': 'Cart'},
      {'icon': Icons.favorite_border, 'activeIcon': Icons.favorite, 'label': 'Favourite'},
      {'icon': Icons.person_outline, 'activeIcon': Icons.person, 'label': 'Account'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1.5)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final isSelected = _selectedNavIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _selectedNavIndex = i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSelected
                      ? items[i]['activeIcon'] as IconData
                      : items[i]['icon'] as IconData,
                  color: isSelected ? _green : const Color(0xFFB2BEC3),
                  size: 24,
                ),
                const SizedBox(height: 3),
                Text(
                  items[i]['label'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: isSelected ? _green : const Color(0xFFB2BEC3),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ─── Product Card ────────────────────────────────────────────────────────────

class _ProductCard extends StatefulWidget {
  final Product product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  int _qty = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text(widget.product.emoji, style: const TextStyle(fontSize: 52)),
          ),
          const SizedBox(height: 6),
          Text(
            widget.product.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF2D3436),
            ),
          ),
          Text(
            widget.product.subtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF636E72)),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
              _qty == 0
                  ? _AddButton(onTap: () => setState(() => _qty++))
                  : _QtyControl(
                      qty: _qty,
                      onIncrement: () => setState(() => _qty++),
                      onDecrement: () => setState(() => _qty = (_qty - 1).clamp(0, 99)),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
}

class _QtyControl extends StatelessWidget {
  final int qty;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QtyControl({
    required this.qty,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
}
