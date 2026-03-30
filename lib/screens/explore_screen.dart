import 'package:flutter/material.dart';

const Color kGreen = Color(0xFF2ECC71);
const Color kDarkText = Color(0xFF2D3436);
const Color kGrey = Color(0xFF636E72);

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<_Category> _categories = const [
    _Category('Fresh Fruits\n& Vegetable', '🥦', Color(0xFFE8F5E9)),
    _Category('Cooking Oil\n& Ghee', '🫒', Color(0xFFFFF8E1)),
    _Category('Meat & Fish', '🥩', Color(0xFFFFEBEE)),
    _Category('Bakery & Snacks', '🍞', Color(0xFFF3E5F5)),
    _Category('Dairy & Eggs', '🥚', Color(0xFFFFF3E0)),
    _Category('Beverages', '🧃', Color(0xFFE3F2FD)),
    _Category('Household', '🧹', Color(0xFFE8EAF6)),
    _Category('Baby Care', '🍼', Color(0xFFFCE4EC)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildCategoryGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Center(
        child: Text(
          'Find Products',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kDarkText,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search Store',
            hintStyle: TextStyle(color: Color(0xFFB2BEC3), fontSize: 15),
            prefixIcon: Icon(Icons.search, color: Color(0xFFB2BEC3)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.1,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) => _CategoryCard(category: _categories[index]),
    );
  }
}

class _Category {
  final String name;
  final String emoji;
  final Color bgColor;
  const _Category(this.name, this.emoji, this.bgColor);
}

class _CategoryCard extends StatelessWidget {
  final _Category category;
  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => CategoryScreen(
            categoryName: category.name.replaceAll('\n', ' '),
            emoji: category.emoji,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: category.bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(category.emoji, style: const TextStyle(fontSize: 52)),
            const SizedBox(height: 10),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kDarkText,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Category Screen (e.g. Beverages) ───────────────────────────────────────

class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final String emoji;

  const CategoryScreen({
    super.key,
    required this.categoryName,
    required this.emoji,
  });

  static final Map<String, List<_CatProduct>> _productMap = {
    'Beverages': [
      _CatProduct('Diet Coke', '355ml', '\$1.99', '🥤'),
      _CatProduct('Sprite Can', '325ml', '\$1.50', '🥤'),
      _CatProduct('Apple & Grape Juice', '2L', '\$15.99', '🍹'),
      _CatProduct('Orange Juice', '2L', '\$15.99', '🍊'),
      _CatProduct('Coca Cola Can', '325ml', '\$4.99', '🥫'),
      _CatProduct('Pepsi Can', '330ml', '\$4.99', '🥫'),
    ],
  };

  List<_CatProduct> get _products {
    final key = _productMap.keys.firstWhere(
      (k) => categoryName.toLowerCase().contains(k.toLowerCase()),
      orElse: () => '',
    );
    return _productMap[key] ??
        [
          _CatProduct('$categoryName Item 1', '500g', '\$2.99', emoji),
          _CatProduct('$categoryName Item 2', '1kg', '\$4.99', emoji),
          _CatProduct('$categoryName Item 3', '250g', '\$1.99', emoji),
          _CatProduct('$categoryName Item 4', '2L', '\$3.49', emoji),
        ];
  }

  @override
  Widget build(BuildContext context) {
    final products = _products;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new, color: kDarkText, size: 18),
        ),
        title: Text(categoryName,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: kDarkText)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.tune, color: kDarkText),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.82,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => _CatProductCard(product: products[index]),
      ),
    );
  }
}

class _CatProduct {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;
  const _CatProduct(this.name, this.subtitle, this.price, this.emoji);
}

class _CatProductCard extends StatefulWidget {
  final _CatProduct product;
  const _CatProductCard({required this.product});

  @override
  State<_CatProductCard> createState() => _CatProductCardState();
}

class _CatProductCardState extends State<_CatProductCard> {
  int _qty = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))
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
          Text(widget.product.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, color: kDarkText)),
          Text('${widget.product.subtitle}, Price',
              style: const TextStyle(fontSize: 12, color: kGrey)),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.product.price,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: kDarkText)),
              _qty == 0
                  ? GestureDetector(
                      onTap: () => setState(() => _qty++),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: kGreen,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 18),
                      ),
                    )
                  : Row(
                      children: [
                        _SmallQtyBtn(
                            icon: Icons.remove,
                            onTap: () => setState(() => _qty = (_qty - 1).clamp(0, 99))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text('$_qty',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                        _SmallQtyBtn(
                            icon: Icons.add, onTap: () => setState(() => _qty++)),
                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmallQtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SmallQtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: icon == Icons.add ? kGreen : const Color(0xFFF0FBF5),
          borderRadius: BorderRadius.circular(6),
          border: icon == Icons.add ? null : Border.all(color: kGreen),
        ),
        child: Icon(icon, size: 13, color: icon == Icons.add ? Colors.white : kGreen),
      ),
    );
  }
}
