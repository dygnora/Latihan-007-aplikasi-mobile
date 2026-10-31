# README --- Refactoring Aplikasi Profil Flutter

## 1. Deskripsi Proyek

Proyek ini merupakan latihan mata kuliah **Aplikasi Mobile** untuk
membangun antarmuka halaman profil menggunakan Flutter.

Pengerjaan dimulai dari kode awal yang diberikan dosen, kemudian
diperbaiki dan direfactor menjadi beberapa custom widget agar struktur
kode lebih rapi, mudah dipahami, dan dapat digunakan kembali
(*reusable*).

Referensi pengerjaan: materi **05 Flutter**, khususnya kode awal dan
instruksi praktikum pada halaman 14--19.

## 2. Fitur yang Dibuat

-   Halaman profil dengan `Scaffold` dan `AppBar`.
-   Avatar pengguna menggunakan `CircleAvatar`.
-   Informasi nama dan role pengguna.
-   Statistik profil: Proyek, Follower, dan Following.
-   Daftar pengalaman menggunakan `ListView.builder`.
-   Item pengalaman ditampilkan menggunakan `Card` dan `ListTile`.
-   Tombol Edit Profil menampilkan `SnackBar` berisi informasi bahwa
    fitur edit belum aktif.

## 3. Perubahan dan Refactoring yang Dilakukan

### 3.1 Membuat halaman profil terpisah

Kode awal menempatkan sebagian besar tampilan di dalam `MainApp`.
Struktur kemudian dipisahkan sehingga `main.dart` dapat berfokus pada
konfigurasi aplikasi, sedangkan `profile_page.dart` berisi tampilan
halaman profil.

### 3.2 Extract Widget `ProfileAvatar`

Bagian `CircleAvatar` dipindahkan ke custom widget bernama
`ProfileAvatar`.

Tujuan: - Memisahkan tampilan avatar dari halaman utama. - Membuat kode
halaman lebih ringkas. - Memungkinkan widget avatar digunakan kembali.

### 3.3 Extract Widget `ProfileInfo`

Bagian nama pengguna, role, tombol Edit Profil, dan statistik dipisahkan
dari halaman utama menjadi `ProfileInfo`.

Widget ini menerima data melalui parameter: - `userName` - `role`

### 3.4 Extract Widget `ProfileStats` dan `StatItem`

Baris statistik yang sebelumnya ditulis langsung di dalam `Container`
dipisahkan menjadi dua widget:

-   `ProfileStats`: mengatur wadah dan susunan tiga statistik.
-   `StatItem`: menampilkan satu angka dan label statistik.

Ketiga item statistik menggunakan `Expanded` agar memperoleh pembagian
lebar yang sama di dalam `Row`.

### 3.5 Menambahkan daftar pengalaman dengan `ListView.builder`

Ditambahkan data dummy pengalaman dalam variabel `experiences` bertipe
`List<String>`.

Daftar ditampilkan menggunakan `ListView.builder` dengan: - `itemCount`
untuk menentukan jumlah item. - `itemBuilder` untuk membangun tampilan
setiap item berdasarkan index. - `Expanded` untuk memberikan batas
tinggi kepada daftar ketika berada di dalam `Column`, sehingga daftar
dapat digulir.

### 3.6 Extract Widget `ExperienceCard`

Tampilan setiap item pengalaman dipisahkan menjadi custom widget
`ExperienceCard`.

Widget ini menggunakan: - `Card` untuk wadah kartu. - `elevation` untuk
efek bayangan. - `Padding` untuk ruang di dalam kartu. - `ListTile`
untuk menyusun ikon dan teks. - `Icons.work` sebagai ikon pengalaman.

### 3.7 Penyesuaian tata letak

Dilakukan penyesuaian padding dan jarak antar-komponen, antara lain: -
Menambahkan `Padding` horizontal dan vertical pada halaman. - Mengatur
jarak avatar, informasi profil, judul pengalaman, dan daftar. -
Menyesuaikan padding pada `ProfileStats`. - Menyesuaikan margin dan
padding pada `ExperienceCard`.

`SizedBox` digunakan untuk memberi jarak. `Expanded` tetap digunakan
untuk membagi ruang yang tersedia, bukan sebagai pengganti `SizedBox`.

### 3.8 Menambahkan aksi statis pada tombol Edit Profil

Tombol Edit Profil menggunakan `ScaffoldMessenger` dan `SnackBar`.

Ketika tombol ditekan, aplikasi menampilkan pesan:

> Fitur edit belum aktif pada modul statis.

Pada versi ini tombol belum mengubah data profil. Implementasi dialog
edit dan penyimpanan nama belum menjadi bagian dari kode akhir yang
digunakan.

### 3.9 Menggunakan `StatefulWidget` untuk `ProfilePage`

`ProfilePage` diubah menjadi `StatefulWidget`, dan variabel `userName`
diletakkan di dalam `_ProfilePageState`.

Nama pengguna kemudian dikirim ke `ProfileInfo` melalui parameter
`userName`, bukan ditulis langsung pada pemanggilan widget.

