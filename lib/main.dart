import 'package:flutter/material.dart';

void main() => runApp(const GroceryApp());

// ─── Constants ────────────────────────────────────────────────────────────────
const Color kGreen = Color(0xFF2ECC71);
const Color kDarkText = Color(0xFF2D3436);
const Color kGrey = Color(0xFF636E72);
const Color kLightGrey = Color(0xFFF5F5F5);

// ─── App ──────────────────────────────────────────────────────────────────────
class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Fresh Grocery',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: kGreen),
      useMaterial3: true,
    ),
    home: const MainShell(),
  );
}

// ─── Shell ────────────────────────────────────────────────────────────────────
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _idx = 0;
  final _screens = const [
    HomeBody(),
    ExploreScreen(),
    CartScreen(),
    FavouritesScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: _idx, children: _screens),
    bottomNavigationBar: _BottomNav(
      idx: _idx,
      onTap: (i) => setState(() => _idx = i),
    ),
  );
}

class _BottomNav extends StatelessWidget {
  final int idx;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.idx, required this.onTap});
  static const _items = [
    [Icons.storefront_outlined, Icons.storefront, 'Shop'],
    [Icons.search_outlined, Icons.search, 'Explore'],
    [Icons.shopping_cart_outlined, Icons.shopping_cart, 'Cart'],
    [Icons.favorite_border, Icons.favorite, 'Favourite'],
    [Icons.person_outline, Icons.person, 'Account'],
  ];
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1.5)),
    ),
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final sel = idx == i;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  sel ? _items[i][1] as IconData : _items[i][0] as IconData,
                  color: sel ? kGreen : const Color(0xFFB2BEC3),
                  size: 24,
                ),
                const SizedBox(height: 3),
                Text(
                  _items[i][2] as String,
                  style: TextStyle(
                    fontSize: 11,
                    color: sel ? kGreen : const Color(0xFFB2BEC3),
                    fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
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

// ═══════════════════════════════════════════════════════════════════════════════
// HOME
// ═══════════════════════════════════════════════════════════════════════════════
class HomeBody extends StatefulWidget {
  const HomeBody({super.key});
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int _bi = 0;
  final _offers = const [
    _P('Organic Bananas', '7pcs', r'$4.99', '🍌'),
    _P('Red Apple', '1kg', r'$4.99', '🍎'),
    _P('Fresh Mango', '500g', r'$3.49', '🥭'),
  ];
  final _best = const [
    _P('Bell Pepper', '3pcs', r'$2.99', '🫑'),
    _P('Ginger Root', '200g', r'$1.99', '🫚'),
    _P('Broccoli', '1 head', r'$2.49', '🥦'),
  ];
  final _banners = const [
    {'t': 'Fresh Vegetables', 's': 'Get Up To 40% OFF', 'e': '🥦'},
    {'t': 'Tropical Fruits', 's': 'New Arrivals Daily', 'e': '🍍'},
    {'t': 'Organic Dairy', 's': 'Farm to Table', 'e': '🥛'},
  ];
  final _bColors = const [
    [Color(0xFFD4EDDA), Color(0xFFA8D5B5)],
    [Color(0xFFFFF3CD), Color(0xFFFFD88A)],
    [Color(0xFFD1ECF1), Color(0xFF9DD8E0)],
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _hdr()),
          SliverToBoxAdapter(child: _srch(context)),
          SliverToBoxAdapter(child: _bnr()),
          SliverToBoxAdapter(child: _sec('Exclusive Offer')),
          SliverToBoxAdapter(child: _row(_offers, context)),
          SliverToBoxAdapter(child: _sec('Best Selling')),
          SliverToBoxAdapter(child: _row(_best, context)),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    ),
  );

  Widget _hdr() => Padding(
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

  Widget _srch(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchScreen()),
      ),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: kLightGrey,
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

  Widget _bnr() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 140,
            child: PageView.builder(
              itemCount: _banners.length,
              onPageChanged: (i) => setState(() => _bi = i),
              itemBuilder: (_, i) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: _bColors[i]),
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      _banners[i]['e']!,
                      style: const TextStyle(fontSize: 64),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _banners[i]['t']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kDarkText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _banners[i]['s']!,
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
              ),
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
              width: i == _bi ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == _bi ? kGreen : const Color(0xFFDFE6E9),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _sec(String t) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t,
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

  Widget _row(List<_P> ps, BuildContext ctx) => SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: ps.length,
      itemBuilder: (_, i) => _HomeCard(p: ps[i]),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// EXPLORE
