import 'package:flutter/material.dart';

/// Konfigurasi identitas mahasiswa pengembang aplikasi.
/// Mudah diubah melalui konstanta berikut sesuai ketentuan evaluasi UTS.
class StudentProfile {
  static const String name = 'Muhammad Ilham Fajri';
  static const String npm = '2428240082';
  static const String course = 'Pengembangan Aplikasi Bergerak I';
}

/// Data konten kuliner Lontong Balap khas Surabaya.
class CulinaryData {
  static const String name = 'Lontong Balap';
  static const String origin = 'Surabaya, Jawa Timur';
  static const String mainIngredients = 'Lontong, tauge, dan lentho';
  static const String serving = 'Dengan kuah dan sate kerang';
  static const String description =
      'Lontong balap merupakan kuliner khas Surabaya yang terdiri dari '
      'lontong, tauge, lentho, dan kuah gurih. Hidangan ini umumnya '
      'disajikan bersama sate kerang serta taburan bawang goreng dan sambal.';
  static const String headerAsset = 'assets/images/lontong_balap.jpg';
}

/// Model untuk item pada galeri kuliner Surabaya.
class GalleryItem {
  final String title;
  final String imageUrl;

  const GalleryItem({
    required this.title,
    required this.imageUrl,
  });
}

/// Daftar kuliner khas Surabaya untuk bagian Galeri (minimal 4 gambar network).
const List<GalleryItem> galleryItems = [
  GalleryItem(
    title: 'Rawon Surabaya',
    imageUrl:
        'https://images.unsplash.com/photo-1677921739245-4efaa1914ef3?w=600&auto=format&fit=crop&q=80',
  ),
  GalleryItem(
    title: 'Sate Klopo',
    imageUrl:
        'https://images.unsplash.com/photo-1660786442992-1ffb495fd962?w=600&auto=format&fit=crop&q=80',
  ),
  GalleryItem(
    title: 'Tahu Campur',
    imageUrl:
        'https://images.unsplash.com/photo-1658218615066-660f7c936926?w=600&auto=format&fit=crop&q=80',
  ),
  GalleryItem(
    title: 'Sate Madura Surabaya',
    imageUrl:
        'https://images.unsplash.com/photo-1644288232801-2b40ff99d54f?w=600&auto=format&fit=crop&q=80',
  ),
  GalleryItem(
    title: 'Rujak Cingur',
    imageUrl:
        'https://images.unsplash.com/photo-1751212352288-d5811798804c?w=600&auto=format&fit=crop&q=80',
  ),
];

void main() {
  runApp(const LontongBalapApp());
}

/// Root widget aplikasi Lontong Balap UTS.
class LontongBalapApp extends StatelessWidget {
  const LontongBalapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detail Kuliner Lontong Balap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD35400),
          primary: const Color(0xFFD35400),
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F9FB),
      ),
      home: const CulinaryDetailPage(),
    );
  }
}

/// Halaman tunggal detail kuliner Lontong Balap.
class CulinaryDetailPage extends StatefulWidget {
  const CulinaryDetailPage({super.key});

  @override
  State<CulinaryDetailPage> createState() => _CulinaryDetailPageState();
}

