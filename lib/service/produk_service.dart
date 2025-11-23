import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/produk.dart';
import 'package:toko_api/service/api.dart';

class ProdukService {
  // GET
  static Future<List<Produk>> getProduk() async {
    final res = await http.get(Uri.parse(Api.produk));

    if (res.statusCode == 200) {
      List data = jsonDecode(res.body)['data'];
      return data.map((e) => Produk.fromJson(e)).toList();
    }
    return [];
  }

  // POST
  static Future<bool> tambahProduk(
    String kode,
    String nama,
    String harga,
  ) async {
    final res = await http.post(
      Uri.parse(Api.produk),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "kode_produk": kode,
        "nama_produk": nama,
        "harga": harga,
      }),
    );

    return res.statusCode == 200;
  }

  // PUT
  static Future<bool> updateProduk(
    String id,
    String kode,
    String nama,
    String harga,
  ) async {
    final res = await http.put(
      Uri.parse("${Api.produk}/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "kode_produk": kode,
        "nama_produk": nama,
        "harga": harga,
      }),
    );

    return res.statusCode == 200;
  }

  // DELETE
  static Future<bool> deleteProduk(String id) async {
    final res = await http.delete(Uri.parse("${Api.produk}/$id"));
    return res.statusCode == 200;
  }
}