// ═══════════════════════════════════════════════════════════════════════════════
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  static const _cats = [
    _C('Fresh Fruits\n& Vegetable', '🥦', Color(0xFFE8F5E9)),
    _C('Cooking Oil\n& Ghee', '🫒', Color(0xFFFFF8E1)),
    _C('Meat & Fish', '🥩', Color(0xFFFFEBEE)),
    _C('Bakery & Snacks', '🍞', Color(0xFFF3E5F5)),
    _C('Dairy & Eggs', '🥚', Color(0xFFFFF3E0)),
    _C('Beverages', '🧃', Color(0xFFE3F2FD)),
    _C('Household', '🧹', Color(0xFFE8EAF6)),
    _C('Baby Care', '🍼', Color(0xFFFCE4EC)),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          const Padding(
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: kLightGrey,
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
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.1,
              ),
              itemCount: _cats.length,
              itemBuilder: (context, i) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryScreen(
                      name: _cats[i].name.replaceAll('\n', ' '),
                      emoji: _cats[i].emoji,
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: _cats[i].bg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _cats[i].emoji,
                        style: const TextStyle(fontSize: 52),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _cats[i].name,
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
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ─── Category Screen ──────────────────────────────────────────────────────────
class CategoryScreen extends StatelessWidget {
  final String name, emoji;
  const CategoryScreen({super.key, required this.name, required this.emoji});

  static final _data = <String, List<_P>>{
    'Beverages': [
      const _P('Diet Coke', '355ml', r'$1.99', '🥤'),
      const _P('Sprite Can', '325ml', r'$1.50', '🥤'),
      const _P('Apple & Grape Juice', '2L', r'$15.99', '🍹'),
      const _P('Orange Juice', '2L', r'$15.99', '🍊'),
      const _P('Coca Cola Can', '325ml', r'$4.99', '🥫'),
      const _P('Pepsi Can', '330ml', r'$4.99', '🥫'),
    ],
  };

  List<_P> get _products {
    final k = _data.keys.firstWhere(
      (k) => name.toLowerCase().contains(k.toLowerCase()),
      orElse: () => '',
    );
    return _data[k] ??
        [
          _P('$name Item 1', '500g', r'$2.99', emoji),
          _P('$name Item 2', '1kg', r'$4.99', emoji),
        ];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back_ios_new, color: kDarkText, size: 18),
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kDarkText,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => showFilterSheet(context),
          child: const Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.tune, color: kDarkText),
          ),
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
      itemCount: _products.length,
      itemBuilder: (_, i) => _GridCard(p: _products[i]),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SEARCH
// ═══════════════════════════════════════════════════════════════════════════════
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  String _q = '';

  static const _all = [
    _P('Egg Chicken Red', '4pcs', r'$1.99', '🥚'),
    _P('Egg Chicken White', '180g', r'$1.50', '🥚'),
    _P('Egg Pasta', '30gm', r'$15.99', '🍝'),
    _P('Egg Noodles', '2L', r'$15.99', '🍜'),
    _P('Mayonnais Eggless', '300ml', r'$8.99', '🫙'),
    _P('Organic Bananas', '7pcs', r'$4.99', '🍌'),
    _P('Red Apple', '1kg', r'$4.99', '🍎'),
    _P('Bell Pepper', '3pcs', r'$2.99', '🫑'),
    _P('Diet Coke', '355ml', r'$1.99', '🥤'),
    _P('Orange Juice', '2L', r'$15.99', '🍊'),
    _P('Sourdough Bread', '400g', r'$3.99', '🍞'),
  ];

  List<_P> get _res => _q.isEmpty
      ? []
      : _all
            .where((p) => p.name.toLowerCase().contains(_q.toLowerCase()))
            .toList();

  @override
  Widget build(BuildContext context) {
    final res = _res;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _bar(context),
            Expanded(
              child: _q.isEmpty
                  ? _idle()
                  : res.isEmpty
                  ? _none()
                  : _grid(res),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bar(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: kLightGrey,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: _ctrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search Store',
                hintStyle: const TextStyle(
                  color: Color(0xFFB2BEC3),
                  fontSize: 15,
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFB2BEC3)),
                suffixIcon: _q.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          _ctrl.clear();
                          setState(() => _q = '');
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
              onChanged: (v) => setState(() => _q = v),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => showFilterSheet(context),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: kLightGrey,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.tune, color: kDarkText),
          ),
        ),
      ],
    ),
  );

  Widget _idle() => Column(
    children: [
      const SizedBox(height: 20),
      _lbl('Recent Searches'),
      ...['Egg', 'Apple', 'Juice'].map(
        (s) => ListTile(
          leading: const Icon(Icons.history, color: kGrey, size: 20),
          title: Text(
            s,
            style: const TextStyle(fontSize: 15, color: kDarkText),
          ),
          trailing: const Icon(Icons.north_west, color: kGrey, size: 16),
          onTap: () {
            _ctrl.text = s;
            setState(() => _q = s);
          },
          dense: true,
        ),
      ),
      const SizedBox(height: 20),
      _lbl('Popular'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              ['Fruits', 'Vegetables', 'Dairy', 'Beverages', 'Snacks', 'Meat']
                  .map(
                    (t) => GestureDetector(
                      onTap: () {
                        _ctrl.text = t;
                        setState(() => _q = t);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FBF5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFB2DFDB)),
                        ),
                        child: Text(
                          t,
                          style: const TextStyle(
                            color: kGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    ],
  );

  Widget _lbl(String l) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        l,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: kDarkText,
        ),
      ),
    ),
  );

  Widget _none() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('🔍', style: TextStyle(fontSize: 60)),
        const SizedBox(height: 16),
        Text(
          'No results for "$_q"',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kDarkText,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Try a different term',
          style: TextStyle(fontSize: 14, color: kGrey),
        ),
      ],
    ),
  );

  Widget _grid(List<_P> res) => GridView.builder(
    padding: const EdgeInsets.all(16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 0.82,
    ),
    itemCount: res.length,
    itemBuilder: (_, i) => _GridCard(p: res[i]),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// FILTER SHEET
// ═══════════════════════════════════════════════════════════════════════════════
void showFilterSheet(BuildContext context) => showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (_) => const _FilterSheet(),
);

