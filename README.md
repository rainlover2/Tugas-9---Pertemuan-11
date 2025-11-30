# tokokita

Nama: Ratu Naurah Calista
Shift Baru: B

# 1. Proses Login #
<img width="469" height="1071" alt="Screenshot 2025-11-30 212402" src="https://github.com/user-attachments/assets/d892c415-da24-408e-9a67-474dff628f70" />
# Penjelasan:
1. Struktur (Widgets)
_emailTextField & _passwordTextField: Membuat kolom input (TextFormField). Menggunakan TextEditingController untuk mengambil teks yang diketik dan fungsi validator untuk memastikan kolom tidak kosong.
_buttonLogin: Tombol yang saat diklik akan memicu validasi seluruh formulir menggunakan _formKey. Jika valid, ia memanggil fungsi inti _submit().
_menuRegistrasi: Tautan yang membawa pengguna ke halaman RegistrasiPage menggunakan Navigator.push.

2. Logika Inti (_submit())
Fungsi ini menangani komunikasi dengan backend (diwakili oleh LoginBloc):
Mengambil Input: Menggunakan _emailTextboxController.text dan _passwordTextboxController.text.
Komunikasi BLoC: Memanggil LoginBloc.login() untuk otentikasi.
Penanganan Hasil:
Sukses (Code 200): Menyimpan token dan userID ke penyimpanan lokal (UserInfo), lalu mengarahkan pengguna ke ProdukPage.
Gagal/Error: Menampilkan dialog peringatan (WarningDialog) kepada pengguna.
Status Loading: Menggunakan variabel _isLoading untuk mengelola status tombol (aktif saat data dikirim, nonaktif saat selesai).

