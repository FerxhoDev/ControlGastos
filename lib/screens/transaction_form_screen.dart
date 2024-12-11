import 'package:flutter/material.dart';
import 'package:gestapp/models/transaction.dart';
import 'package:gestapp/provider/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TransactionFormScreen extends StatefulWidget {
  const TransactionFormScreen({super.key});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Comida';
  TransactionType _selectedType = TransactionType.expense;

  final List<String> _categories = [
    'Comida',
    'Transporte',
    'Salud',
    'Educación',
    'Entretenimiento',
    'Otros'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar movimiento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Monto',
                    hintText: '0.00',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese un monto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    hintText: 'Descripción del movimiento',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                  ),
                  value: _selectedCategory,
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                        child: RadioListTile(
                      activeColor: Colors.blue[900],
                      title: const Text(
                        'Gasto',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      value: TransactionType.expense,
                      groupValue: _selectedType,
                      onChanged: (TransactionType? value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    )),
                    Expanded(
                        child: RadioListTile(
                      activeColor: Colors.blue[900],
                      title: const Text(
                        'Ingreso',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      value: TransactionType.income,
                      groupValue: _selectedType,
                      onChanged: (TransactionType? value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    )),
                  ],
                ),
                const SizedBox(height: 16.0),
                Center(
                    child: ElevatedButton(
                        child: const Text(
                          'Guardar',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final newTransaction = Transaction(
                                id: const Uuid().v4(),
                                category: _selectedCategory,
                                amount: double.parse(_amountController.text),
                                description: _descriptionController.text,
                                type: _selectedType,
                                date: DateTime.now());
                            Provider.of<TransactionProvider>(context, listen: false)
                                .addTransaction(newTransaction);
                          
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Guardando movimiento...')));
                            Navigator.pop(context);
                          }
                        }))
              ],
            )),
      ),
    );
  }
}
