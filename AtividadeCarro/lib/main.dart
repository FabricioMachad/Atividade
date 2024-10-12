import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: TelaGerenciamentoVeiculo(),
  ));
}

class TelaGerenciamentoVeiculo extends StatefulWidget {
  @override
  _TelaGerenciamentoVeiculoState createState() => _TelaGerenciamentoVeiculoState();
}

class _TelaGerenciamentoVeiculoState extends State<TelaGerenciamentoVeiculo> {
  // Lista de veículos
  List<Map<String, dynamic>> veiculos = [
    {'nome': 'Selecione um veículo', 'eficiencia': 0.0}
  ];
  Map<String, dynamic>? veiculoSelecionado;

  // Lista de localizações e distâncias
  List<Map<String, dynamic>> localizacoes = [
    {'local': 'Cidade A', 'km': 100},
    {'local': 'Cidade B', 'km': 200},
    {'local': 'Cidade C', 'km': 300},
  ];
  Map<String, dynamic>? localizacaoSelecionada;

  // Lista de tipos de combustível e preços
  List<Map<String, dynamic>> tiposCombustivel = [
    {'tipo': 'Gasolina Comum', 'preco': 5.5},
    {'tipo': 'Gasolina Aditivada', 'preco': 5.9},
    {'tipo': 'Etanol', 'preco': 4.0},
  ];
  Map<String, dynamic>? combustivelSelecionado;

  // Controladores para campos de entrada
  final TextEditingController veiculoNomeController = TextEditingController();
  final TextEditingController veiculoModeloController = TextEditingController();
  final TextEditingController eficienciaCombustivelController = TextEditingController(); // l/km
  final TextEditingController localizacaoController = TextEditingController();
  final TextEditingController kmController = TextEditingController();
  final TextEditingController tipoCombustivelController = TextEditingController();
  final TextEditingController precoCombustivelController = TextEditingController();






  // Função para calcular o custo da viagem
  double calcularCustoViagem(double eficienciaCombustivel, int distancia, double precoCombustivel) {
    return (distancia / eficienciaCombustivel) * precoCombustivel;
  }







  // Função para adicionar veículo
  void adicionarVeiculo() {
    setState(() {
      veiculos.add({
        'nome': '${veiculoNomeController.text} - ${veiculoModeloController.text}',
        'eficiencia': double.parse(eficienciaCombustivelController.text),
      });
      veiculoNomeController.clear();
      veiculoModeloController.clear();
      eficienciaCombustivelController.clear();
    });
    Navigator.of(context).pop();
  }







  // Função para adicionar localização
  void adicionarLocalizacao() {
    setState(() {
      localizacoes.add({
        'local': localizacaoController.text,
        'km': int.parse(kmController.text),
      });
      localizacaoController.clear();
      kmController.clear();
    });
    Navigator.of(context).pop();
  }





  // Função para adicionar tipo de combustível
  void adicionarCombustivel() {
    setState(() {
      tiposCombustivel.add({
        'tipo': tipoCombustivelController.text,
        'preco': double.parse(precoCombustivelController.text),
      });
      tipoCombustivelController.clear();
      precoCombustivelController.clear();
    });
    Navigator.of(context).pop();
  }




