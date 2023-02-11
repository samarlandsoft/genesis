abstract class Failure {
  final String error;

  Failure(this.error, [List properties = const <dynamic>[]]);
}

class CommonFailure extends Failure {
  CommonFailure(String error) : super(error);
}
