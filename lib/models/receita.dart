import 'package:receititas/models/ingrediente.dart';

class Receita {
  int? id;
  String nome;
  List<Ingrediente> ingredientes;
  String modoDePreparo;

  Receita({
    required this.id,
    required this.nome,
    required this.ingredientes,
    required this.modoDePreparo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'ingredientes': ingredientes.map((i) => i.toMap()).toList().toString(),
      'modo_preparo': modoDePreparo,
    };
  }

  factory Receita.fromMap(Map<String, dynamic> map) {
    return Receita(
      id: map['id'],
      nome: map['nome'],
      ingredientes: [], // Ingredientes devem ser buscados separadamente pelo `IngredienteDao`
      modoDePreparo: map['modo_preparo'],
    );
  }
}
