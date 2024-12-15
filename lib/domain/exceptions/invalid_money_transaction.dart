import 'package:accountant_manager/domain/exceptions/domain_exception.dart';

class InvalidMoneyTransaction extends DomainException {
  InvalidMoneyTransaction(super.message);
}
