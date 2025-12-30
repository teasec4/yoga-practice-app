import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoga_coach/core/di/service_locator.dart';
import 'package:yoga_coach/features/practice/bloc/playback_cubit.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

class PracticePlaybackScreen extends StatefulWidget {
  final String practiceId;

  const PracticePlaybackScreen({
    required this.practiceId,
    super.key,
  });

  @override
  State<PracticePlaybackScreen> createState() => _PracticePlaybackScreenState();
}

class _PracticePlaybackScreenState extends State<PracticePlaybackScreen> {
  bool _showMovementMap = false;

  void _toggleMovementMap() {
    setState(() {
      _showMovementMap = !_showMovementMap;
    });
  }

  void _closeScreen() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createPlaybackCubit(widget.practiceId),
      child: BlocBuilder<PlaybackCubit, PlaybackState>(
        builder: (context, state) {
          if (state is PlaybackLoading) {
            return Scaffold(
              appBar: AppBar(title: const Text('Practice')),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is PlaybackLoaded) {
            final colors = Theme.of(context).colorScheme;
            final movement = state.movements[state.currentIndex];
            final isLastCard =
                state.currentIndex >= state.movements.length - 1;

            return _buildPlaybackScreen(
              context,
              colors,
              movement,
              isLastCard,
              state.movements,
              state.currentIndex,
              state.durationMultiplier,
            );
          }

          if (state is PlaybackFinished) {
            return Scaffold(
              appBar: AppBar(title: const Text('Practice Finished')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Practice Finished!'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _closeScreen,
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is PlaybackError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Error')),
              body: Center(child: Text(state.message)),
            );
          }

          return Scaffold(
            appBar: AppBar(title: const Text('Practice')),
            body: const Center(child: Text('Something went wrong')),
          );
        },
      ),
    );
  }

  Widget _buildPlaybackScreen(
    BuildContext context,
    ColorScheme colors,
    Movement movement,
    bool isLastCard,
    List<Movement> movements,
    int currentCardIndex,
    int durationMultiplier,
  ) {
    return Scaffold(
      backgroundColor: colors.primary.withOpacity(0.05),
      appBar: AppBar(
        backgroundColor: colors.primary.withOpacity(0.05),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _closeScreen,
        ),
        title: Text(
          '${currentCardIndex + 1}/${movements.length}',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.light
                  : Brightness.dark,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Middle - Card
              Expanded(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    constraints: const BoxConstraints(maxHeight: 400),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow.withOpacity(0.1),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Top - Movement Name
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Text(
                            movement.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        // Middle - Icon & Description
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: colors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.self_improvement,
                                  size: 40,
                                  color: colors.primary,
                                ),
                              ),
                              const SizedBox(height: 24),
                              // Description
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  movement.description,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Bottom - Duration
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colors.primary.withOpacity(0.05),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Duration',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                '${movement.durationSeconds * durationMultiplier}s',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: colors.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Navigation
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Previous Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: currentCardIndex > 0
                            ? () {
                                context
                                    .read<PlaybackCubit>()
                                    .selectMovement(currentCardIndex - 1);
                              }
                            : null,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(
                            color: currentCardIndex > 0
                                ? colors.primary
                                : colors.outline.withOpacity(0.3),
                          ),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Map Button
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _toggleMovementMap,
                        icon: const Icon(Icons.list),
                        label: const Text('Map'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: colors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Next Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: !isLastCard
                            ? () {
                                context
                                    .read<PlaybackCubit>()
                                    .nextMovement();
                              }
                            : () {
                                Navigator.of(context).pop();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isLastCard ? Colors.green : colors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Icon(
                          isLastCard ? Icons.check : Icons.arrow_forward,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Movement Map Overlay
          if (_showMovementMap)
            _buildMovementMapOverlay(
              context,
              colors,
              movements,
              currentCardIndex,
            ),
        ],
      ),
    );
  }

  Widget _buildMovementMapOverlay(
    BuildContext context,
    ColorScheme colors,
    List<Movement> movements,
    int currentCardIndex,
  ) {
    return GestureDetector(
      onTap: _toggleMovementMap,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Movement Sequence',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: movements.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == currentCardIndex;
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<PlaybackCubit>()
                              .selectMovement(index);
                          _toggleMovementMap();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colors.primary.withOpacity(0.2)
                                : Colors.transparent,
                            border: Border.all(
                              color: isSelected
                                  ? colors.primary
                                  : colors.outline.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? colors.primary
                                      : colors.outline.withOpacity(0.3),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : colors.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movements[index].name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      '${movements[index].durationSeconds}s',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
