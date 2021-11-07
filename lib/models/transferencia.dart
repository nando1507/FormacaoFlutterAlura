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
