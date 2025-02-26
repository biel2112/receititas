import 'package:flutter/material.dart';
import 'package:receititas/pages/cadastrar_receita.dart';
import 'package:receititas/pages/detalhes_receitas.dart';
import 'package:receititas/pages/editar_receita.dart';
import 'package:receititas/pages/tela_tipos_receitas.dart'; // Importe a tela de tipos de receita
import 'package:receititas/services/receita_service.dart';
import '../models/receita.dart';

class ListaReceitasScreen extends StatefulWidget {
  const ListaReceitasScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ListaReceitasScreenState createState() => _ListaReceitasScreenState();
}

class _ListaReceitasScreenState extends State<ListaReceitasScreen> {
  final ReceitaService _receitaService = ReceitaService();
  List<Receita> _receitas = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _carregarReceitas();
  }

  Future<void> _carregarReceitas() async {
    setState(() {
      _isLoading = true; // Defina uma variável de controle para o carregamento
    });

    // Exibe o CircularProgressIndicator por um tempo máximo (exemplo: 3 segundos)
    await Future.delayed(Duration(seconds: 2));

    List<Receita> receitas = await _receitaService.listarReceitas();
    setState(() {
      _receitas = receitas;
      _isLoading = false; // Finaliza o carregamento
    });
  }

  void _abrirCadastroReceita() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroReceitaScreen(),
      ),
    );
    _carregarReceitas(); // Recarrega a lista ao voltar
  }

  void _editarReceita(int index) async {
    // Navega para a tela de edição, passando a receita a ser editada
    Receita? receitaEditada = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarReceitaScreen(receita: _receitas[index]),
      ),
    );

    // Verifica se a receitaEditada não é null antes de atualizar a lista
    if (receitaEditada != null) {
      setState(() {
        _receitas[index] = receitaEditada;
      });
    }
  }

  // Função para excluir uma receita
  void _excluirReceita(int index) async {
    // Exclui a receita do banco de dados
    await _receitaService.deletarReceita(_receitas[index].id!);

    // Atualiza a lista de receitas após a exclusão
    setState(() {
      _receitas.removeAt(index); // Remove da lista após a exclusão
    });

    // Exibe uma mensagem de sucesso
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Receita excluída com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas',
            style: TextStyle(fontFamily: 'DancingScript', fontSize: 30)),
        backgroundColor: const Color.fromARGB(255, 255, 128, 0),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Color.fromARGB(255, 255, 250, 209),
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: _receitas.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_receitas[index].id.toString()),
                    direction: DismissDirection
                        .endToStart, // Define a direção para deslizar
                    onDismissed: (direction) {
                      _excluirReceita(index); // Exclui a receita
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(12.0), // Bordas arredondadas
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // Sombra suave
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text(
                          _receitas[index].nome,
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 128, 0),
                          ),
                        ),
                        subtitle: Text(
                          'Toque para ver detalhes',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit,
                              color: Color.fromARGB(255, 255, 128, 0)),
                          onPressed: () => _editarReceita(
                              index), // Abre o formulário de edição
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesReceitaScreen(
                                  receita: _receitas[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: Stack(
        children: [
          // Botão de tipos de receitas posicionado no canto inferior esquerdo
          Positioned(
            bottom: 16,
            left: 50,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TelaTiposReceitas(), // Tela de tipos de receitas
                  ),
                );
              },
              backgroundColor: Colors.blue, // Cor do botão de categoria
              child: Icon(Icons.category,
                  color: Colors.white), // Ícone de categoria
            ),
          ),
          // Botão de adicionar receita posicionado no canto inferior direito
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _abrirCadastroReceita,
              backgroundColor: const Color.fromARGB(255, 255, 128, 0),
              tooltip: 'Adicionar Receita',
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
