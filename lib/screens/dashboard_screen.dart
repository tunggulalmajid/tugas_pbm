import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_pbm/providers/auth_provider.dart';
import 'package:tugas_pbm/providers/products_provider.dart';
import 'package:tugas_pbm/utils/app_routes.dart';
import 'package:tugas_pbm/widgets/w_button.dart';
import 'package:tugas_pbm/widgets/w_card.dart';
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
    Future.microtask(() => context.read<ProductProvider>().fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 25),

            Consumer<AuthProvider>(
              builder: (context, authProv, child) {
                if (authProv.user == null) {
                  return const WHeader(judul: "...", deskripsi: "...");
                }
                return WHeader(
                  judul: "Halo, ${authProv.user!.name.split(' ')[0]}",
                  deskripsi:
                      "NIM: ${authProv.user!.username} • Class: ${authProv.user!.classData.name}",
                );
              },
            ),

            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Daftar Produk",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.read<ProductProvider>().fetchProducts(),
                  child: const Text("Refresh"),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Consumer<ProductProvider>(
              builder: (context, prodProv, child) {
                if (prodProv.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (prodProv.products.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Column(
                        children: [
                          Icon(
                            Icons.inventory_2_outlined,
                            size: 60,
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 10),
                          const Text("Belum ada produk draft."),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: prodProv.products.length,
                  itemBuilder: (context, index) {
                    final item = prodProv.products[index];
                    return WCard(item: item, onTap: () {});
                  },
                );
              },
            ),
            SizedBox(height: 10),
            WButton(
              text: "Submit",
              textColor: Colors.white,
              backgroundColor: Colors.indigo.shade800,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.submit);
              },
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo.shade800,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createProduct);
        },
        label: const Text("Tambah", style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
