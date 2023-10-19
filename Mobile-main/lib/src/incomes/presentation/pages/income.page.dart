final income = IncomeEntity(
  description: 'Pago alquiler',
  amount: 25.50,
  expenseType: 'Salary',
  expenseDate: '13-10-2023',
  userId: 22,
);

await incomeRepository.registerIncome(income);