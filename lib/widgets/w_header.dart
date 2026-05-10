import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WHeader extends StatelessWidget {
  final String judul;
  final String deskripsi;

  const WHeader({super.key, required this.judul, required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: GoogleFonts.poppins(fontWeight: .bold, fontSize: 30),
              ),
              Text(
                deskripsi,
                style: GoogleFonts.poppins(fontWeight: .w500, fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
