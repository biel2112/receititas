import 'package:flutter/material.dart';
import 'package:receititas/pages/receitas_filtradas.dart';
import 'package:receititas/widgets/card_receitas_filtradas.dart';

class TelaTiposReceitas extends StatelessWidget {
  final List<Map<String, dynamic>> tipos = [
    {
      'nome': 'Sobremesa',
      'icone': Icons.cake,
      'cor': Colors.pink,
    },
    {
      'nome': 'Refeição',
      'icone': Icons.restaurant,
      'cor': Colors.orange,
    },
    {
      'nome': 'Bebida',
      'icone': Icons.local_bar,
      'cor': Colors.blue,
    },
  ];

  TelaTiposReceitas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tipos de Receitas'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.2,
        ),
        itemCount: tipos.length,
        itemBuilder: (context, index) {
          return TipoCard(
            nome: tipos[index]['nome'],
            icone: tipos[index]['icone'],
            cor: tipos[index]['cor'],
            onTap: () {
              // Navega para a tela de receitas filtradas passando o tipo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ReceitasFiltradasScreen(tipo: tipos[index]['nome']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
