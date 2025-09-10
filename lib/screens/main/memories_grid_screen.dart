import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../providers/memory_provider.dart';

class MemoriesGridScreen extends StatefulWidget {
  const MemoriesGridScreen({super.key});

  @override
  State<MemoriesGridScreen> createState() => _MemoriesGridScreenState();

}

class _MemoriesGridScreenState extends State<MemoriesGridScreen> {
  @override
  void initState() {
    super.initState();
    loadMemories();
  }
  void loadMemories() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MemoryProvider>(context, listen: false).getMemories();
    });
  }
  @override
  Widget build(BuildContext context) {
    final _memoriesProvider = Provider.of<MemoryProvider>(context);
    return Scaffold(
      body: _memoriesProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : MasonryGridView.builder(
        gridDelegate:
        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(12),
        itemCount: _memoriesProvider.memories.length,
        itemBuilder: (context, index) {
          final memory = _memoriesProvider.memories[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              memory.photoUrl,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }


}
