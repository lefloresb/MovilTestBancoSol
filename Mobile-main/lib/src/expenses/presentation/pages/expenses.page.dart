import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/presentation/bloc/expenses_bloc.dart';
import 'package:mobile/presentation/widgets/loading.dart';
import 'package:mobile/presentation/widgets/app_bar_minimal.dart';
import 'package:mobile/injection.dart';
import 'package:mobile/commons/info.dart';
import 'package:mobile/presentation/widgets/sun_button.dart';
import 'package:mobile/presentation/widgets/sun_field/date/sun_date_field.dart';
import 'package:mobile/presentation/widgets/sun_field/selection/sun_selection_field.dart';
import 'package:mobile/presentation/widgets/sun_field/text/sun_text_field.dart';
import 'package:mobile/presentation/widgets/sun_text.dart';
import 'package:mobile/presentation/dialog.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key key}) : super(key: key);

  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final TextEditingController _controllerDescription = TextEditingController();
  final TextEditingController _controllerDestination = TextEditingController();
  final TextEditingController _controllerAmount = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> optionMap = {
    'Services': 'Servicios',
    'Food': 'Comida',
    'Shopping': 'Compras',
    'Education': 'Educación',
    'Health': 'Salud',
    'VariousExpenses': 'Gastos varios',
  };

  @override
  void initState() {
    super.initState();
    _controllerDate.text = 'Seleccionar Fecha';
  }

  updateDateField(String newValue) {
    setState(() {
      _controllerDate.text = newValue;
    });
  }

  updateSelectionField(dynamic newValue) {
    setState(() {
      _controllerDestination.text = newValue;
    });
  }

  String getKey(String value) {
    return optionMap.keys.lastWhere(
          (element) => optionMap[element] == value,
      orElse: () => 'VariousExpenses',
    );
  }

  @override
  void dispose() {
    _controllerDescription.dispose();
    _controllerDestination.dispose();
    _controllerAmount.dispose();
    _controllerDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = LoadingWidget(context);

    return Scaffold(
      appBar: AppBarMinimal(
        textTitle: 'Registro de Gastos',
        onLeftIconTap: () => Navigator.pop(context),
      ),
      body: ExpensesForm(
        controllerDescription: _controllerDescription,
        controllerDestination: _controllerDestination,
        controllerAmount: _controllerAmount,
        controllerDate: _controllerDate,
        formKey: _formKey,
        optionMap: optionMap,
        updateDateField: updateDateField,
        updateSelectionField: updateSelectionField,
        getKey: getKey,
        loading: loading,
      ),
    );
  }
}