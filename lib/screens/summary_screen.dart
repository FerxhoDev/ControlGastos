import 'package:flutter/material.dart';
import 'package:gestapp/models/expense_data.dart';
import 'package:gestapp/screens/transaction_form_screen.dart';
import 'package:gestapp/screens/transaction_history_screen.dart';
import 'package:gestapp/widgets/expense_chart.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<ExpenseData> expenses = [
    ExpenseData("Comida", 500),
    ExpenseData("Salud", 700),
    ExpenseData("Entreten", 300),
    ExpenseData("Transp", 450),
    ExpenseData("otros", 600),
  ];

  
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
              const Card(
                child: ListTile(
                  leading: Icon(Icons.arrow_upward_rounded, color: Colors.green,),
                  title: Text('Ingresos'),
                  subtitle: Text('S/ 100.00'),
                ),
              ),
              const SizedBox(height: 10),
              const Card(
                child: ListTile( 
                  leading: Icon(Icons.arrow_downward_outlined, color: Colors.red,),
                  title: Text('Gastos'),
                  subtitle: Text('S/ 100.00'),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(211, 2, 23, 41),
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                child: LineChartSample2(expenses: expenses),
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