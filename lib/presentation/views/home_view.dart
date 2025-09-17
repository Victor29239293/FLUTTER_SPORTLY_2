import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sportly_2/presentation/providers/competition_provider_state.dart';

import '../../domain/domain.dart';

class HomeView extends ConsumerStatefulWidget {
  static const routeName = 'homeview';
  final String code;

  const HomeView({super.key, required this.code});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool isLoading = true;
  String? errorMessage;
  late Future<CompetitionElement> competitions;

  @override
  void initState() {
    competitions = ref
        .read(competitionProvider.notifier)
        .loadCompetitionByCode(widget.code);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<CompetitionElement>(
        future: competitions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final competition = snapshot.data!;

            return ListView(
              children: [
                AppBar(
                  title: Row(
                    children: [
                      Image.network(
                        competition.emblem,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.sports_soccer, size: 40),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        competition.name,

                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
