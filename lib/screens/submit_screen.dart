import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_pbm/DTO/submit_request.dart';
import 'package:tugas_pbm/providers/submit_provider.dart'; // Import provider baru
import 'package:tugas_pbm/widgets/w_button.dart';
import 'package:tugas_pbm/widgets/w_failed_dialog.dart';
import 'package:tugas_pbm/widgets/w_header.dart';
import 'package:tugas_pbm/widgets/w_success_dialog.dart';
import 'package:tugas_pbm/widgets/w_text_form_field.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController githubController = TextEditingController();

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<SubmitProvider>(context, listen: false);

      // Pastikan SubmitRequest kamu punya field link_github atau sesuai API
      SubmitRequest submitParams = SubmitRequest(
        name: nameController.text,
        price: double.tryParse(priceController.text) ?? 0,
        description: descController.text,
        githubUrl: githubController.text,
      );

      bool success = await provider.submitTugas(submitParams);

      if (success && mounted) {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => WSuccessDialog(
            message: "Tugas Berhasil Disubmit!",
            onOkPressed: () {
              Navigator.pop(c);
            },
          ),
        );
        if (mounted) Navigator.pop(context);
      } else if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) => WFailedDialog(
            message: "Gagal Submit Tugas",
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
    githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mengamati isLoading dari SubmitProvider
    final isLoading = context.watch<SubmitProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const WHeader(
                judul: "Submit Task",
                deskripsi: "Form Submit Task PBM",
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    WTextFormField(
                      hintText: "Product Name",
                      controller: nameController,
                      validator: (value) => (value == null || value.isEmpty)
                          ? "Nama produk wajib diisi"
                          : null,
                    ),
                    const SizedBox(height: 12),
                    WTextFormField(
                      hintText: "Price",
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harga wajib diisi";
                        }
                        if (double.tryParse(value) == null) {
                          return "Harus berupa angka";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    WTextFormField(
                      hintText: "Description",
                      controller: descController,
                      maxline: 2,
                      validator: (value) => (value == null || value.isEmpty)
                          ? "Deskripsi wajib diisi"
                          : null,
                    ),
                    const SizedBox(height: 12),
                    WTextFormField(
                      hintText: "Link Github",
                      controller: githubController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Link Github wajib diisi";
                        }
                        if (!value.contains("github.com")) {
                          return "Masukkan link Github yang valid";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 35),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : WButton(
                            text: "Submit",
                            textColor: Colors.white,
                            backgroundColor: Colors.indigo.shade800,
                            onPressed: handleSubmit,
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