# 2. PopUp Berhasil
<img width="464" height="298" alt="Screenshot 2025-11-30 214004" src="https://github.com/user-attachments/assets/7ba19f7c-cace-44d9-ae1c-0b759c45209e" />
# Kode:
showDialog(
context: context,
barrierDismissible: false,
builder: (BuildContext context) => SuccessDialog(
description: "Registrasi berhasil, silahkan login",
okClick: () {
Navigator.pop(context);
},
));
}, onError: (error) {
showDialog(
context: context,
barrierDismissible: false,
builder: (BuildContext context) => const WarningDialog(
description: "Registrasi gagal, silahkan coba lagi",
));
# Penjelasan:
1. Perintah Inti (showDialog)
Perintah showDialog dipanggil setelah proses registrasi dianggap berhasil. Fungsi ini bertugas mengambil widget dialog yang Anda buat dan menampilkannya di tengah layar.

3. Pengaturan Wajib
context: context: Memberi tahu Flutter lokasi tampilan saat ini.
barrierDismissible: false: Pengaturan ini sangat penting. Ini mencegah pengguna menutup popup dengan mengetuk area di luar dialog yang berwarna abu-abu. Pengguna wajib berinteraksi dengan tombol di dalam popup.

4. Konten Popup (builder)
Bagian builder yang berisi SuccessDialog mendefinisikan tampilan popup (yaitu tulisan "SUKSES", pesan, dan tombol "OK"). Pesan "Registrasi berhasil, silahkan login" dimasukkan melalui parameter description.

5. Aksi Penutup (okClick)
Ketika pengguna menekan tombol "OK" pada popup tersebut, fungsi okClick akan dieksekusi. Fungsinya adalah Navigator.pop(context), yang bertugas menutup dan menghilangkan popup dari tampilan, mengembalikan pengguna ke layar registrasi (atau login) di bawahnya.

# 3. Tambah Data Produk #
<img width="474" height="1071" alt="Screenshot 2025-11-30 212446" src="https://github.com/user-attachments/assets/3dbc78c1-9fab-4f54-b1ae-7a50b298b6e4" />
# Penjelasan
1. Penentuan Mode (isUpdate() & initState)
Widget ProdukForm dapat menerima objek Produk melalui konstruktor (widget.produk).
Fungsi isUpdate() berjalan saat widget dimuat (initState) untuk menentukan mode:
Mode Ubah: Jika widget.produk ada (tidak null), maka judul (judul) diubah menjadi "UBAH PRODUK", teks tombol (tombolSubmit) menjadi "UBAH", dan textbox diisi dengan data produk yang dikirimkan.
Mode Tambah: Jika widget.produk kosong, defaultnya adalah "TAMBAH PRODUK" dan "SIMPAN".

2. Struktur Input (Text Fields)
Terdapat tiga widget TextFormField terpisah (_kodeProdukTextField, _namaProdukTextField, _hargaProdukTextField):
Ketiganya menggunakan TextEditingController untuk mengontrol dan mengambil input data.
Masing-masing memiliki fungsi validator untuk memastikan data wajib diisi oleh pengguna.

3. Logika Submit (_buttonSubmit)
Tombol ini bertugas memproses data:
Pertama, ia menjalankan validasi formulir (_formKey.currentState!.validate()).
Jika valid, ia memeriksa mode saat ini:
Jika mode Ubah (widget.produk != null), ia memanggil fungsi ubah().
Jika mode Tambah (widget.produk == null), ia memanggil fungsi simpan().

4. Proses Penyimpanan (simpan())
Fungsi ini menangani pengiriman data produk baru:
Mengaktifkan loading (_isLoading = true).
Mengambil teks dari ketiga controller dan membuat objek Produk baru.
Mengubah harga menjadi tipe data int (int.parse()).
Memanggil ProdukBloc.addProduk untuk mengirim data ke backend.
Sukses: Navigasi kembali ke ProdukPage.
Gagal/Error: Menampilkan dialog peringatan (WarningDialog).

# 4. List Produk #
<img width="471" height="1076" alt="Screenshot 2025-11-30 212458" src="https://github.com/user-attachments/assets/00511098-a184-4b5d-b07a-73312c77cf77" />
# Penjelasan
1. Struktur Utama
Scaffold: Menyediakan kerangka halaman.
AppBar:
Judul: 'List Produk'.
actions: Berisi ikon + (tambah) di pojok kanan atas. Saat diklik, ia menggunakan Navigator.push untuk membawa pengguna ke halaman ProdukForm (Tambah/Ubah Produk).
Drawer: Menu samping yang bisa dibuka. Saat ini hanya berisi satu opsi: "Logout". Saat diklik, ia memanggil LogoutBloc.logout() dan setelah sukses, ia mengarahkan pengguna ke LoginPage menggunakan pushAndRemoveUntil (menghapus semua halaman sebelumnya dari riwayat navigasi).

2. Pengambilan dan Tampilan Data (Body)
FutureBuilder: Ini adalah kunci utama untuk menampilkan daftar produk.
future: Memanggil ProdukBloc.getProduks() untuk mengambil data daftar produk dari backend.
builder:
Selama data diambil, ia menampilkan CircularProgressIndicator (loading).
Setelah data berhasil diambil (snapshot.hasData), ia meneruskan data tersebut ke widget ListProduk.

3. Komponen Daftar
ListProduk: Widget ini menerima daftar (List? list) dari FutureBuilder dan menggunakan ListView.builder untuk menampilkan setiap item dalam daftar.
ItemProduk: Widget ini mewakili tampilan satu baris produk:
Menggunakan Card dan ListTile untuk menampilkan namaProduk sebagai title dan hargaProduk sebagai subtitle.
Seluruh item dibungkus dalam GestureDetector. Saat diklik (onTap), ia mengarahkan pengguna ke halaman ProdukDetail (Detail Produk), sambil membawa objek produk yang dipilih.

# 5. Detail Produk
<img width="474" height="1073" alt="Screenshot 2025-11-30 212515" src="https://github.com/user-attachments/assets/23b6cda3-6b73-4293-852a-03fa0f2154c6" />
# Penjelasan
1. Penerimaan Data
Widget ProdukDetail adalah StatefulWidget yang menerima objek Produk yang dipilih dari halaman sebelumnya (List Produk) melalui konstruktor (widget.produk).

2. Tampilan Data (Body)
Data produk (Kode, Nama, Harga) ditampilkan di tengah layar menggunakan widget Text. Data diambil langsung dari objek widget.produk (misalnya, widget.produk!.kodeProduk).

3. Tombol Aksi (_tombolHapusEdit())
Fungsi ini menampilkan dua tombol bersebelahan (Row):
Tombol "EDIT": Saat diklik, ia menggunakan Navigator.push untuk membawa pengguna ke halaman ProdukForm (Tambah/Ubah Produk). Yang penting, tombol ini menyertakan objek widget.produk yang sedang dilihat, sehingga ProdukForm akan masuk ke Mode Ubah.
Tombol "DELETE": Saat diklik, ia memanggil fungsi confirmHapus() untuk meminta konfirmasi dari pengguna.

4. Logika Hapus (confirmHapus())
Fungsi ini menangani proses penghapusan:
Menampilkan Konfirmasi: Ia menggunakan showDialog untuk menampilkan AlertDialog yang menanyakan "Yakin ingin menghapus data ini?".
Tombol "Batal": Menutup popup konfirmasi (Navigator.pop(context)).
Tombol "Ya" (Hapus):
Memanggil ProdukBloc.deleteProduk dengan ID produk yang di-parse menjadi int.
Sukses: Navigasi kembali ke ProdukPage (List Produk) agar daftar diperbarui.
Gagal/Error: Menampilkan dialog peringatan (WarningDialog).

# 6. Ubah Produk (edit)
<img width="470" height="1071" alt="Screenshot 2025-11-30 212553" src="https://github.com/user-attachments/assets/cf298f41-2039-4602-bf82-429dbcc43bee" />
# Penjelasan
1. Perintah Inti (Navigator.push)
Navigator.push digunakan untuk berpindah ke halaman baru (menumpuk halaman baru di atas halaman saat ini).

2. Halaman Tujuan (ProdukForm)
Halaman tujuan adalah ProdukForm, yang merupakan widget formulir yang sama digunakan untuk menambah produk.

3. Mengirim Data Produk (produk: widget.produk!)
Ini adalah bagian paling penting. Ketika berpindah ke ProdukForm, kode ini mengirimkan objek produk yang sedang dilihat (widget.produk!) sebagai parameter.
Karena ProdukForm menerima objek produk, ia secara otomatis mendeteksi bahwa mode yang dimaksud adalah "UBAH", bukan "TAMBAH".

4. Hasil
Setelah ProdukForm menerima objek produk:
Judul halaman berubah menjadi "UBAH PRODUK".
Semua kolom input (Kode, Nama, Harga) terisi otomatis dengan data produk yang dikirimkan.
Tombol "SIMPAN" berubah menjadi "UBAH".