class _FilterSheet extends StatefulWidget {
  const _FilterSheet();
  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  final _cats = <String, bool>{
    'Eggs': true,
    'Noodles & Pasta': false,
    'Chips & Crisps': false,
    'Fast Food': false,
  };
  final _brands = <String, bool>{
    'Individual Collection': false,
    'Cocola': true,
    'Ifad': false,
    'Kazi Farmas': false,
  };

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: 0.82,
    minChildSize: 0.5,
    maxChildSize: 0.95,
    builder: (_, ctrl) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 4),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: kDarkText),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Filters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kDarkText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: ctrl,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _section('Categories', _cats),
                const SizedBox(height: 20),
                _section('Brand', _brands),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Apply Filter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _section(String title, Map<String, bool> map) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kDarkText,
        ),
      ),
      const SizedBox(height: 12),
      ...map.keys.map(
        (k) => GestureDetector(
          onTap: () => setState(() => map[k] = !map[k]!),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: map[k]! ? kGreen : Colors.transparent,
                    border: Border.all(
                      color: map[k]! ? kGreen : Colors.grey.shade400,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: map[k]!
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                Text(
                  k,
                  style: TextStyle(
                    fontSize: 15,
                    color: map[k]! ? kGreen : kDarkText,
                    fontWeight: map[k]! ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// CART
// ═══════════════════════════════════════════════════════════════════════════════
class _CartItem {
  final String name, subtitle, emoji;
  final double unit;
  int qty;
  _CartItem({
    required this.name,
    required this.subtitle,
    required this.unit,
    required this.emoji,
    this.qty = 1,
  });
  double get total => unit * qty;
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _items = [
    _CartItem(
      name: 'Bell Pepper Red',
      subtitle: '1kg',
      unit: 4.99,
      emoji: '🫑',
    ),
    _CartItem(
      name: 'Egg Chicken Red',
      subtitle: '4pcs',
      unit: 1.99,
      emoji: '🥚',
    ),
    _CartItem(
      name: 'Organic Bananas',
      subtitle: '12kg',
      unit: 3.00,
      emoji: '🍌',
    ),
    _CartItem(name: 'Ginger', subtitle: '250gm', unit: 2.99, emoji: '🫚'),
  ];
  double get _total => _items.fold(0.0, (s, i) => s + i.total);

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Center(
              child: Text(
                'My Cart',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
            ),
          ),
          Expanded(
            child: _items.isEmpty
                ? const Center(
                    child: Text(
                      '🛒\n\nYour cart is empty',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: kGrey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey.shade100, height: 1),
                    itemBuilder: (_, i) => _CartRow(
                      item: _items[i],
                      onRemove: () => setState(() => _items.removeAt(i)),
                      onQty: (q) => setState(() => _items[i].qty = q),
                    ),
                  ),
          ),
          if (_items.isNotEmpty)
            Container(
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
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Go to Checkout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '\$${_total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

class _CartRow extends StatelessWidget {
  final _CartItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQty;
  const _CartRow({
    required this.item,
    required this.onRemove,
    required this.onQty,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Row(
      children: [
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: kDarkText,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onRemove,
                    child: const Icon(Icons.close, size: 18, color: kGrey),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                '${item.subtitle}, Price',
                style: const TextStyle(fontSize: 13, color: kGrey),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _Btn(Icons.remove, false, () {
                        if (item.qty > 1) onQty(item.qty - 1);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${item.qty}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: kDarkText,
                          ),
                        ),
                      ),
                      _Btn(Icons.add, true, () => onQty(item.qty + 1)),
                    ],
                  ),
                  Text(
                    '\$${item.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kDarkText,
                    ),
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

class _Btn extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  const _Btn(this.icon, this.filled, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: filled ? kGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: filled ? null : Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 16, color: filled ? Colors.white : kDarkText),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// FAVOURITES
// ═══════════════════════════════════════════════════════════════════════════════
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});
  static const _favs = [
    _P('Sprite Can', '325ml', r'$1.50', '🥤'),
    _P('Diet Coke', '355ml', r'$1.99', '🥤'),
    _P('Apple & Grape Juice', '2L', r'$15.50', '🍹'),
    _P('Coca Cola Can', '325ml', r'$4.99', '🥫'),
    _P('Pepsi Can', '330ml', r'$4.99', '🥫'),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          const Padding(
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
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _favs.length,
              separatorBuilder: (_, __) =>
                  Divider(color: Colors.grey.shade100, height: 1),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: kLightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _favs[i].emoji,
                          style: const TextStyle(fontSize: 38),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _favs[i].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: kDarkText,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_favs[i].sub}, Price',
                            style: const TextStyle(fontSize: 13, color: kGrey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _favs[i].price,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: kDarkText,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: kGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
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
          ),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ACCOUNT
// ═══════════════════════════════════════════════════════════════════════════════
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static const _menuItems = [
    _AItem(Icons.shopping_bag_outlined, 'Orders'),
    _AItem(Icons.person_outline, 'My Details'),
    _AItem(Icons.location_on_outlined, 'Delivery Address'),
    _AItem(Icons.credit_card_outlined, 'Payment Methods'),
    _AItem(Icons.local_offer_outlined, 'Promo Card'),
    _AItem(Icons.notifications_outlined, 'Notifecations'),
    _AItem(Icons.help_outline, 'Help'),
    _AItem(Icons.info_outline, 'About'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Text('👤', style: TextStyle(fontSize: 28)),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Afsar Hossen',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kDarkText,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: kGreen.withOpacity(0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 12,
                                      color: kGreen,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                'mshuv097@gmail.com',
                                style: TextStyle(fontSize: 13, color: kGrey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Menu
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _menuItems.length,
                    separatorBuilder: (_, __) => Divider(
                      color: Colors.grey.shade100,
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                    itemBuilder: (_, i) => InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _menuItems[i].icon,
                              color: kDarkText,
                              size: 22,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                _menuItems[i].label,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: kDarkText,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: kGrey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Log Out
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: kLightGrey,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.logout, color: kGreen, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: kDarkText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _AItem {
  final IconData icon;
  final String label;
  const _AItem(this.icon, this.label);
}

// ═══════════════════════════════════════════════════════════════════════════════
// PRODUCT DETAIL
// ═══════════════════════════════════════════════════════════════════════════════
class ProductDetailScreen extends StatefulWidget {
  final String name, subtitle, price, emoji;
  const ProductDetailScreen({
    super.key,
    required this.name,
    required this.subtitle,
    required this.price,
    required this.emoji,
  });
  @override
  State<ProductDetailScreen> createState() => _PDState();
}

class _PDState extends State<ProductDetailScreen> {
  int _qty = 1;
  bool _fav = false, _exp = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 280,
                    color: kLightGrey,
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            widget.emoji,
                            style: const TextStyle(fontSize: 160),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 6,
                                  ),
                                ],
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
                  ),
                  Padding(
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
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: kGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => setState(() => _fav = !_fav),
                              child: Icon(
                                _fav ? Icons.favorite : Icons.favorite_border,
                                color: _fav ? Colors.red : kGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _OBtn(
                              Icons.remove,
                              () => setState(
                                () => _qty = (_qty - 1).clamp(1, 99),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                '$_qty',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kDarkText,
                                ),
                              ),
                            ),
                            _OBtn(Icons.add, () => setState(() => _qty++)),
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
                  ),
                  Divider(color: Colors.grey.shade100),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => _exp = !_exp),
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
                                _exp
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: kGrey,
                              ),
                            ],
                          ),
                        ),
                        if (_exp) ...[
                          const SizedBox(height: 10),
                          const Text(
                            'Apples Are Nutritious. Apples May Be Good For Weight Loss. '
                            'Apples May Be Good For Your Heart. As Part Of A Healthful And Varied Diet.',
                            style: TextStyle(
                              fontSize: 14,
                              color: kGrey,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade100),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: kLightGrey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                '100gr',
                                style: TextStyle(fontSize: 12, color: kGrey),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: kGrey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade100),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
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
                              (i) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                              color: kGrey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Padding(
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
          ),
        ],
      ),
    ),
  );
}

class _OBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _OBtn(this.icon, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
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

// ═══════════════════════════════════════════════════════════════════════════════
// SHARED MODELS & SMALL WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════
class _P {
  // Product
  final String name, sub, price, emoji;
  const _P(this.name, this.sub, this.price, this.emoji);
}

class _C {
  // Category
  final String name, emoji;
  final Color bg;
  const _C(this.name, this.emoji, this.bg);
}

class _AddBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _AddBtn({required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: kGreen,
        borderRadius: BorderRadius.circular(9),
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 18),
    ),
  );
}

