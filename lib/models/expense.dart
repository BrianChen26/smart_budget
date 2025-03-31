class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Expense({required this.id, required this.title, required this.amount, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  static Expense fromMap(String id, Map<String, dynamic> data) {
    return Expense(
      id: id,
      title: data['title'],
      amount: data['amount'],
      date: DateTime.parse(data['date']),
    );
  }
}
