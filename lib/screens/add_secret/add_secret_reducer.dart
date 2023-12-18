import 'package:flutter_security/screens/add_secret/add_secret_action.dart';
import 'package:flutter_security/screens/add_secret/add_secret_state.dart';
import 'package:redux/redux.dart';

class AddSecretReducer extends ReducerClass<AddSecretState> {
  @override
  AddSecretState call(final AddSecretState state, final action) {
    if (action is AddSecretActionSetName) {
      return state.copyWith(
        name: action.name,
        isSubmitEnabled: _areInputsValid(name: action.name, value: state.value),
        isPasswordInvalid: false,
      );
    }

    if (action is AddSecretActionSetValue) {
      return state.copyWith(
        value: action.value,
        isSubmitEnabled: _areInputsValid(name: state.name, value: action.value),
        isPasswordInvalid: false,
      );
    }

    return state;
  }

  bool _areInputsValid({required final String name, required final String value}) =>
      name.isNotEmpty && value.isNotEmpty;
}
