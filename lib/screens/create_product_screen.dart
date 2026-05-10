import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_pbm/DTO/create_product_request.dart';
import 'package:tugas_pbm/providers/products_provider.dart';
import 'package:tugas_pbm/widgets/w_button.dart';
import 'package:tugas_pbm/widgets/w_failed_dialog.dart';
import 'package:tugas_pbm/widgets/w_header.dart';
import 'package:tugas_pbm/widgets/w_success_dialog.dart';
import 'package:tugas_pbm/widgets/w_text_form_field.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  void handleCreate() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<ProductProvider>(context, listen: false);

      CreateProductRequest productParams = CreateProductRequest(
        name: nameController.text,
        price: double.tryParse(priceController.text) ?? 0,
        description: descController.text,
      );

      bool success = await provider.createProduct(productParams);

      if (success && mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => WSuccessDialog(
            message: "Produk Berhasil Ditambahkan",
            onOkPressed: () {
              Navigator.pop(c);
            },
          ),
        );
        if (mounted) {
          Navigator.pop(context);
        }
      } else if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => WFailedDialog(
            message: "Gagal Menambahkan Produk",
            onOkPressed: () {
              Navigator.pop(c);
            },
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<ProductProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const WHeader(
                judul: "Create Product",
                deskripsi: "Form Create Product",
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    WTextFormField(
                      hintText: "Product Name",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nama produk tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    WTextFormField(
                      hintText: "Price",
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harga tidak boleh kosong";
                        }
                        if (double.tryParse(value) == null) {
                          return "Harga harus berupa angka";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    WTextFormField(
                      hintText: "Description",
                      controller: descController,
                      maxline: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Deskripsi tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : WButton(
                            text: "Create Product",
                            textColor: Colors.white,
                            backgroundColor: Colors.indigo.shade800,
                            onPressed: handleCreate,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
