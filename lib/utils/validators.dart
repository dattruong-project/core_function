import 'package:flutter/material.dart';

class CustomValidators {
 static String? validatorPhone() {

 }
}

class FormBuilderValidators {
  static FormFieldValidator<T> compose<T>(
      List<FormFieldValidator<T>> validators) {
    return (valueCandidate) {
      for (var validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  static FormFieldValidator<T> required<T>({
    required String errorText,
  }) {
    return (T? valueCandidate) {
      if (valueCandidate == null ||
          (valueCandidate is String && valueCandidate.trim().isEmpty) ||
          (valueCandidate is Iterable && valueCandidate.isEmpty) ||
          (valueCandidate is Map && valueCandidate.isEmpty)) {
        return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator<T> equal<T>(
    Object value, {
    required String errorText,
  }) =>
      (valueCandidate) => valueCandidate != value ? errorText : null;

  static FormFieldValidator<T> notEqual<T>(
    Object value, {
    required String errorText,
  }) =>
      (valueCandidate) => valueCandidate == value ? errorText : null;
}
