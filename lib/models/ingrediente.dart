class Ingrediente {
  int? id;
  String nome;
  String quantidade;
  String medida;
  int? receitaId;

  Ingrediente({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.medida,
    required this.receitaId,
  });

  Ingrediente copyWith({
    int? id,
    String? nome,
    String? quantidade,
    String? medida,
    int? receitaId,
  }) {
    return Ingrediente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      quantidade: quantidade ?? this.quantidade,
      medida: medida ?? this.medida,
      receitaId: receitaId ?? this.receitaId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'medida': medida,
      'receita_id': receitaId,
    };
  }

  factory Ingrediente.fromMap(Map<String, dynamic> map) {
    return Ingrediente(
      id: map['id'],
      nome: map['nome'],
      quantidade: map['quantidade'],
      medida: map['medida'],
      receitaId: map['receita_id'],
    );
  }
}
