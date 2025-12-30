import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/data/models/practice_model.dart';
import 'package:yoga_coach/features/practice/data/models/custom_practice_storage.dart';

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
  late int _currentCardIndex;
  late int _totalCards;
  late bool _showMovementMap;
  late bool _isTimerRunning;

  @override
  void initState() {
    super.initState();
    _currentCardIndex = 0;
    final movements = _getMovements(widget.practiceId);
    _totalCards = movements.length;
    _showMovementMap = false;
    _isTimerRunning = false;
  }

  void _toggleMovementMap() {
    setState(() {
      _showMovementMap = !_showMovementMap;
    });
  }

  void _nextCard() {
    if (_currentCardIndex < _totalCards - 1) {
      setState(() {
        _currentCardIndex++;
      });
    }
  }

  void _closeScreen() {
    if (mounted) {
      // Pop back to detail screen using Navigator directly
      Navigator.of(context).pop();
    }
  }

  List<Movement> _getMovements(String id) {
    // Try to find in standard practices first
    try {
      final practice = mockPractices.firstWhere((p) => p.id == id);
      return practice.movements;
    } catch (e) {
      // Try custom practices
      final storage = CustomPracticeStorage();
      final customPractice = storage.getPractice(id);
      if (customPractice != null) {
        return customPractice.movements;
      }
      // Fallback to first standard practice
      return mockPractices.first.movements;
    }
  }

  IconData _getIconData(IconType type) {
    switch (type) {
      case IconType.lotus:
        return Icons.self_improvement;
      case IconType.tree:
        return Icons.nature;
      case IconType.warrior:
        return Icons.sports_martial_arts;
      case IconType.downward:
        return Icons.trending_down;
      case IconType.meditation:
        return Icons.spa;
      case IconType.breathing:
        return Icons.air;
      case IconType.flexibility:
        return Icons.accessibility;
      case IconType.strength:
        return Icons.fitness_center;
      case IconType.balance:
        return Icons.hub;
      case IconType.relaxation:
        return Icons.cloud;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movements = _getMovements(widget.practiceId);
    final colors = Theme.of(context).colorScheme;
    final movement = movements[_currentCardIndex];
    final isLastCard = _currentCardIndex >= _totalCards - 1;

    return Scaffold(
      backgroundColor: colors.primary.withOpacity(0.05),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Column(
              children: [
                // Top Row - Close Button & Counter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Close Button
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colors.shadow.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _closeScreen,
                        ),
                      ),
                      // Counter
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: colors.shadow.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Text(
                          '${_currentCardIndex + 1} / $_totalCards',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colors.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),

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
                                horizontal: 16, vertical: 12),
                            child: Text(
                              movement.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
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
                                      horizontal: 16),
                                  child: Text(
                                    movement.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall,
                                ),
                                Text(
                                  '${movement.durationSeconds}s',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        color: colors.primary,
                                        fontWeight: FontWeight.w600,
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

                // Bottom Row - Map Button & Next/Done Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Button - Movement Map
                      GestureDetector(
                        onTap: _toggleMovementMap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: colors.shadow.withOpacity(0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.map,
                                color: colors.primary,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Map',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      color: colors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Right Button - Next/Done
                      GestureDetector(
                        onTap: isLastCard ? _closeScreen : _nextCard,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: colors.shadow.withOpacity(0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Text(
                            isLastCard ? 'DONE' : 'NEXT',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Movement Grid Modal (if visible)
            if (_showMovementMap)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: _toggleMovementMap,
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {}, // Prevent dismiss when tapping grid
                        child: Container(
                          margin: const EdgeInsets.all(24),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: colors.surface,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                            itemCount: movements.length,
                            itemBuilder: (context, index) {
                              final isActive = index == _currentCardIndex;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentCardIndex = index;
                                    _showMovementMap = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? colors.primary
                                        : colors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: colors.outline.withOpacity(0.2),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: isActive
                                                  ? Colors.white
                                                  : colors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        movements[index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: isActive
                                                  ? Colors.white
                                                  : colors.onSurface,
                                              fontSize: 10,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