class _CulinaryDetailPageState extends State<CulinaryDetailPage> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    final snackBar = SnackBar(
      content: Text(
        _isFavorite
            ? '${CulinaryData.name} ditambahkan ke favorit!'
            : '${CulinaryData.name} dihapus dari favorit.',
      ),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'TUTUP',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Kuliner Surabaya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.08),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header / Hero Image Asset Lokal
            _buildHeroImage(),

            // Konten Detail
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Baris Judul & Ikon Favorit
                  _buildTitleAndFavoriteRow(theme),

                  const SizedBox(height: 16),

                  // 3. Tiga Baris Informasi Kuliner dengan Ikon
                  _buildCulinaryInfoCard(),

                  const SizedBox(height: 24),

                  // 4. Bagian Deskripsi
                  _buildDescriptionSection(theme),

                  const SizedBox(height: 24),

                  // 5. Bagian Galeri (Horizontal Network Images)
                  _buildGallerySection(theme),

                  const SizedBox(height: 24),

                  // 6. Bagian Identitas Mahasiswa
                  _buildStudentIdentityCard(theme),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Widget Header Hero menggunakan gambar asset lokal.
  Widget _buildHeroImage() {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Image.asset(
        CulinaryData.headerAsset,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey.shade300,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image_not_supported, size: 48, color: Colors.grey.shade600),
                const SizedBox(height: 8),
                Text(
                  'Gagal memuat gambar header',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Widget Baris Judul & Ikon Favorit.
  Widget _buildTitleAndFavoriteRow(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            CulinaryData.name,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2C3E50),
            ),
          ),
        ),
        IconButton(
          onPressed: _toggleFavorite,
          tooltip: _isFavorite ? 'Hapus favorit' : 'Tambah favorit',
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.redAccent : Colors.grey.shade600,
            size: 30,
          ),
        ),
      ],
    );
  }

  /// Widget Tiga Baris Informasi Kuliner (Asal, Bahan Utama, Disajikan).
  Widget _buildCulinaryInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.location_on,
            iconColor: const Color(0xFFE67E22),
            text: 'Asal: ${CulinaryData.origin}',
          ),
          Divider(height: 20, thickness: 1, color: Colors.grey.shade100),
          _buildInfoRow(
            icon: Icons.restaurant_menu,
            iconColor: const Color(0xFFD35400),
            text: 'Bahan Utama: ${CulinaryData.mainIngredients}',
          ),
          Divider(height: 20, thickness: 1, color: Colors.grey.shade100),
          _buildInfoRow(
            icon: Icons.soup_kitchen,
            iconColor: const Color(0xFFC0392B),
            text: 'Disajikan: ${CulinaryData.serving}',
          ),
        ],
      ),
    );
  }

  /// Baris item informasi dengan icon di kiri dan teks di kanan.
  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                color: Color(0xFF34495E),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Bagian Deskripsi Kuliner.
  Widget _buildDescriptionSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          CulinaryData.description,
          style: const TextStyle(
            fontSize: 14.5,
            height: 1.6,
            color: Color(0xFF555555),
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  /// Bagian Galeri Gambar Network tersusun horizontal.
  Widget _buildGallerySection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Galeri',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C3E50),
              ),
            ),
            Text(
              '${galleryItems.length} Foto',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 175,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: galleryItems.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = galleryItems[index];
              return _buildGalleryCard(item);
            },
          ),
        ),
      ],
    );
  }

  /// Kartu gambar galeri dengan loading indicator dan error fallback.
  Widget _buildGalleryCard(GalleryItem item) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
            child: SizedBox(
              height: 125,
              width: 150,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  final total = loadingProgress.expectedTotalBytes;
                  final loaded = loadingProgress.cumulativeBytesLoaded;
                  final value = total != null ? loaded / total : null;
                  return Container(
                    color: Colors.grey.shade100,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: value,
                        strokeWidth: 2.5,
                        color: const Color(0xFFD35400),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.broken_image, size: 32, color: Colors.grey.shade500),
                        const SizedBox(height: 4),
                        Text(
                          'Gagal muat',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bagian Identitas Mahasiswa setelah Galeri.
  Widget _buildStudentIdentityCard(ThemeData theme) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2C3E50),
            const Color(0xFF34495E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C3E50).withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.badge_outlined,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Identitas Mahasiswa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    StudentProfile.course,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Column(
              children: [
                _buildIdentityRow(
                  label: 'Nama',
                  value: StudentProfile.name,
                ),
                Divider(
                  height: 16,
                  thickness: 1,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
                _buildIdentityRow(
                  label: 'NPM',
                  value: StudentProfile.npm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Baris identitas mahasiswa (Label di kiri, Value di kanan).
  Widget _buildIdentityRow({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}
