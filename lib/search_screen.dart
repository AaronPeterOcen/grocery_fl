import 'package:flutter/material.dart';

const Color kGreen = Color(0xFF2ECC71);
const Color kDarkText = Color(0xFF2D3436);
const Color kGrey = Color(0xFF636E72);

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  static const List<_SearchProduct> _allProducts = [
    _SearchProduct('Egg Chicken Red', '4pcs', '\$1.99', '🥚'),
    _SearchProduct('Egg Pasta', '30gm', '\$15.99', '🍝'),
    _SearchProduct('Mayonnais Eggless', '300ml', '\$8.99', '🫙'),
    _SearchProduct('Organic Bananas', '7pcs', '\$4.99', '🍌'),
    _SearchProduct('Red Apple', '1kg', '\$4.99', '🍎'),
    _SearchProduct('Bell Pepper', '3pcs', '\$2.99', '🫑'),
    _SearchProduct('Broccoli', '1 head', '\$2.49', '🥦'),
    _SearchProduct('Diet Coke', '355ml', '\$1.99', '🥤'),
    _SearchProduct('Orange Juice', '2L', '\$15.99', '🍊'),
    _SearchProduct('Whole Milk', '1L', '\$2.49', '🥛'),
    _SearchProduct('Cheddar Cheese', '200g', '\$4.99', '🧀'),
    _SearchProduct('Sourdough Bread', '400g', '\$3.99', '🍞'),
  ];

  List<_SearchProduct> get _results {
    if (_query.isEmpty) return [];
    return _allProducts
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: _query.isEmpty
                  ? _buildEmptyState()
                  : results.isEmpty
                  ? _buildNoResults()
                  : _buildResultsList(results),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search Store',
            hintStyle: const TextStyle(color: Color(0xFFB2BEC3), fontSize: 15),
            prefixIcon: const Icon(Icons.search, color: Color(0xFFB2BEC3)),
            suffixIcon: _query.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      _controller.clear();
                      setState(() => _query = '');
                    },
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFFB2BEC3),
                      size: 18,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onChanged: (val) => setState(() => _query = val),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: [
        const SizedBox(height: 24),
        _buildSectionLabel('Recent Searches'),
        ...['Egg', 'Apple', 'Juice'].map(
          (s) => _RecentSearchTile(
            query: s,
            onTap: () {
              _controller.text = s;
              setState(() => _query = s);
            },
          ),
        ),
        const SizedBox(height: 24),
        _buildSectionLabel('Popular'),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.5,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children:
                ['Fruits', 'Vegetables', 'Dairy', 'Beverages', 'Snacks', 'Meat']
                    .map(
                      (t) => _PopularChip(
                        label: t,
                        onTap: () {
                          _controller.text = t;
                          setState(() => _query = t);
                        },
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: kDarkText,
          ),
        ),
      ),
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 60)),
          const SizedBox(height: 16),
          Text(
            'No results for "$_query"',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kDarkText,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Try a different search term',
            style: TextStyle(fontSize: 14, color: kGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(List<_SearchProduct> results) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: results.length,
      separatorBuilder: (_, _) => Divider(color: Colors.grey.shade100),
      itemBuilder: (_, i) => _SearchResultTile(product: results[i]),
    );
  }
}

class _SearchProduct {
  final String name;
  final String subtitle;
  final String price;
  final String emoji;
  const _SearchProduct(this.name, this.subtitle, this.price, this.emoji);
}

class _SearchResultTile extends StatefulWidget {
  final _SearchProduct product;
  const _SearchResultTile({required this.product});

  @override
  State<_SearchResultTile> createState() => _SearchResultTileState();
}

class _SearchResultTileState extends State<_SearchResultTile> {
  int _qty = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                widget.product.emoji,
                style: const TextStyle(fontSize: 36),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: kDarkText,
                  ),
                ),
                Text(
                  '${widget.product.subtitle}, Price',
                  style: const TextStyle(fontSize: 13, color: kGrey),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.product.price,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: kDarkText,
                  ),
                ),
              ],
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
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                )
              : Row(
                  children: [
                    _SmBtn(
                      icon: Icons.remove,
                      onTap: () =>
                          setState(() => _qty = (_qty - 1).clamp(0, 99)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        '$_qty',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _SmBtn(
                      icon: Icons.add,
                      onTap: () => setState(() => _qty++),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _SmBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _SmBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: icon == Icons.add ? kGreen : const Color(0xFFF0FBF5),
          borderRadius: BorderRadius.circular(8),
          border: icon == Icons.add ? null : Border.all(color: kGreen),
        ),
        child: Icon(
          icon,
          size: 14,
          color: icon == Icons.add ? Colors.white : kGreen,
        ),
      ),
    );
  }
}

class _RecentSearchTile extends StatelessWidget {
  final String query;
  final VoidCallback onTap;
  const _RecentSearchTile({required this.query, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history, color: kGrey, size: 20),
      title: Text(
        query,
        style: const TextStyle(fontSize: 15, color: kDarkText),
      ),
      trailing: const Icon(Icons.north_west, color: kGrey, size: 16),
      onTap: onTap,
      dense: true,
    );
  }
}

class _PopularChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PopularChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0FBF5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFB2DFDB)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(
            color: kGreen,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
