import 'package:equatable/equatable.dart';

class CustomException extends Equatable implements Exception {
  final String errorMessage;

  const CustomException(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
