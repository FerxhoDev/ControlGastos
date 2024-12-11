import 'package:flutter/material.dart';
import 'package:gestapp/screens/transaction_form_screen.dart';
import 'package:gestapp/widgets/expense_chart.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de movimientos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Resumen de movimientos', style: TextStyle(fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
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
                child: const LineChartSample2(),
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