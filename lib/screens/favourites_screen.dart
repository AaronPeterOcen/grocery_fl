import 'package:flutter/material.dart';

const Color kGreen = Color(0xFF2ECC71);
const Color kDarkText = Color(0xFF2D3436);
const Color kGrey = Color(0xFF636E72);
const Color kLightGrey = Color(0xFFF5F5F5);

class FavouriteItem {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;

  const FavouriteItem({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.emoji,
  });
}

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final List<FavouriteItem> _items = const [
    FavouriteItem(
      name: 'Sprite Can',
      subtitle: '325ml',
      price: '\$1.50',
      emoji: '🥤',
    ),
    FavouriteItem(
      name: 'Diet Coke',
      subtitle: '355ml',
      price: '\$1.99',
      emoji: '🥤',
    ),
    FavouriteItem(
      name: 'Apple & Grape Juice',
      subtitle: '2L',
      price: '\$15.50',
      emoji: '🍹',
    ),
    FavouriteItem(
      name: 'Coca Cola Can',
      subtitle: '325ml',
      price: '\$4.99',
      emoji: '🥫',
    ),
    FavouriteItem(
      name: 'Pepsi Can',
      subtitle: '330ml',
      price: '\$4.99',
      emoji: '🥫',
    ),
  ];

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
                  ? _buildEmpty()
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            itemCount: _items.length,
                            separatorBuilder: (_, __) =>
                                Divider(color: Colors.grey.shade100, height: 1),
                            itemBuilder: (_, i) =>
                                _FavouriteTile(item: _items[i]),
                          ),
                        ),
                        _buildAddAllToCart(),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Center(
        child: Text(
          'Favourrite',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kDarkText,
          ),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('❤️', style: TextStyle(fontSize: 64)),
          SizedBox(height: 16),
          Text(
            'No favourites yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kDarkText,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Tap the heart on any product to save it',
            style: TextStyle(fontSize: 14, color: kGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAllToCart() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
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
            'Add All To Cart',
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

class _FavouriteTile extends StatelessWidget {
  final FavouriteItem item;
  const _FavouriteTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          // Product thumbnail
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
          // Name + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: kDarkText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.subtitle}, Price',
                  style: const TextStyle(fontSize: 13, color: kGrey),
                ),
              ],
            ),
          ),
          // Price + arrow
          Row(
            children: [
              Text(
                item.price,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.arrow_forward_ios, size: 14, color: kGrey),
            ],
          ),
        ],
      ),
    );
  }
}
