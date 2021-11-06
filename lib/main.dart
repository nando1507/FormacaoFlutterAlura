import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const BytebankApp());

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
        //body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoDigitoConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criando Transferencia'),
      ),
      body: Column(
        children: <Widget>[
          Editor(controlador: _controladorCampoNumeroConta, rotulo: 'Número da Conta', dica: '0000000'),
          Editor(controlador: _controladorCampoDigitoConta, rotulo: 'Digito da Conta', dica: '0'),
          Editor(controlador: _controladorCampoValor, rotulo: 'Valor', dica: '0.00', icone: Icons.monetization_on),
          ElevatedButton(
              onPressed: () {
                _criaTransferencia(context);
              },
              child: const Text(
                'Confirmar',
                textDirection: TextDirection.ltr,
              ))
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final int? digitoConta = int.tryParse(_controladorCampoDigitoConta.text);
    final double? valorConta = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valorConta != null && digitoConta != null) {
      final transferenciaCriada = Transferencia(valorConta, numeroConta, digitoConta);

      debugPrint('Criando transferencia');
      debugPrint('$transferenciaCriada');

      // Scaffold.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('$transferenciaCriada'),
      //   ),
      // );
      ItemTransferencia(transferenciaCriada);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}

class ListaTransferenciaState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    widget._transferencias.add(Transferencia(10, 1000, 1));

    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            if (transferenciaRecebida != null) {
              widget._transferencias.add(transferenciaRecebida);
            }
            debugPrint('Chegou no then do future');
            debugPrint('$transferenciaRecebida');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on_outlined),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString().padLeft(7, '0') + '-' + _transferencia.numeroContaDigito.toString()),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;
  final int numeroContaDigito;

  Transferencia(this.valor, this.numeroConta, this.numeroContaDigito);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta, numeroContaDigito: $numeroContaDigito}';
  }
}
