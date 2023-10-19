import 'package:mobile/data/datasources/income.datasource.dart';
import 'package:mobile/data/models/income.model.dart';
import 'package:mobile/domain/entities/income.entity.dart';
import 'package:mobile/domain/repositories/income.repository.dart';

class IncomeRepositoryImpl implements IncomeRepository {
  final IncomeDataSource _service;

  IncomeRepositoryImpl(this._service);

  @override
  Future<void> registerIncome(IncomeEntity income) async {
    // Aquí debes implementar la lógica para registrar un ingreso en la fuente de datos (_service).
    // Por ejemplo, puedes convertir el objeto "income" en un modelo y enviarlo a la fuente de datos.
    final incomeModel = IncomeModel.fromEntity(income);
    await _service.registerIncome(incomeModel);
  }
}
Define la fuente de datos (IncomeDataSource) en el paquete data para manejar la lógica de registro de ingresos. Asegúrate de que IncomeDataSource tenga un método para registrar ingresos, similar a lo que se hizo en HistoricalDataSource.

Finalmente, en la capa de presentación (paquete presentation), puedes utilizar el repositorio de ingresos para registrar un ingreso:

dart
Copy code
final income = IncomeEntity(
  description: 'Pago alquiler',
  amount: 25.50,
  expenseType: 'Salary',
  expenseDate: '13-10-2023',
  userId: 22,
);

await incomeRepository.registerIncome(income);
Esto te permitirá registrar un ingreso utilizando Clean Architecture. Asegúrate de que la lógica de registro de ingresos en la fuente de datos (IncomeDataSource) esté correctamente implementada según tus necesidades.





