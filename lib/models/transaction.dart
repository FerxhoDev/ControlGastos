enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String category;
  final double amount;
  final TransactionType type;
  final String description;
  final DateTime date;

  Transaction( 
    {
    required this.id,
    required this.category,
    required this.amount,
    required this.type,
    required this.description,
    required this.date
    }
  );
}
