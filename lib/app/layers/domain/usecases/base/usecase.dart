import 'package:dartz/dartz.dart';
import 'package:my_books/app/layers/domain/usecases/base/failure.dart';

abstract class UseCase<T, Param> {
  Future<Either<Failure, T>> run([Param? p]);

  Future<Either<Failure, T>> call([Param? p]) async {
    try {
      return await run(p);
    } catch (e) {
      // Este local serve para capturar as exceções não tratadas do use case.
      // No mínimo enviamos para o Firebase Crashlytics
      return left(UnexpectedFailure(e));
    }
  }
}

// Utilizar esta classe quando o caso de uso não possuir parâmetros.
class NoParams {}
