import 'package:flutter/material.dart';
import 'package:gestapp/models/expense_data.dart';
import 'package:gestapp/models/transaction.dart';
import 'package:gestapp/provider/transaction_provider.dart';
import 'package:gestapp/screens/transaction_form_screen.dart';
import 'package:gestapp/screens/transaction_history_screen.dart';
import 'package:gestapp/widgets/expense_chart.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    final totalIncome = transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);

    final totalExpense = transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .fold(0.0, (sum, transaction) => sum + transaction.amount);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de movimientos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('Resumen de movimientos', style: TextStyle(fontWeight: FontWeight.bold),),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // ir a TransactionHistoryScreen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionHistoryScreen()));
                    },
                    icon: const Icon(Icons.history),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.arrow_upward_rounded, color: Colors.green,),
                  title: const Text('Ingresos'),
                  subtitle: Text('Q $totalIncome'),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: ListTile( 
                  leading: const Icon(Icons.arrow_downward_outlined, color: Colors.red,),
                  title: const Text('Gastos'),
                  subtitle: Text('Q $totalExpense'),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(211, 2, 23, 41),
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: LineChartSample2(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          // ir a TransactionFormScreen
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionFormScreen()));
        },
        icon: const Icon(Icons.add, color: Colors.white,),
        label: const Text('Agregar movimiento', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}