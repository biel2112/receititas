import 'package:flutter/material.dart';
import 'package:receititas/services/receita_service.dart';
import '../models/receita.dart';
import 'package:receititas/models/ingrediente.dart';

class EditarReceitaScreen extends StatefulWidget {
  final Receita receita;

  const EditarReceitaScreen({super.key, required this.receita});

  @override
  // ignore: library_private_types_in_public_api
  _EditarReceitaScreenState createState() => _EditarReceitaScreenState();
}

class _EditarReceitaScreenState extends State<EditarReceitaScreen> {
  final _formKey = GlobalKey<FormState>();
  late Receita _receita;
  final ReceitaService _receitaService = ReceitaService();
  List<Ingrediente> _ingredientes = [];

  @override
  void initState() {
    super.initState();
    _receita = widget.receita;
    _ingredientes =
        List.from(_receita.ingredientes); // Carrega os ingredientes da receita
  }

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
      _formKey.currentState!.save();

      // Atualiza os dados da receita com os ingredientes editados
      _receita.ingredientes = _ingredientes;

      // Atualiza a receita no banco de dados
      await _receitaService.editarReceita(_receita);

      // Exibe a mensagem de sucesso
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Receita editada com sucesso!')),
      );

      // Retorna para a tela anterior
      // ignore: use_build_context_synchronously
      Navigator.pop(context, _receita);
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
          'Editar Receita',
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
                  initialValue: _receita.nome,
                  decoration: _inputDecoration('Nome da Receita'),
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                  onSaved: (value) => _receita.nome = value!,
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
                    ],
                  ),
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
                                initialValue: _ingredientes[index].nome,
                                decoration: _inputDecoration('Ingrediente'),
                                onChanged: (value) {
                                  _ingredientes[index] = _ingredientes[index]
                                      .copyWith(nome: value);
                                },
                                validator: (value) =>
                                    value!.isEmpty ? 'Campo obrigatório' : null,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                initialValue: _ingredientes[index].quantidade,
                                decoration: _inputDecoration('Quantidade'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  _ingredientes[index] = _ingredientes[index]
                                      .copyWith(quantidade: value);
                                },
                                validator: (value) =>
                                    value!.isEmpty ? 'Campo obrigatório' : null,
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                initialValue: _ingredientes[index].medida,
                                decoration: _inputDecoration('Medida'),
                                onChanged: (value) {
                                  _ingredientes[index] = _ingredientes[index]
                                      .copyWith(medida: value);
                                },
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
                    mini: true,
                    tooltip: 'Adicionar Ingrediente',
                    child: Icon(Icons.add),
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
                    ],
                  ),
                  child: Text('Modo de Preparo',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: _receita.modoDePreparo,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Descreva o modo de preparo da receita...',
                  ),
                  maxLines: 5,
                  validator: (value) =>
                      value!.isEmpty ? 'Campo obrigatório' : null,
                  onSaved: (value) => _receita.modoDePreparo = value!,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _salvarReceita,
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(fontSize: 16),
                      backgroundColor: Color.fromARGB(255, 255, 128, 0),
                    ),
                    child: Text('Salvar Receita'),
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
