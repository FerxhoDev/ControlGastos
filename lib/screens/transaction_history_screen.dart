import 'package:flutter/material.dart';
import 'package:gestapp/models/transaction.dart';
import 'package:gestapp/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de movimientos'),
        centerTitle: true,
      ),
      body: transactions.isEmpty
          ? const Center(
              child: Text('No hay movimientos registrados'),
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(transaction.category),
                        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
                        leading: Icon(
                          transaction.type == TransactionType.income
                              ? Icons.arrow_upward_rounded
                              : Icons.arrow_downward_rounded,
                          color: transaction.type == TransactionType.income
                              ? Colors.green
                              : Colors.red,
                        ),
                        trailing: Text('Q ${transaction.amount.toStringAsFixed(2)}', 
                        style: TextStyle(color: transaction.type == TransactionType.income? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,), 
                        ),
                        onLongPress: (){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Eliminar movimiento'),
                              content: const Text('¿Estás seguro de eliminar este movimiento?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                    transactionProvider.removeTransaction(transaction);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Movimiento eliminado'),
                                        action: SnackBarAction(
                                          label: 'Deshacer',
                                          onPressed: (){
                                            transactionProvider.addTransaction(transaction);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Eliminar'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0 ,bottom: 8.0),
                        child: Text(transaction.description, style: const TextStyle(color: Colors.grey),),
                      ),
                    ],
                  ),
                );
              },
            ),

    );
  }
}
