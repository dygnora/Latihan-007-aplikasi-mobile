# Refactoring Aplikasi Profil Flutter

## 1. Deskripsi Proyek

Proyek ini merupakan latihan mata kuliah **Aplikasi Mobile** untuk membangun antarmuka halaman profil menggunakan Flutter.

Pengerjaan dimulai dari kode awal yang diberikan dosen. Kode tersebut kemudian diperbaiki dan direfactor menjadi beberapa *custom widget* agar struktur lebih rapi, mudah dipahami, dan dapat digunakan kembali (*reusable*).

Referensi pengerjaan: materi **05 Flutter**, khususnya kode awal dan instruksi praktikum halaman 14–19.

## 2. Fitur yang Dibuat

- Halaman profil menggunakan `Scaffold` dan `AppBar`.
- Avatar pengguna menggunakan `CircleAvatar`.
- Informasi nama dan role pengguna.
- Statistik profil: Proyek, Follower, dan Following.
- Daftar pengalaman menggunakan `ListView.builder`.
- Item pengalaman ditampilkan menggunakan `Card` dan `ListTile`.
- Tombol Edit Profil menampilkan `SnackBar` berisi informasi bahwa fitur edit belum aktif.

## 3. Perubahan dan Refactoring yang Dilakukan

### 3.1 Memisahkan halaman profil

Tampilan halaman profil dipisahkan dari konfigurasi aplikasi. `main.dart` berfokus pada konfigurasi aplikasi, sedangkan `profile_page.dart` berisi tampilan halaman profil.

### 3.2 Extract Widget `ProfileAvatar`

Bagian `CircleAvatar` dipindahkan ke custom widget bernama `ProfileAvatar`.

Tujuannya:
- Memisahkan tampilan avatar dari halaman utama.
- Membuat kode halaman lebih ringkas.
- Memungkinkan widget avatar digunakan kembali.

### 3.3 Extract Widget `ProfileInfo`

Bagian nama pengguna, role, tombol Edit Profil, dan statistik dipisahkan menjadi widget `ProfileInfo`.

Widget ini menerima data melalui parameter:
- `userName`
- `role`

### 3.4 Extract Widget `ProfileStats` dan `StatItem`

Baris statistik yang sebelumnya ditulis langsung di dalam `Container` dipisahkan menjadi dua widget:

- `ProfileStats`: mengatur wadah dan susunan tiga statistik.
- `StatItem`: menampilkan satu angka dan label statistik.

Ketiga item statistik menggunakan `Expanded` agar memperoleh pembagian lebar yang sama di dalam `Row`.

### 3.5 Menambahkan daftar pengalaman dengan `ListView.builder`

Ditambahkan data dummy pengalaman dalam variabel `experiences` bertipe `List<String>`.

Daftar ditampilkan menggunakan `ListView.builder` dengan:
- `itemCount` untuk menentukan jumlah item.
- `itemBuilder` untuk membangun tampilan setiap item berdasarkan index.
- `Expanded` untuk memberikan batas tinggi kepada daftar ketika berada di dalam `Column`, sehingga daftar dapat digulir.

### 3.6 Extract Widget `ExperienceCard`

Tampilan setiap item pengalaman dipisahkan menjadi custom widget `ExperienceCard`.

Widget ini menggunakan:
- `Card` sebagai wadah kartu.
- `elevation` untuk memberikan efek bayangan.
- `Padding` untuk memberikan ruang di dalam kartu.
- `ListTile` untuk menyusun ikon dan teks.
- `Icons.work` sebagai ikon pengalaman.

### 3.7 Penyesuaian tata letak

Dilakukan penyesuaian padding dan jarak antar-komponen, antara lain:
- Menambahkan `Padding` horizontal dan vertikal pada halaman.
- Mengatur jarak avatar, informasi profil, judul pengalaman, dan daftar.
- Menyesuaikan padding pada `ProfileStats`.
- Menyesuaikan margin dan padding pada `ExperienceCard`.

`SizedBox` digunakan untuk memberi jarak. `Expanded` digunakan untuk mengisi atau membagi ruang yang tersedia, bukan sebagai pengganti `SizedBox`.

### 3.8 Menambahkan aksi statis pada tombol Edit Profil

Tombol Edit Profil menggunakan `ScaffoldMessenger` dan `SnackBar`.

Ketika tombol ditekan, aplikasi menampilkan pesan:

> Fitur edit belum aktif pada modul statis.

Pada versi ini tombol belum mengubah data profil. Implementasi dialog edit dan penyimpanan nama belum termasuk dalam kode yang digunakan.

### 3.9 Menggunakan `StatefulWidget` untuk `ProfilePage`

`ProfilePage` diubah menjadi `StatefulWidget`, dan variabel `userName` diletakkan di dalam `_ProfilePageState`.

Nama pengguna kemudian dikirim ke `ProfileInfo` melalui parameter `userName`, bukan ditulis langsung pada pemanggilan widget.

Tombol Edit tetap menggunakan aksi statis `SnackBar`. Dengan demikian, variabel `userName` sudah disiapkan di dalam state, tetapi belum diubah melalui antarmuka.

## 4. Kesalahan atau Kekurangan pada Kode Awal Dosen dan Perbaikannya

Bagian ini mencatat masalah yang ditemukan pada contoh kode awal di materi praktikum. Beberapa merupakan kesalahan arah ukuran, ketidaksesuaian tipe data, atau masalah layout.

