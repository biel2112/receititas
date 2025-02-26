import 'package:flutter/material.dart';

class TipoCard extends StatelessWidget {
  final String nome;
  final IconData icone;
  final Color cor;
  final VoidCallback onTap;

  const TipoCard({
    super.key,
    required this.nome,
    required this.icone,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cor,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icone,
                size: 50,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                nome,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
