import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/bloc/module/module_bloc.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('DART',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/profile',
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.newspaper),
            tooltip: 'News',
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/news',
              );
            },
          )
        ],
      ),
      body: BlocBuilder<ModuleBloc, ModulesState>(
        bloc: BlocProvider.of<ModuleBloc>(context)
          ..add(const GetModules(1, 'en')),
        builder: (context, state) {
          if (state is ModulesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ModulesLoaded) {
            return ListView.builder(
              itemCount: state.modules.length,
              itemBuilder: (context, index) {
                final module = state.modules[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(module.finishedLesson.toString()),
                  ),
                  title: Text(
                    module.name,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(module.description!),
                  onTap: () {
                    // Navigate to module lesson page
                    Navigator.of(context).pushNamed(
                      '/lesson',
                      arguments: {
                        'module_id': module.id,
                        'finishedLesson': module.finishedLesson
                      },
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('Failed to load modules'),
            );
          }
        },
      ),
    );
  }
}
