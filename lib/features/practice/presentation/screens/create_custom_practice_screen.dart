import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yoga_coach/features/practice/data/models/practice_model.dart';
import 'package:yoga_coach/features/practice/domain/entities/custom_practice.dart';
import 'package:yoga_coach/features/practice/domain/entities/practice.dart';

class CreateCustomPracticeScreen extends StatefulWidget {
  const CreateCustomPracticeScreen({super.key});

  @override
  State<CreateCustomPracticeScreen> createState() =>
      _CreateCustomPracticeScreenState();
}

class _CreateCustomPracticeScreenState extends State<CreateCustomPracticeScreen> {
  final _nameController = TextEditingController();
  final _selectedMovements = <Movement>[];
  final _selectedMovementIds = <String>{};

  @override
  void dispose() {
    _nameController.dispose();
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

    final customPractice = CustomPractice(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _nameController.text,
      movements: _selectedMovements,
      createdAt: DateTime.now(),
    );

    context.pop(customPractice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Custom Practice'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Name input section
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Practice name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.edit),
              ),
            ),
          ),

          // Summary section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected: ${_selectedMovements.length}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${_selectedMovements.fold<int>(0, (sum, m) => sum + m.durationSeconds ~/ 60)} min',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Preview section
          if (_selectedMovements.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sequence:',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    ..._selectedMovements.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.purple,
                              radius: 18,
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.value.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade100,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${entry.value.durationSeconds}s',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.purple.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 16),
          const Divider(),

          // Available poses list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: mockPractices.length,
              itemBuilder: (context, index) {
                final practice = mockPractices[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          practice.title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    ...practice.movements.map((movement) {
                      final isSelected =
                          _selectedMovementIds.contains(movement.id);
                      final order = isSelected
                          ? _selectedMovements.indexOf(movement) + 1
                          : null;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: InkWell(
                          onTap: () => _toggleMovement(movement),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.purple.shade50
                                  : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.purple.shade300
                                    : Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                if (isSelected)
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$order',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movement.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${movement.durationSeconds} sec',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
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
                                      ? Colors.purple
                                      : Colors.grey.shade400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                  ],
                );
              },
            ),
          ),

          // Create button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _createPractice,
                icon: const Icon(Icons.check),
                label: const Text('Create Practice'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
