import 'package:flutter/material.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:yoga_coach/features/practice/data/models/practice_model.dart';

class PracticePlaybackScreen extends StatefulWidget {
  final String practiceId;

  const PracticePlaybackScreen({
    required this.practiceId,
    super.key,
  });

  @override
  State<PracticePlaybackScreen> createState() => _PracticePlaybackScreenState();
}

class _PracticePlaybackScreenState extends State<PracticePlaybackScreen>
    with TickerProviderStateMixin {
  late int _currentCardIndex;
  late int _totalCards;
  late bool _showMovementMap;
  late AnimationController _cardAnimationController;
  late AnimationController _enterAnimationController;
  late AnimationController _mapAnimationController;
  late AnimationController _timerAnimationController;
  late Animation<double> _cardFadeAnimation;
  late Animation<Offset> _cardSlideAnimation;
  late Animation<Offset> _enterSlideAnimation;
  late Animation<double> _enterOpacityAnimation;
  late Animation<Offset> _mapSlideAnimation;
  late bool _isTimerRunning;
  late double _timerProgress;

  @override
  void initState() {
    super.initState();
    _currentCardIndex = 0;
    final practice = _getPractice(widget.practiceId);
    _totalCards = practice.movements.length;
    _showMovementMap = false;
    _isTimerRunning = false;
    _timerProgress = 0.0;

    // Card switch animation
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _cardFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardAnimationController, curve: Curves.easeIn),
    );

    _cardSlideAnimation =
        Tween<Offset>(begin: const Offset(0.3, 0.0), end: Offset.zero).animate(
      CurvedAnimation(parent: _cardAnimationController, curve: Curves.easeOut),
    );

    // Page enter animation
    _enterAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _enterSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _enterAnimationController, curve: Curves.easeOut),
    );

    _enterOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _enterAnimationController, curve: Curves.easeIn),
    );

    // Map animation
    _mapAnimationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _mapSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.6), end: Offset.zero).animate(
      CurvedAnimation(parent: _mapAnimationController, curve: Curves.easeOut),
    );

    // Timer animation
    _timerAnimationController = AnimationController(
      vsync: this,
    );

    _timerAnimationController.addListener(() {
      setState(() {
        _timerProgress = _timerAnimationController.value;
      });
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        _enterAnimationController.forward();
      }
    });
  }

  void _toggleMovementMap() {
    setState(() {
      _showMovementMap = !_showMovementMap;
    });
    if (_showMovementMap) {
      _mapAnimationController.forward();
    } else {
      _mapAnimationController.reverse();
    }
  }

  void _startTimer(int durationSeconds) {
    setState(() {
      _isTimerRunning = true;
    });
    _timerAnimationController.duration = Duration(seconds: durationSeconds);
    _timerAnimationController.forward();
  }

  void _resetTimer() {
    _timerAnimationController.reset();
    setState(() {
      _isTimerRunning = false;
      _timerProgress = 0.0;
    });
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _enterAnimationController.dispose();
    _mapAnimationController.dispose();
    _timerAnimationController.dispose();
    super.dispose();
  }

  Practice _getPractice(String id) {
    return mockPractices.firstWhere(
      (practice) => practice.id == id,
      orElse: () => mockPractices.first,
    );
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

  void _nextCard() {
    if (_currentCardIndex < _totalCards - 1) {
      setState(() {
        _currentCardIndex++;
      });
      _playCardAnimation();
    }
  }

  void _previousCard() {
    if (_currentCardIndex > 0) {
      setState(() {
        _currentCardIndex--;
      });
      _playCardAnimation();
    }
  }

  void _playCardAnimation() {
    _cardAnimationController.reset();
    _cardAnimationController.forward();
  }



  Widget _buildMovementCard(
    BuildContext context,
    Practice practice,
    ColorScheme colors,
  ) {
    final movement = practice.movements[_currentCardIndex];
    final durationSeconds = movement.durationSeconds;

    return FadeTransition(
      opacity: _cardFadeAnimation,
      child: SlideTransition(
        position: _cardSlideAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top - Movement Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                movement.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      _getIconData(practice.iconType),
                      color: colors.primary,
                      size: 56,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Movement Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      movement.description,
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom - Duration with Play Button / Progress Bar
            Column(
              children: [
                // Progress bar (always visible, even if empty)
                SizedBox(
                  height: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.5),
                    child: LinearProgressIndicator(
                      value: _timerProgress,
                      backgroundColor: colors.primary.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
                      minHeight: 3,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_isTimerRunning) {
                      _timerAnimationController.stop();
                      setState(() {
                        _isTimerRunning = false;
                      });
                    } else {
                      if (_timerProgress >= 1.0) {
                        _resetTimer();
                      }
                      _startTimer(durationSeconds);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isTimerRunning ? Icons.pause : Icons.play_arrow,
                          color: colors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 50,
                          child: Text(
                            _isTimerRunning
                                ? 'Pause'
                                : '${(durationSeconds / 60).toStringAsFixed(1)} min',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementGrid(Practice practice, ColorScheme colors) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.5, // Half screen height
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colors.outline.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Select Movement',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colors.outline,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: practice.movements.length,
              itemBuilder: (context, index) {
                final isActive = index == _currentCardIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentCardIndex = index;
                    });
                    _playCardAnimation();
                    _toggleMovementMap(); // Close the map
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isActive
                          ? colors.primary
                          : colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive
                            ? colors.primary
                            : colors.outline.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                _getIconData(practice.iconType),
                                size: 18,
                                color: isActive
                                    ? Colors.white
                                    : colors.primary.withOpacity(0.6),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${index + 1}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: isActive
                                          ? Colors.white
                                          : colors.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        if (isActive)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final practice = _getPractice(widget.practiceId);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.primary.withOpacity(0.05),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Column Layout
            SlideTransition(
              position: _enterSlideAnimation,
              child: Column(
                children: [
                  // Top Row - Close Button & Counter
                  FadeTransition(
                    opacity: _enterOpacityAnimation,
                    child: Padding(
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
                              onPressed: () => Navigator.of(context).pop(),
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
                  ),

                  // Middle Row - Left Arrow, Card, Right Arrow
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Arrow - Previous Card
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
                            icon: const Icon(Icons.chevron_left),
                            iconSize: 32,
                            onPressed: _currentCardIndex > 0 ? _previousCard : null,
                            color: _currentCardIndex > 0
                                ? colors.primary
                                : colors.outline.withOpacity(0.3),
                          ),
                        ),

                        // Center Card
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
                              child: _buildMovementCard(context, practice, colors),
                            ),
                          ),
                        ),

                        // Right Arrow - Next Card
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
                            icon: const Icon(Icons.chevron_right),
                            iconSize: 32,
                            onPressed: _currentCardIndex < _totalCards - 1
                                ? _nextCard
                                : null,
                            color: _currentCardIndex < _totalCards - 1
                                ? colors.primary
                                : colors.outline.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Row - Movement Map Button
                  FadeTransition(
                    opacity: _enterOpacityAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: GestureDetector(
                        onTap: _toggleMovementMap,
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.map,
                                color: colors.primary,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Movement Map',
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
                    ),
                  ),
                ],
              ),
            ),

            // Movement Grid - Modal from Bottom
            if (_showMovementMap)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Stack(
                  children: [
                    // Backdrop
                    GestureDetector(
                      onTap: _toggleMovementMap,
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                    // Grid Container - Bottom Sheet
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SlideTransition(
                        position: _mapSlideAnimation,
                        child: _buildMovementGrid(practice, colors),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
