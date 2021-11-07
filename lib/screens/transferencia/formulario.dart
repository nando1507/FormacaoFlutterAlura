import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

import 'lista.dart';

const _tituloAppBar = 'Criando Transferencia';

const _rotuloCampoNumeroConta = 'Número da Conta';
const _dicaCampoNumeroConta = '0000000';
const _rotuloCampoNumeroDigito = 'Digito da Conta';
const _dicaCampoNumeroDigito = '0';
const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  const FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta = TextEditingController();
  final TextEditingController _controladorCampoDigitoConta = TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
            ),
            Editor(
              controlador: _controladorCampoDigitoConta,
              rotulo: _rotuloCampoNumeroDigito,
              dica: _dicaCampoNumeroDigito,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
                onPressed: () {
                  _criaTransferencia(context);
                },
                child: const Text(
                  _textoBotaoConfirmar,
                  textDirection: TextDirection.ltr,
                ))
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final int? digitoConta = int.tryParse(_controladorCampoDigitoConta.text);
    final double? valorConta = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valorConta != null && digitoConta != null) {
      final transferenciaCriada = Transferencia(valorConta, numeroConta, digitoConta);
      //
      // debugPrint('Criando transferencia');
      // debugPrint('$transferenciaCriada');

      ItemTransferencia(transferenciaCriada);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
