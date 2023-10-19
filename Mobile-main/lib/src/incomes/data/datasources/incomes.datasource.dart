import 'package:dio/dio.dart';
import 'package:mobile/commons/extensions.dart';
import '../models/incomes.model.dart';

abstract class IncomesDataSource {
  final Dio _dio = Dio();

  Future<IncomeModel> createIncome(IncomeModel incomes);
}

class IncomesServices extends IncomesDataSource {
  final Dio _dio = Dio();
  @override
  Future<IncomeModel> createIncome(IncomeModel incomes) async {
    final response = await Future.delayed(
      const Duration(seconds: 2),
          () {
        return {
          "description": incomes.transactionDescriptionType,
          "amount": incomes.amount,
          "expenseType": incomes.expenseDate,
          "expenseDate": incomes.transactionType,
          "userId": incomes.transactionType,
        };
      },
    );

    final createdHistorical = IncomeModel.fromJson(response);

    return createdHistorical;
  }
}
