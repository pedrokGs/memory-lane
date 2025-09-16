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
      appBar: AppBar(title: Text("Home"), automaticallyImplyLeading: false,),
      body:
          _memoriesProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Minhas Memórias", style: TextStyle(fontSize: 24),),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: MasonryGridView.builder(
                        physics: NeverScrollableScrollPhysics(),
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
                            child: Image.network(memory.photoUrl, fit: BoxFit.cover),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // TODO: Navigate to AddMemoryScreen
      },),
    );
  }
}