  // Função para remover itens da lista
  void removerItemDaLista(List list, int index) {
    setState(() {
      list.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento de Veículos e Viagens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [





            // Dropdown para selecionar o veículo
            Row(
              children: [
                Expanded(
                  child: DropdownButton<Map<String, dynamic>>(
                    value: veiculoSelecionado,
                    hint: Text('Selecione um veículo'),
                    icon: Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.blueAccent,
                    ),
                    onChanged: (Map<String, dynamic>? novoValor) {
                      setState(() {
                        veiculoSelecionado = novoValor;
                      });
                    },
                    items: veiculos.map<DropdownMenuItem<Map<String, dynamic>>>(
                        (Map<String, dynamic> veiculo) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: veiculo,
                        child: Text(veiculo['nome']),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Adicionar Veículo'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: veiculoNomeController,
                                decoration: InputDecoration(labelText: 'Nome do Veículo'),
                              ),
                              TextField(
                                controller: veiculoModeloController,
                                decoration: InputDecoration(labelText: 'Modelo do Veículo'),
                              ),
                              TextField(
                                controller: eficienciaCombustivelController,
                                decoration: InputDecoration(labelText: 'Eficiência (l/km)'),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Adicionar'),
                              onPressed: adicionarVeiculo,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: veiculoSelecionado != null && veiculoSelecionado!['nome'] != 'Selecione um veículo'
                      ? () {
                          setState(() {
                            veiculos.remove(veiculoSelecionado);
                            veiculoSelecionado = null;
                          });
                        }
                      : null,
                ),
              ],
            ),
            SizedBox(height: 20),







            // Dropdown para selecionar a localização e a distância
            Row(
              children: [
                Expanded(
                  child: DropdownButton<Map<String, dynamic>>(
                    value: localizacaoSelecionada,
                    hint: Text('Selecione a localização'),
                    icon: Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.blueAccent,
                    ),
                    onChanged: (Map<String, dynamic>? novoValor) {
                      setState(() {
                        localizacaoSelecionada = novoValor;
                      });
                    },
                    items: localizacoes.map<DropdownMenuItem<Map<String, dynamic>>>(
                        (Map<String, dynamic> localizacao) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: localizacao,
                        child: Text('${localizacao['local']} - ${localizacao['km']} km'),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Adicionar Localização'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: localizacaoController,
                                decoration: InputDecoration(labelText: 'Localização'),
                              ),
                              TextField(
                                controller: kmController,
                                decoration: InputDecoration(labelText: 'Distância (km)'),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Adicionar'),
                              onPressed: adicionarLocalizacao,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: localizacaoSelecionada != null
                      ? () {
                          setState(() {
                            localizacoes.remove(localizacaoSelecionada);
                            localizacaoSelecionada = null;
                          });
                        }
                      : null,
                ),
              ],
            ),
            SizedBox(height: 20),



            // Dropdown para selecionar o tipo de combustível e o preço
            Row(
              children: [
                Expanded(
                  child: DropdownButton<Map<String, dynamic>>(
                    value: combustivelSelecionado,
                    hint: Text('Selecione o tipo de combustível'),
                    icon: Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    underline: Container(
                      height: 2,
                      color: Colors.blueAccent,
                    ),
                    onChanged: (Map<String, dynamic>? novoValor) {
                      setState(() {
                        combustivelSelecionado = novoValor;
                      });
                    },
                    items: tiposCombustivel.map<DropdownMenuItem<Map<String, dynamic>>>(
                        (Map<String, dynamic> combustivel) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: combustivel,
                        child: Text('${combustivel['tipo']} - R\$${combustivel['preco']}'),
                      );
                    }).toList(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Adicionar Combustível'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: tipoCombustivelController,
                                decoration: InputDecoration(labelText: 'Tipo de Combustível'),
                              ),
                              TextField(
                                controller: precoCombustivelController,
                                decoration: InputDecoration(labelText: 'Preço (R\$)'),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Adicionar'),
                              onPressed: adicionarCombustivel,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: combustivelSelecionado != null
                      ? () {
                          setState(() {
                            tiposCombustivel.remove(combustivelSelecionado);
                            combustivelSelecionado = null;
                          });
                        }
                      : null,
                ),
              ],
            ),
            SizedBox(height: 20),





            // Exibição do custo estimado da viagem
            if (veiculoSelecionado != null && localizacaoSelecionada != null && combustivelSelecionado != null)
              Text(
                'Custo da viagem: R\$ ${calcularCustoViagem(veiculoSelecionado!['eficiencia'], localizacaoSelecionada!['km'], combustivelSelecionado!['preco']).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
