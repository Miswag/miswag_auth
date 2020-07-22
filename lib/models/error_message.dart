// To parse this JSON data, do
//
//     final errorMessage = errorMessageFromJson(jsonString);

import 'dart:convert';

class ErrorMessage {
  final String message;
  final Errors errors;

  ErrorMessage({
    this.message,
    this.errors,
  });

  factory ErrorMessage.fromJson(String str) =>
      ErrorMessage.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory ErrorMessage.fromMap(Map<String, dynamic> json) => ErrorMessage(
        message: json["message"] as String,
        errors: json["errors"] == null
            ? null
            : Errors.fromMap(json["errors"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "errors": errors.toMap(),
      };
}

class Errors {
  final Map<String, dynamic> fieldsReasons;

  Errors({
    this.fieldsReasons,
  });

  factory Errors.fromJson(String str) =>
      Errors.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory Errors.fromMap(Map<String, dynamic> json) => Errors(
        fieldsReasons: json,
      );

  Map<String, dynamic> toMap() => fieldsReasons;
}
