import 'package:get_it/get_it.dart';
import 'package:yoga_coach/features/practice/bloc/playback_cubit.dart';
import 'package:yoga_coach/features/practice/bloc/practice_detail_cubit.dart';
import 'package:yoga_coach/features/practice/bloc/practice_list_cubit.dart';
import 'package:yoga_coach/features/practice/data/database/drift_database.dart';
import 'package:yoga_coach/features/practice/data/repositories/practice_repository.dart';
import 'package:yoga_coach/features/practice/domain/repositories/practice_repo.dart';

final getIt = GetIt.instance;

/// Setup all dependencies for the application
void setupServiceLocator() {
  // Database
  getIt.registerSingleton<AppDatabase>(AppDatabase());

  // Repositories
  final practiceRepository = PracticeRepository(database: getIt<AppDatabase>());

  getIt.registerSingleton<PracticeRepository>(practiceRepository);
  getIt.registerSingleton<PracticeRepo>(practiceRepository);

  // Cubits
  getIt.registerLazySingleton<PracticeListCubit>(
    () => PracticeListCubit(practiceRepo: getIt<PracticeRepo>()),
  );

  getIt.registerFactory<PracticeDetailCubit>(
    () => PracticeDetailCubit(practiceRepo: getIt<PracticeRepo>()),
  );

  // Factories (for instances that need parameters)
  getIt.registerFactory<PlaybackCubit>(
    () =>
        PlaybackCubit(practiceId: '', repository: getIt<PracticeRepository>()),
  );
}

/// Create PlaybackCubit with specific practiceId
PlaybackCubit createPlaybackCubit(String practiceId) {
  return PlaybackCubit(
    practiceId: practiceId,
    repository: getIt<PracticeRepository>(),
  );
}
