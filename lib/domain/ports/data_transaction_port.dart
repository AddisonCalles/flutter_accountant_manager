

abstract class DataTransactionPort<T> {
  Future<void> transaction(Future<void> Function(T context) callback);
}