Catatan: materi rencana awal pada dokumen menyebut pendekatan statis,
sedangkan bagian rencana Hari 4 pada halaman 16 meminta konversi ke
`StatefulWidget`. Implementasi proyek mengikuti tugas konversi tersebut,
tetapi tombol Edit tetap menggunakan aksi statis `SnackBar`.

## 4. Kesalahan atau Kekurangan pada Kode Awal Dosen dan Perbaikannya

Bagian ini mencatat masalah yang terlihat pada contoh kode halaman
17--19. Beberapa merupakan kesalahan tipe/layout yang dapat menimbulkan
error, sedangkan sebagian lainnya merupakan kesalahan penulisan atau
perilaku tampilan yang tidak sesuai maksud.

  ---------------------------------------------------------------------------------------------
  No.               Bagian kode awal               Masalah           Perbaikan yang dilakukan
  ----------------- ------------------------------ ----------------- --------------------------
  1                 `const SizedBox(width: 16)` di Mengatur lebar,   Menggunakan
                    dalam `Column`                 padahal susunan   `SizedBox(height: ...)`.
                                                   `Column` vertikal 
                                                   dan jarak yang    
                                                   dibutuhkan adalah 
                                                   tinggi.           

  2                 Dua data pengalaman ditulis    Kedua literal     Memisahkan setiap
                    tanpa koma di antara string    string dapat      pengalaman dengan koma.
                                                   tergabung menjadi 
                                                   satu teks,        
                                                   sehingga jumlah   
                                                   item tidak sesuai 
                                                   maksud.           

  3                 `const SizedBox(height: 24)`   Mengatur tinggi,  Menggunakan
                    di dalam `Row`                 bukan jarak       `SizedBox(width: ...)`
                                                   horizontal.       jika membutuhkan jarak
                                                                     horizontal, atau
                                                                     `Expanded` untuk membagi
                                                                     lebar.

  4                 `StatItem(count: 42, ...)`     Parameter `count` Menggunakan string,
                                                   dideklarasikan    misalnya `count: '42'`.
                                                   bertipe `String`, 
                                                   tetapi diberi     
                                                   nilai `int`.      

  5                 `ListView.builder` diletakkan  List dapat        Membungkus
                    langsung di dalam `Column`     mengalami masalah `ListView.builder` dengan
                    tanpa batas tinggi             constraint tinggi `Expanded`.
                                                   (*unbounded       
                                                   height*) dan      
                                                   menyebabkan       
                                                   layout error.     

  6                 Tampilan profil dan daftar     Struktur sulit    Mengekstrak
                    masih ditulis panjang di satu  dibaca dan        `ProfileAvatar`,
                    tempat                         komponen sulit    `ProfileInfo`,
                                                   digunakan         `ProfileStats`,
                                                   kembali.          `StatItem`, dan
                                                                     `ExperienceCard`.

  7                 Item daftar dibuat langsung di Desain item       Memindahkan desain item ke
                    dalam `itemBuilder`            bercampur dengan  `ExperienceCard`.
                                                   logika            
                                                   pembentukan       
                                                   daftar.           
  ---------------------------------------------------------------------------------------------

### Catatan tentang kode awal

-   `SizedBox` dengan arah yang tidak sesuai tidak selalu menghasilkan
    compile error, tetapi tidak memberi jarak pada sumbu yang dimaksud.
-   String pengalaman yang tidak dipisahkan koma dapat tergabung menjadi
    satu item, bukan selalu menjadi syntax error.
-   `StatItem(count: 42)` merupakan ketidaksesuaian tipe karena `count`
    meminta `String`.
-   `ListView.builder` tanpa batas tinggi di dalam `Column` merupakan
    masalah layout yang perlu diperbaiki.
-   Refactoring menjadi custom widget merupakan perbaikan struktur kode,
    bukan perbaikan error kompilasi.

## 5. Struktur Widget Akhir

``` text
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

  -----------------------------------------------------------------------
  Widget/Konsep                       Kegunaan
  ----------------------------------- -----------------------------------
  `Scaffold`                          Kerangka dasar halaman aplikasi.

  `AppBar`                            Menampilkan bilah aplikasi di
                                      bagian atas.

  `CircleAvatar`                      Menampilkan avatar berbentuk
                                      lingkaran.

  `Column`                            Menyusun widget secara vertikal.

  `Row`                               Menyusun widget secara horizontal.

  `Padding`                           Memberikan ruang di sekitar atau di
                                      dalam komponen.

  `SizedBox`                          Memberikan ukuran atau jarak tetap.

  `Expanded`                          Mengisi sisa ruang yang tersedia
                                      pada `Row` atau `Column`.

  `ListView.builder`                  Membuat daftar yang dapat digulir.

  `Card`                              Menampilkan konten dalam bentuk
                                      kartu.

  `ListTile`                          Menyusun ikon dan teks dalam satu
                                      baris.

  `StatelessWidget`                   Widget yang tidak mengelola state
                                      internal yang berubah.

  `StatefulWidget`                    Widget yang memiliki state yang
                                      dapat berubah.

  `SnackBar`                          Menampilkan pesan sementara di
                                      layar.
  -----------------------------------------------------------------------