abstract class Failure {
  const Failure({
    String? message,
    String? title,
  }) :
    message = message ?? 'Ocorreu um erro',
    title = title ?? 'Erro';

  final String title;
  final String message;
}