class _InlineQty extends StatelessWidget {
  final int qty;
  final VoidCallback onInc, onDec;
  const _InlineQty({
    required this.qty,
    required this.onInc,
    required this.onDec,
  });
  @override
  Widget build(BuildContext context) => Row(
    children: [
      _SBtn(Icons.remove, false, onDec),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          '$qty',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
      ),
      _SBtn(Icons.add, true, onInc),
    ],
  );
}

class _SBtn extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final VoidCallback onTap;
  const _SBtn(this.icon, this.filled, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: filled ? kGreen : const Color(0xFFF0FBF5),
        borderRadius: BorderRadius.circular(6),
        border: filled ? null : Border.all(color: kGreen),
      ),
      child: Icon(icon, size: 13, color: filled ? Colors.white : kGreen),
    ),
  );
}

// Grid card (used in category + search)
class _GridCard extends StatefulWidget {
  final _P p;
  const _GridCard({required this.p});
  @override
  State<_GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<_GridCard> {
  int _qty = 0;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          name: widget.p.name,
          subtitle: '${widget.p.sub}, Price',
          price: widget.p.price,
          emoji: widget.p.emoji,
        ),
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(widget.p.emoji, style: const TextStyle(fontSize: 52)),
          ),
          const SizedBox(height: 6),
          Text(
            widget.p.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: kDarkText,
            ),
          ),
          Text(
            '${widget.p.sub}, Price',
            style: const TextStyle(fontSize: 12, color: kGrey),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.p.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
              _qty == 0
                  ? _AddBtn(onTap: () => setState(() => _qty++))
                  : _InlineQty(
                      qty: _qty,
                      onInc: () => setState(() => _qty++),
                      onDec: () =>
                          setState(() => _qty = (_qty - 1).clamp(0, 99)),
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Home horizontal card
class _HomeCard extends StatefulWidget {
  final _P p;
  const _HomeCard({required this.p});
  @override
  State<_HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<_HomeCard> {
  int _qty = 0;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          name: widget.p.name,
          subtitle: '${widget.p.sub}, Price',
          price: widget.p.price,
          emoji: widget.p.emoji,
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
            child: Text(widget.p.emoji, style: const TextStyle(fontSize: 52)),
          ),
          const SizedBox(height: 6),
          Text(
            widget.p.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: kDarkText,
            ),
          ),
          Text(
            widget.p.sub,
            style: const TextStyle(fontSize: 12, color: kGrey),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.p.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
              _qty == 0
                  ? _AddBtn(onTap: () => setState(() => _qty++))
                  : _InlineQty(
                      qty: _qty,
                      onInc: () => setState(() => _qty++),
                      onDec: () =>
                          setState(() => _qty = (_qty - 1).clamp(0, 99)),
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}
