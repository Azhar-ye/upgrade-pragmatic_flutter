import 'dart:async';
import 'package:flutter/material.dart';

// Import chapter pages
import 'chapter09/main_09.dart' as ch9;
import 'chapter10/main_10_switchingThemes.dart' as ch10;
import 'chapter11/main_11_sharedprefs.dart' as ch11;
import 'chapter12/main_12.dart' as ch12;
import 'chapter13/part2/main_13.dart' as ch13;
import 'chapter14/main_14_direct.dart' as ch14;
import 'chapter15/main_15.dart' as ch15;

void main() {
  runApp(const FinalBooksApp());
}

class FinalBooksApp extends StatelessWidget {
  const FinalBooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pragmatic Flutter - Final App",
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  double progressValue = 0.0;
  Timer? progressTimer;

  @override
  void initState() {
    super.initState();

    // Animations
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnim = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();

    // Fake progress loading
    progressTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      setState(() {
        progressValue += 0.03;
        if (progressValue >= 1.0) {
          progressValue = 1.0;
          timer.cancel();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeDashboardPage()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    progressTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.shade900,
              Colors.deepPurple.shade600,
              Colors.deepPurple.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: Container(
                width: 360,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.18),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // LOGO
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        "assets/flutter_icon.png",
                        width: 70,
                        height: 70,
                      ),
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Pragmatic Flutter",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Final App (Chapter 9–15)",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        minHeight: 10,
                        backgroundColor: Colors.white.withOpacity(0.20),
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Loading ${(progressValue * 100).toInt()}%",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeDashboardPage extends StatefulWidget {
  const HomeDashboardPage({super.key});

  @override
  State<HomeDashboardPage> createState() => _HomeDashboardPageState();
}

class _HomeDashboardPageState extends State<HomeDashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  String keyword = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_ChapterItem> get allChapters => [
        _ChapterItem(
          title: "Chapter 9",
          subtitle: "UI Basic List",
          icon: Icons.list_alt,
          color: Colors.blue,
          onTap: () => _open(ch9.BooksApp()),
        ),
        _ChapterItem(
          title: "Chapter 10",
          subtitle: "Switching Themes",
          icon: Icons.dark_mode,
          color: Colors.purple,
          onTap: () => _open(ch10.BooksApp()),
        ),
        _ChapterItem(
          title: "Chapter 11",
          subtitle: "Shared Preferences Theme",
          icon: Icons.save,
          color: Colors.green,
          onTap: () => _open(ch11.BooksApp()),
        ),
        _ChapterItem(
          title: "Chapter 12",
          subtitle: "REST API Call",
          icon: Icons.api,
          color: Colors.orange,
          onTap: () => _open(ch12.BooksApp()),
        ),
        _ChapterItem(
          title: "Chapter 13",
          subtitle: "Parsing JSON",
          icon: Icons.data_object,
          color: Colors.teal,
          onTap: () => _open(ch13.BooksApp()),
        ),
        _ChapterItem(
          title: "Chapter 14",
          subtitle: "Navigation",
          icon: Icons.navigation,
          color: Colors.indigo,
          onTap: () => _open(ch14.BooksApp()),
        ),
        _ChapterItem(
          title: "Chapter 15",
          subtitle: "Details + Read/Buy Link",
          icon: Icons.open_in_browser,
          color: Colors.redAccent,
          onTap: () => _open(ch15.BooksApp()),
        ),
      ];

  void _open(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final filtered = allChapters.where((c) {
      final q = keyword.toLowerCase().trim();
      if (q.isEmpty) return true;
      return c.title.toLowerCase().contains(q) ||
          c.subtitle.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Final App (Chapter 9–15)"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutPage()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() => keyword = value);
              },
              decoration: InputDecoration(
                hintText: "Search chapter... (contoh: 12 / API / Theme)",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: keyword.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => keyword = "");
                        },
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text("Chapter tidak ditemukan 😅"))
                  : GridView.builder(
                      itemCount: filtered.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.2,
                      ),
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return _ChapterCard(item: item);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChapterItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _ChapterItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class _ChapterCard extends StatelessWidget {
  final _ChapterItem item;

  const _ChapterCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [
              item.color.withOpacity(0.90),
              item.color.withOpacity(0.55),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item.icon, size: 34, color: Colors.white),
            const Spacer(),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dibikin kepake biar warning unused_local_variable hilang
    const nama = "Muhammad Azhar";
    const nim = "231510076";
    const kelas = "Pemrograman Mobile";

    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tugas Mandiri",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text("Upgrade Aplikasi Online Book (Pragmatic Flutter)"),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 10),
                Text("Nama : $nama"),
                Text("Npm  : $nim"),
                Text("Kelas: $kelas"),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
                const Text("Chapter yang dikerjakan: 9 – 15"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
