1. в детейл вью когда редактируешь не происходит обновления без выхода на главынй экран и возвращения обратно
2. в Ми разделе думаю вынести настройки системные в АппБар сверху потом будет модалка открывсаться или просто страничка, а на Ми будет статистика достижения короче профиль
3. practice_bloc don't use anymore
4. swith to 

getIt.registerFactoryParam<PlaybackCubit, String, void>(
  (practiceId, _) => PlaybackCubit(
    practiceId: practiceId,
    repository: getIt<PracticeRepo>(),
  ),
);