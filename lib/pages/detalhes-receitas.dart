import 'package:flutter/material.dart';
import 'package:receititas/models/receita.dart';

class DetalhesReceitaScreen extends StatelessWidget {
  final Receita receita;

  DetalhesReceitaScreen({required this.receita});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 128, 0),
          title: Text(
            receita.nome,
            style: TextStyle(
              fontFamily: 'DancingScript', // Fonte de letra de mão
            ),
          )),
      body: Container(
        color: const Color.fromARGB(255, 255, 250, 209),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 128, 0),
                    borderRadius:
                        BorderRadius.circular(8.0), // Bordas arredondadas
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Sombra suave
                      ),
                    ]),
                child: Text('Ingredientes:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              ...receita.ingredientes
                  .map((ing) => Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                            '- ${ing.quantidade} ${ing.medida} de ${ing.nome}',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'DancingScript', // Fonte de letra de mão
                            ),
                          ),
                    ),
                  ))
                  .toList(),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 128, 0),
                    borderRadius:
                        BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ]),
                child: Text('Modo de Preparo:',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  receita.modoDePreparo,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'DancingScript',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
