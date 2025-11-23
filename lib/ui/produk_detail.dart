import 'package:flutter/material.dart';
import '../model/produk.dart';
import '../service/produk_service.dart';
import 'produk_form.dart';

class ProdukDetail extends StatelessWidget {
  final Produk produk;

  const ProdukDetail({super.key, required this.produk});

  Future<void> delete(BuildContext context) async {
    await ProdukService.deleteProduk(produk.id!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Produk Ratu")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kode: ${produk.kodeProduk}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Nama: ${produk.namaProduk}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Harga: ${produk.hargaProduk}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProdukForm(produk: produk),
                    ),
                  ),
                  child: const Text("Edit"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => delete(context),
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}