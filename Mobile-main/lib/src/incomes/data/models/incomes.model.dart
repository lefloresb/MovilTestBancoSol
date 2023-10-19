import '../../domain/entities/incomes.entity.dart';

class IncomeModel extends IncomeEntity {
  IncomeModel({
    required String description,
    required double amount,
    required String expenseType,
    required String expenseDate,
    required int userId,
  }) : super (
    description: description,
    amount: amount,
    expenseType: expenseType,
    expenseDate: expenseDate,
    userId: userId,
  );

  factory IncomeModelModel.fromJson(Map<String, dynamic> json) {
    return IncomeModelModel(
      description: json['description'],
      amount: json['amount'],
      expenseType: json['expenseType'],
      expenseDate: json['expenseDate'].toString().split('T')[0],
      userId: json['userId'],
    );
  }
}