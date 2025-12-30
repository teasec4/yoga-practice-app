import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoga_coach/features/practice/bloc/practice_bloc.dart';

class CreatePracticeScreen extends StatefulWidget {
  final Practice? editingPractice;

  const CreatePracticeScreen({this.editingPractice, super.key});

  @override
  State<CreatePracticeScreen> createState() =>
      _CreatePracticeScreenState();
}

class _CreatePracticeScreenState extends State<CreatePracticeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _nameController = TextEditingController();
  final _selectedMovements = <Movement>[];
  final _selectedMovementIds = <String>{};
  DifficultyLevel _selectedDifficulty = DifficultyLevel.beginner;
  DurationMultiplier _selectedMultiplier = DurationMultiplier.x1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    if (widget.editingPractice != null) {
      final practice = widget.editingPractice!;
      _nameController.text = practice.title;
      _selectedDifficulty = practice.difficulty;
      _selectedMultiplier = practice.durationMultiplier;
      _selectedMovements.addAll(practice.movements);
      for (final movement in practice.movements) {
        _selectedMovementIds.add(movement.id);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _toggleMovement(Movement movement) {
    setState(() {
      if (_selectedMovementIds.contains(movement.id)) {
        _selectedMovementIds.remove(movement.id);
        _selectedMovements.removeWhere((m) => m.id == movement.id);
      } else {
        _selectedMovementIds.add(movement.id);
        _selectedMovements.add(movement);
      }
    });
  }

  void _createPractice() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a practice name')),
      );
      return;
    }

    if (_selectedMovements.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one pose')),
      );
      return;
    }

    final practice = Practice(
      id: widget.editingPractice?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _nameController.text,
      movements: _selectedMovements,
      createdAt: widget.editingPractice?.createdAt ?? DateTime.now(),
      difficulty: _selectedDifficulty,
      durationMultiplier: _selectedMultiplier,
      isCustom: true,
    );

    context.pop(practice);
  }

  Color _getDifficultyColor(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.beginner:
        return const Color(0xFF8BC98D);
      case DifficultyLevel.intermediate:
        return const Color(0xFFE8A655);
      case DifficultyLevel.advanced:
        return const Color(0xFFD4727A);
    }
  }

  String _getDifficultyLabel(DifficultyLevel level) {
    switch (level) {
      case DifficultyLevel.beginner:
        return 'Beginner';
      case DifficultyLevel.intermediate:
        return 'Intermediate';
      case DifficultyLevel.advanced:
        return 'Advanced';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final baseDuration = _selectedMovements.fold<int>(
      0,
      (sum, m) => sum + m.durationSeconds,
    );
    final totalDuration = baseDuration * _selectedMultiplier.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editingPractice != null ? 'Edit Practice' : 'Create Custom Practice'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border(
                bottom: BorderSide(
                  color: colors.outline.withOpacity(0.1),
                ),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Practice name',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.edit, size: 20),
                  ),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Difficulty',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          for (final difficulty in DifficultyLevel.values)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedDifficulty = difficulty;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedDifficulty == difficulty
                                          ? _getDifficultyColor(difficulty)
                                          : _getDifficultyColor(
                                              difficulty,
                                            ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: _selectedDifficulty == difficulty
                                            ? _getDifficultyColor(difficulty)
                                            : Colors.transparent,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      _getDifficultyLabel(difficulty),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: 10,
                                            color:
                                                _selectedDifficulty ==
                                                    difficulty
                                                ? Colors.white
                                                : _getDifficultyColor(
                                                    difficulty,
                                                  ),
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colors.secondary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration ×',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          for (final multiplier in DurationMultiplier.values)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedMultiplier = multiplier;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _selectedMultiplier == multiplier
                                          ? colors.secondary
                                          : colors.secondary.withOpacity(
                                              0.1,
                                            ),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: _selectedMultiplier == multiplier
                                            ? colors.secondary
                                            : Colors.transparent,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      multiplier.label,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: 10,
                                            color:
                                                _selectedMultiplier ==
                                                    multiplier
                                                ? Colors.white
                                                : colors.secondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.05),
              border: Border(
                bottom: BorderSide(
                  color: colors.outline.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Poses',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(fontSize: 11),
                    ),
                    Text(
                      '${_selectedMovements.length}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Duration',
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(fontSize: 11),
                    ),
                    Text(
                      '${(totalDuration / 60).ceil()} min',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: colors.primary,
            unselectedLabelColor: colors.outline,
            indicatorColor: colors.primary,
            tabs: const [
              Tab(text: 'Available Poses'),
              Tab(text: 'Selected Poses'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAvailablePosesTab(context),
                _buildSelectedPosesTab(context),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _createPractice,
                icon: const Icon(Icons.check, size: 20),
                label: const Text('Create Practice'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailablePosesTab(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BlocBuilder<PracticeBloc, PracticeState>(
      builder: (context, state) {
        if (state is PracticeLoaded) {
          final practices = state.practices.where((p) => !p.isCustom).toList();
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: practices.length,
            itemBuilder: (context, index) {
              final practice = practices[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 6),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        practice.title,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colors.primary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  ...practice.movements.map((movement) {
                    final isSelected = _selectedMovementIds.contains(movement.id);
                    final order = isSelected
                        ? _selectedMovements.indexOf(movement) + 1
                        : null;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: InkWell(
                        onTap: () => _toggleMovement(movement),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? colors.primary.withOpacity(0.05)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? colors.primary.withOpacity(0.3)
                                  : colors.outline.withOpacity(0.15),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              if (isSelected)
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: colors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$order',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: colors.outline.withOpacity(0.4),
                                    size: 24,
                                  ),
                                ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movement.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      '${movement.durationSeconds}s',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                isSelected
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: isSelected
                                    ? colors.primary
                                    : colors.outline.withOpacity(0.4),
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 6),
                ],
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSelectedPosesTab(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (_selectedMovements.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 48,
              color: colors.outline.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No poses selected',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: colors.outline.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add poses from the "Available Poses" tab',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors.outline.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      itemCount: _selectedMovements.length,
      itemBuilder: (context, index) {
        final movement = _selectedMovements[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colors.outline.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movement.name,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        movement.description,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${movement.durationSeconds}s',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _toggleMovement(movement),
                      child: Icon(Icons.close, size: 18, color: colors.error),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}