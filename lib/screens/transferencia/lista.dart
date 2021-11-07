import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:intl/intl.dart';
import 'formulario.dart';

const _tituloAppBar = 'Transferências';

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  ListaTransferencias({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    //widget._transferencias.add(Transferencia(10, 1000, 1));

    return Scaffold(
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _atualiza(Transferencia? transferenciaRecebida) {
    Future.delayed(const Duration(milliseconds: 250), () {
      if (transferenciaRecebida != null) {
        setState(() {
          widget._transferencias.add(transferenciaRecebida);
        });
      }
    });
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  const ItemTransferencia(this._transferencia, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on_outlined),
        title: Text(getCurrency(_transferencia.valor)),
        subtitle: Text(_transferencia.numeroConta.toString().padLeft(7, '0') + '-' + _transferencia.numeroContaDigito.toString()),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}

String getCurrency(double value) {
  NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
  return formatter.format(value);
}