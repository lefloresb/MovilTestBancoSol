import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/expenses_bloc.dart';
import 'package:mobile/presentation/widgets/loading.dart';
import 'package:mobile/presentation/widgets/sun_button.dart';
import 'package:mobile/presentation/widgets/sun_date_field.dart';
import 'package:mobile/presentation/widgets/sun_selection_field.dart';
import 'package:mobile/presentation/widgets/sun_text.dart';
import 'package:mobile/presentation/widgets/sun_text_field.dart';

class ExpensesForm extends StatelessWidget {
  final TextEditingController controllerDescription;
  final TextEditingController controllerDestination;
  final TextEditingController controllerAmount;
  final TextEditingController controllerDate;
  final GlobalKey<FormState> formKey;
  final Map<String, String> optionMap;
  final Function updateDateField;
  final Function updateSelectionField;
  final Function getKey;
  final LoadingWidget loading;

  const ExpensesForm({
    Key key,
    this.controllerDescription,
    this.controllerDestination,
    this.controllerAmount,
    this.controllerDate,
    this.formKey,
    this.optionMap,
    this.updateDateField,
    this.updateSelectionField,
    this.getKey,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpensesBloc, ExpensesState>(
      listener: (context, state) {
        switch (state.status) {
          case ExpensesStatus.success:
            loading.hideOverlay();
            showDialogPopUpSuccess(context);
            break;
          case ExpensesStatus.failure:
            loading.hideOverlay();
            showDialogPopUpFailure(context);
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SunText(
                text: 'Ingresa la informacion que desea registrar \n*Campos requeridos',
                style: Theme.of(context).textTheme.labelMedium!,
              ),
              const SizedBox(height: 24),
              SunText(
                text: 'Descripcion de Gasto*',
                style: Theme.of(context).textTheme.labelMedium!,
              ),
              SunTextField(
                controller: controllerDescription,
                validator: (value) {
                  if (value == '' || value!.isEmpty) return '*';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SunText(
                text: 'Destino',
                style: Theme.of(context).textTheme.labelMedium!,
              ),
              const SizedBox(height: 22),
              SunSelectionField(
                optionMap: optionMap,
                controller: controllerDestination,
                voidCallback: updateSelectionField,
                hintText: 'Seleccionar una Fuente de Gastos',
              ),
              const SizedBox(height: 24),
              SunText(
                text: 'Monto',
                style: Theme.of(context).textTheme.labelMedium!,
              ),
              SunTextField(
                controller: controllerAmount,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              SunText(
                text: 'Fecha',
                style: Theme.of(context).textTheme.labelMedium!,
              ),
              SunDateField(
                controller: controllerDate,
                voidCallback: updateDateField,
              ),
              const Spacer(),
              Builder(
                builder: (context) {
                  return SunButton(
                    title: 'Comenzar',
                    colorTitle: Theme.of(context).colorScheme.onPrimary,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      loading.showOverlay();
                      final expensesForm = ExpenseModel(
                        description: controllerDescription.text,
                        amount: double.parse(controllerAmount.text.isEmpty ? '0' : controllerAmount.text),
                        expenseType: getKey(controllerDestination.text),
                        expenseDate: controllerDate.text,
                        userId: Info.userId,
                      );
                      context.read<ExpensesBloc>().add(
                        ExpensesCreated(expensesForm: expensesForm),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}