| No. | Bagian kode awal | Masalah | Perbaikan |
|---|---|---|---|
| 1 | `SizedBox(width: 16)` di dalam `Column` | Mengatur lebar, padahal `Column` menyusun widget secara vertikal. | Menggunakan `SizedBox(height: 16)` untuk jarak vertikal. |
| 2 | Data pengalaman tidak dipisahkan dengan koma | Dua teks dapat tergabung menjadi satu item sehingga jumlah item tidak sesuai maksud. | Memisahkan setiap pengalaman dengan koma. |
| 3 | `SizedBox(height: 24)` di dalam `Row` | Mengatur tinggi, bukan jarak horizontal. | Menggunakan `SizedBox(width: 24)` jika membutuhkan jarak horizontal. |
| 4 | `StatItem(count: 42, ...)` | Parameter `count` bertipe `String`, tetapi diberi nilai `int`. | Menggunakan string, misalnya `count: '42'`. |
| 5 | `ListView.builder` langsung di dalam `Column` tanpa batas tinggi | List dapat mengalami masalah constraint tinggi (*unbounded height*). | Membungkus `ListView.builder` dengan `Expanded`. |
| 6 | Tampilan profil dan daftar masih ditulis panjang di satu tempat | Struktur sulit dibaca dan komponen sulit digunakan kembali. | Mengekstrak `ProfileAvatar`, `ProfileInfo`, `ProfileStats`, `StatItem`, dan `ExperienceCard`. |
| 7 | Tampilan item dibuat langsung di dalam `itemBuilder` | Desain item bercampur dengan logika pembentukan daftar. | Memindahkan desain item ke `ExperienceCard`. |

### Catatan tentang kode awal

- `SizedBox` dengan arah yang tidak sesuai tidak selalu menghasilkan compile error, tetapi tidak memberi jarak pada sumbu yang dimaksud.
- String pengalaman yang tidak dipisahkan koma dapat tergabung menjadi satu item, bukan selalu menjadi syntax error.
- `StatItem(count: 42)` merupakan ketidaksesuaian tipe karena `count` meminta `String`.
- `ListView.builder` tanpa batas tinggi di dalam `Column` merupakan masalah layout yang perlu diperbaiki.
- Refactoring menjadi custom widget merupakan perbaikan struktur kode, bukan perbaikan error kompilasi.

## 5. Struktur Widget Akhir

```text
ProfilePage (StatefulWidget)
└── _ProfilePageState
    ├── ProfileAvatar
    ├── ProfileInfo
    │   └── ProfileStats
    │       └── StatItem
    └── Expanded
        └── ListView.builder
            └── ExperienceCard
```

## 6. Ringkasan Materi Flutter yang Digunakan

| Widget/Konsep | Kegunaan |
|---|---|
| `Scaffold` | Kerangka dasar halaman aplikasi. |
| `AppBar` | Menampilkan bilah aplikasi di bagian atas. |
| `CircleAvatar` | Menampilkan avatar berbentuk lingkaran. |
| `Column` | Menyusun widget secara vertikal. |
| `Row` | Menyusun widget secara horizontal. |
| `Padding` | Memberikan ruang di sekitar atau di dalam komponen. |
| `SizedBox` | Memberikan ukuran atau jarak tetap. |
| `Expanded` | Mengisi sisa ruang yang tersedia pada `Row` atau `Column`. |
| `ListView.builder` | Membuat daftar yang dapat digulir. |
| `Card` | Menampilkan konten dalam bentuk kartu. |
| `ListTile` | Menyusun ikon dan teks dalam satu baris. |
| `StatelessWidget` | Widget yang tidak mengelola state internal yang berubah. |
| `StatefulWidget` | Widget yang memiliki state yang dapat berubah. |
| `SnackBar` | Menampilkan pesan sementara di layar. |

## 7. Pesan Commit

Berikut pesan commit yang digunakan sebagai acuan tahapan praktikum:

```text
feat: create basic profile page structure with avatar and text
refactor: extract avatar and info into custom widgets
feat: add profile statistics row
refactor: extract statistics UI into ProfileStats and StatItem widgets
feat: add scrollable experience list using ListView.builder
refactor: extract list tile into ExperienceCard widget and apply styling
style: adjust padding and spacing for profile components
refactor: convert ProfilePage to StatefulWidget for dynamic data
feat: add static edit button with snackbar notification
```

Pastikan commit yang benar-benar sudah dibuat diperiksa menggunakan `git log`. Daftar di atas merupakan acuan tahapan, bukan bukti bahwa seluruh commit sudah tersimpan di repository.

## 8. Batasan Implementasi Saat Ini

- Data pengalaman masih berupa dummy data yang ditulis langsung di dalam aplikasi.
- Nama pengguna disimpan dalam state aplikasi, belum menggunakan database atau penyimpanan lokal.
- Tombol Edit Profil hanya menampilkan `SnackBar`.
- Belum terdapat form dialog untuk mengubah nama pengguna.
- Perubahan nama tidak tersimpan secara permanen setelah aplikasi ditutup sepenuhnya.

## 9. Kesimpulan

Melalui praktikum ini, kode awal halaman profil diperbaiki dan direfactor menjadi beberapa custom widget dengan tanggung jawab yang lebih jelas. Penggunaan `Expanded` dan `ListView.builder` memungkinkan daftar pengalaman ditampilkan dan digulir, sedangkan `Card` dan `ExperienceCard` membuat tampilan item lebih terstruktur.

Praktikum ini juga menerapkan dasar `StatefulWidget`, pengaturan tata letak, debugging, serta penggunaan Conventional Commits dalam pengelolaan perubahan kode.
