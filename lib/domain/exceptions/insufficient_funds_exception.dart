import 'package:accountant_manager/domain/exceptions/domain_exception.dart';

class InsufficientFundsException extends DomainException {
  InsufficientFundsException(super.message);
}
