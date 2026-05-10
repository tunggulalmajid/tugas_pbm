import 'package:flutter/material.dart';
import 'package:tugas_pbm/widgets/w_button.dart';
import 'package:tugas_pbm/widgets/w_header.dart';
import 'package:tugas_pbm/widgets/w_text_form_field.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  GlobalKey _key = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: WHeader(
          judul: "Create Product",
          deskripsi: "Halaman Tambah Produk",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Form(
                key: _key,
                child: Column(
                  children: [
                    WTextFormField(
                      hintText: "product name",
                      controller: nameController,
                    ),
                    WTextFormField(
                      hintText: "price",
                      controller: priceController,
                      keyboardType: .number,
                    ),
                    WTextFormField(
                      hintText: "description",
                      controller: descController,
                    ),
                    SizedBox(height: 20),
                    WButton(
                      text: "Create",
                      textColor: Colors.white,
                      backgroundColor: Colors.indigo.shade800,
                      onPressed: () {},
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
