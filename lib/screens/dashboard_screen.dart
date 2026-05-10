import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_pbm/providers/auth_provider.dart';
import 'package:tugas_pbm/providers/products_provider.dart';
import 'package:tugas_pbm/utils/app_routes.dart';
import 'package:tugas_pbm/widgets/w_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Memanggil data produk segera setelah layar dibuka
    Future.microtask(() => context.read<ProductProvider>().fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 25),

            // --- BAGIAN HEADER ---
            Consumer<AuthProvider>(
              builder: (context, authProv, child) {
                if (authProv.user == null) {
                  return const WHeader(judul: "...", deskripsi: "...");
                }
                return WHeader(
                  judul: "Halo, ${authProv.user!.name.split(' ')[0]}",
                  deskripsi:
                      "NIM: ${authProv.user!.username}, Class: ${authProv.user!.classData.name}",
                );
              },
            ),

            const SizedBox(height: 20),
            const Text(
              "Daftar Produk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // --- BAGIAN LIST PRODUK ---
            Consumer<ProductProvider>(
              builder: (context, prodProv, child) {
                if (prodProv.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (prodProv.products.isEmpty) {
                  return const Center(child: Text("Belum ada produk draft."));
                }

                // Kita gunakan ListView.builder di dalam ListView utama.
                // Agar tidak error, gunakan shrinkWrap: true dan physics: NeverScrollableScrollPhysics.
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: prodProv.products.length,
                  itemBuilder: (context, index) {
                    final item = prodProv.products[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const Icon(Icons.inventory_2),
                        title: Text(item.name),
                        subtitle: Text("Rp ${item.price}"),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade800,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createProduct);
        },
      ),
    );
  }
}
