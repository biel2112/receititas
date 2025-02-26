import 'package:receititas/models/ingrediente.dart';

enum TipoReceita {
  sobremesa,
  refeicao,
  bebida,
}

String tipoReceitaToString(TipoReceita tipo) {
  switch (tipo) {
    case TipoReceita.sobremesa:
      return 'Sobremesa';
    case TipoReceita.refeicao:
      return 'Refeição';
    case TipoReceita.bebida:
      return 'Bebida';
  }
}

TipoReceita stringToTipoReceita(String tipo) {
  switch (tipo.toLowerCase()) {
    case 'sobremesa':
      return TipoReceita.sobremesa;
    case 'refeição':
    case 'refeicao': // Tratando sem acento também
      return TipoReceita.refeicao;
    case 'bebida':
      return TipoReceita.bebida;
    default:
      throw ArgumentError('Tipo de receita inválido: $tipo');
  }
}

class Receita {
  int? id;
  TipoReceita tipoReceita;
  String nome;
  List<Ingrediente> ingredientes;
  String modoDePreparo;

  Receita({
    required this.id,
    required this.tipoReceita,
    required this.nome,
    required this.ingredientes,
    required this.modoDePreparo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipoReceita':
          tipoReceitaToString(tipoReceita), // Convertendo para string ao salvar
      'nome': nome,
      'ingredientes': ingredientes.map((i) => i.toMap()).toList().toString(),
      'modoDePreparo': modoDePreparo,
    };
  }

  factory Receita.fromMap(Map<String, dynamic> map) {
    return Receita(
      id: map['id'],
      tipoReceita: stringToTipoReceita(map['tipoReceita'] ??
          'sobremesa'), // Valor padrão caso o tipo seja null
      nome: map['nome'] ?? '', // Valor padrão caso o nome seja null
      ingredientes: [], // Ingredientes devem ser buscados separadamente
      modoDePreparo: map['modoDePreparo'] ??
          '', // Valor padrão caso o modo de preparo seja null
    );
  }
}
