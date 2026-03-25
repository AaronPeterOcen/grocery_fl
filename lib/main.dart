import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'explore_screen.dart';
import 'search_screen.dart';

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
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  static const Color kGreen = Color(0xFF2ECC71);

  final List<Widget> _screens = const [
    HomeBody(), // Shop tab (home content only, no bottom nav)
    ExploreScreen(), // Explore tab
    CartScreen(), // Cart tab
    FavouritesScreen(), // Favourites tab
    AccountScreen(), // Account tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {
        'icon': Icons.storefront_outlined,
        'activeIcon': Icons.storefront,
        'label': 'Shop',
      },
      {
        'icon': Icons.search_outlined,
        'activeIcon': Icons.search,
        'label': 'Explore',
      },
      {
        'icon': Icons.shopping_cart_outlined,
        'activeIcon': Icons.shopping_cart,
        'label': 'Cart',
      },
      {
        'icon': Icons.favorite_border,
        'activeIcon': Icons.favorite,
        'label': 'Favourite',
      },
      {
        'icon': Icons.person_outline,
        'activeIcon': Icons.person,
        'label': 'Account',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade100, width: 1.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (i) {
            final isSelected = _selectedIndex == i;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected
                        ? items[i]['activeIcon'] as IconData
                        : items[i]['icon'] as IconData,
                    color: isSelected ? kGreen : const Color(0xFFB2BEC3),
                    size: 24,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    items[i]['label'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? kGreen : const Color(0xFFB2BEC3),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ─── Placeholder screens for tabs not yet designed ───────────────────────────

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderScreen(
    emoji: '🛒',
    title: 'Your Cart',
    subtitle: 'Your cart is empty',
  );
}

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderScreen(
    emoji: '❤️',
    title: 'Favourites',
    subtitle: 'No favourites yet',
  );
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) => const _PlaceholderScreen(
    emoji: '👤',
    title: 'Account',
    subtitle: 'Manage your profile',
  );
}

