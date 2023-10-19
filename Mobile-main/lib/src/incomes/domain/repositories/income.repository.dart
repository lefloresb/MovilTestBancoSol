import 'package:mobile/data/datasources/income.datasource.dart';
import 'package:mobile/data/models/income.model.dart';
import 'package:mobile/domain/entities/income.entity.dart';
import 'package:mobile/domain/repositories/income.repository.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final IncomesDataSource _service;

  IncomeRepositoryImpl(this._service);

  @override
  Future<void> registerIncome(IncomeEntity income) async {
    final incomeModel = IncomeModel.fromEntity(income);
    await _service.registerIncome(incomeModel);
  }
}