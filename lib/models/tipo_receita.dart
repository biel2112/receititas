enum TipoReceita {
  refeicao,
  sobremesa,
  bebida,
}

Map<int, TipoReceita> tipoReceitaMap = {
  1: TipoReceita.refeicao,
  2: TipoReceita.sobremesa,
  3: TipoReceita.bebida,
};

Map<TipoReceita, int> tipoReceitaIdMap = {
  TipoReceita.refeicao: 1,
  TipoReceita.sobremesa: 2,
  TipoReceita.bebida: 3,
};