class _PlaceholderScreen extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  const _PlaceholderScreen({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3436),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Color(0xFF636E72)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── HomeBody (home content without its own bottom nav) ──────────────────────
// This is a slimmed version of HomeScreen that only renders the scrollable body.
// The bottom nav is handled by MainShell above.

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int _currentBannerIndex = 0;

  static const Color kGreen = Color(0xFF2ECC71);
  static const Color kDarkText = Color(0xFF2D3436);
  static const Color kGrey = Color(0xFF636E72);

  final List<_Product> _exclusiveOffers = const [
    _Product('Organic Bananas', '7pcs', '\$4.99', '🍌'),
    _Product('Red Apple', '1kg', '\$4.99', '🍎'),
    _Product('Fresh Mango', '500g', '\$3.49', '🥭'),
  ];

  final List<_Product> _bestSelling = const [
    _Product('Bell Pepper', '3pcs', '\$2.99', '🫑'),
    _Product('Ginger Root', '200g', '\$1.99', '🫚'),
    _Product('Broccoli', '1 head', '\$2.49', '🥦'),
  ];

  final List<Map<String, String>> _banners = const [
    {
      'title': 'Fresh Vegetables',
      'subtitle': 'Get Up To 40% OFF',
      'emoji': '🥦',
    },
    {
      'title': 'Tropical Fruits',
      'subtitle': 'New Arrivals Daily',
      'emoji': '🍍',
    },
    {'title': 'Organic Dairy', 'subtitle': 'Farm to Table', 'emoji': '🥛'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearchBar(context)),
            SliverToBoxAdapter(child: _buildBanner()),
            SliverToBoxAdapter(child: _buildSectionHeader('Exclusive Offer')),
            SliverToBoxAdapter(
              child: _buildProductRow(_exclusiveOffers, context),
            ),
            SliverToBoxAdapter(child: _buildSectionHeader('Best Selling')),
            SliverToBoxAdapter(child: _buildProductRow(_bestSelling, context)),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

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
              Icon(Icons.location_on, color: kGreen, size: 18),
              SizedBox(width: 4),
              Text(
                'Dhaka, Banassre',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kDarkText,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: kGrey, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: GestureDetector(
        onTap: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const SearchScreen())),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            children: [
              SizedBox(width: 12),
              Icon(Icons.search, color: Color(0xFFB2BEC3)),
              SizedBox(width: 8),
              Text(
                'Search Store',
                style: TextStyle(color: Color(0xFFB2BEC3), fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    final colors = [
      [const Color(0xFFD4EDDA), const Color(0xFFA8D5B5)],
      [const Color(0xFFFFF3CD), const Color(0xFFFFD88A)],
      [const Color(0xFFD1ECF1), const Color(0xFF9DD8E0)],
    ];
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
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: colors[index]),
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
                                  color: kDarkText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                banner['subtitle']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: kGreen,
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
                  color: i == _currentBannerIndex
                      ? kGreen
                      : const Color(0xFFDFE6E9),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              color: kDarkText,
            ),
          ),
          const Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              color: kGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(List<_Product> products, BuildContext context) {
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
}

class _Product {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;
  const _Product(this.name, this.subtitle, this.price, this.emoji);
}

class _ProductCard extends StatefulWidget {
  final _Product product;
  const _ProductCard({required this.product});

  @override
  State<_ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<_ProductCard> {
  int _qty = 0;
  static const Color kGreen = Color(0xFF2ECC71);
  static const Color kDarkText = Color(0xFF2D3436);
  static const Color kGrey = Color(0xFF636E72);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProductDetailScreen(
            name: widget.product.name,
            subtitle: '${widget.product.subtitle}, Price',
            price: widget.product.price,
            emoji: widget.product.emoji,
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
              child: Text(
                widget.product.emoji,
                style: const TextStyle(fontSize: 52),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: kDarkText,
              ),
            ),
            Text(
              widget.product.subtitle,
              style: const TextStyle(fontSize: 12, color: kGrey),
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
                    color: kDarkText,
                  ),
                ),
                _qty == 0
                    ? GestureDetector(
                        onTap: () => setState(() => _qty++),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: kGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          _MiniBtn(
                            icon: Icons.remove,
                            onTap: () =>
                                setState(() => _qty = (_qty - 1).clamp(0, 99)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '$_qty',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          _MiniBtn(
                            icon: Icons.add,
                            onTap: () => setState(() => _qty++),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MiniBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: icon == Icons.add
              ? const Color(0xFF2ECC71)
              : const Color(0xFFF0FBF5),
          borderRadius: BorderRadius.circular(8),
          border: icon == Icons.add
              ? null
              : Border.all(color: const Color(0xFF2ECC71)),
        ),
        child: Icon(
          icon,
          size: 13,
          color: icon == Icons.add ? Colors.white : const Color(0xFF2ECC71),
        ),
      ),
    );
  }
}

// Import from product_detail_screen.dart
// (placed here to keep main.dart self-contained in preview;
//  in your project, use the separate file and import it)
class ProductDetailScreen extends StatefulWidget {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;

  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.emoji,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _qty = 1;
  bool _isFavourite = false;
  bool _detailExpanded = true;

  static const Color kGreen = Color(0xFF2ECC71);
  static const Color kDarkText = Color(0xFF2D3436);
  static const Color kGrey = Color(0xFF636E72);

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
                    Divider(color: Colors.grey.shade100),
                    _buildDetailSection(),
                    Divider(color: Colors.grey.shade100),
                    _buildNutritionRow(),
                    Divider(color: Colors.grey.shade100),
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
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 16,
                  color: kDarkText,
                ),
              ),
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
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: kDarkText,
                      ),
                    ),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(fontSize: 14, color: kGrey),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _isFavourite = !_isFavourite),
                child: Icon(
                  _isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavourite ? Colors.red : kGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _QBtn(
                icon: Icons.remove,
                onTap: () => setState(() => _qty = (_qty - 1).clamp(1, 99)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '$_qty',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kDarkText,
                  ),
                ),
              ),
              _QBtn(icon: Icons.add, onTap: () => setState(() => _qty++)),
              const Spacer(),
              Text(
                widget.price,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
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
                const Text(
                  'Product Detail',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kDarkText,
                  ),
                ),
                Icon(
                  _detailExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
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
          const Text(
            'Nutritions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kDarkText,
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '100gr',
                  style: TextStyle(fontSize: 12, color: kGrey),
                ),
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
          const Text(
            'Review',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kDarkText,
            ),
          ),
          Row(
            children: [
              ...List.generate(
                5,
                (i) => const Icon(Icons.star, color: Colors.amber, size: 18),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_ios, size: 14, color: kGrey),
            ],
          ),
        ],
      ),
    );
  }

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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Add To Basket',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _QBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QBtn({required this.icon, required this.onTap});

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
        child: Icon(icon, size: 18, color: const Color(0xFF2D3436)),
      ),
    );
  }
}
