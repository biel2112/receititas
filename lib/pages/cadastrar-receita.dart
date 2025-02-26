import 'package:flutter/material.dart';
import 'package:receititas/models/ingrediente.dart';
import 'package:receititas/models/receita.dart';
import 'package:receititas/services/receita-service.dart';

class CadastroReceitaScreen extends StatefulWidget {
  
  @override
  _CadastroReceitaScreenState createState() => _CadastroReceitaScreenState();
}

class _CadastroReceitaScreenState extends State<CadastroReceitaScreen> {
  final ReceitaService _receitaService = ReceitaService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _modoPreparoController = TextEditingController();
  List<Ingrediente> _ingredientes = [
    Ingrediente(id: null, nome: '', quantidade: '', medida: '', receitaId: null)
  ];

  void _adicionarIngrediente() {
    setState(() {
      _ingredientes.add(Ingrediente(
          id: null, nome: '', quantidade: '', medida: '', receitaId: null));
    });
  }

  void _removerIngrediente(int index) {
    setState(() {
      _ingredientes.removeAt(index);
    });
  }

  void _salvarReceita() async {
    if (_formKey.currentState!.validate()) {
      Receita novaReceita = Receita(
        id: null,
        nome: _nomeController.text,
        ingredientes: _ingredientes,
        modoDePreparo: _modoPreparoController.text,
      );
      await _receitaService.adicionarReceita(novaReceita);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Receita salva com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.orange, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.orange, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nova Receita',
          style: TextStyle(fontFamily: 'DancingScript', fontSize: 30),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 128, 0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: _inputDecoration('Nome da Receita'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                SizedBox(height: 20),
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
                  child: Text('Ingredientes',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                Column(
                  children: _ingredientes.asMap().entries.map((entry) {
                    int index = entry.key;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: _inputDecoration('Ingrediente'),
                                onChanged: (value) => _ingredientes[index] =
                                    _ingredientes[index].copyWith(nome: value),
                                validator: (value) =>
                                    value!.isEmpty ? 'Campo obrigatório' : null,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                decoration: _inputDecoration('Quantidade'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) => _ingredientes[index] =
                                    _ingredientes[index]
                                        .copyWith(quantidade: value),
                                validator: (value) =>
                                    value!.isEmpty ? 'Campo obrigatório' : null,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                decoration: _inputDecoration('Medida'),
                                onChanged: (value) => _ingredientes[index] =
                                    _ingredientes[index]
                                        .copyWith(medida: value),
                                validator: (value) =>
                                    value!.isEmpty ? 'Campo obrigatório' : null,
                              ),
                            ),
                            if (index > 0)
                              IconButton(
                                icon: Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () => _removerIngrediente(index),
                              ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  }).toList(),
                ),
                Center(
                  child: FloatingActionButton(
                    onPressed: _adicionarIngrediente,
                    backgroundColor: const Color.fromARGB(255, 255, 128, 0),
                    child: Icon(Icons.add),
                    mini: true,
                    tooltip: 'Adicionar Ingrediente',
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
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
                  child: Text('Modo de Preparo',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _modoPreparoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Descreva o modo de preparo da receita...',
                  ),
                  maxLines: 5,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _salvarReceita,
                    child: Text('Salvar Receita', style: TextStyle(color: 
                  const Color.fromARGB(255, 255, 128, 0),
                    ),),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
