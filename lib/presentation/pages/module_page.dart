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
      ),
      body: BlocProvider(
        create: (context) => ModuleBloc()..add(const GetModules(1, 'en')),
        child: BlocBuilder<ModuleBloc, ModuleState>(
          builder: (context, state) {
            if (state is ModuleLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ModuleLoaded) {
              return ListView.builder(
                itemCount: state.modules.length,
                itemBuilder: (context, index) {
                  final module = state.modules[index];
                  return ListTile(
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
                        arguments: module.id,
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
      ),
    );
  }
}
