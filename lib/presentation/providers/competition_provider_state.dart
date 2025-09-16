import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sportly_2/domain/entities/competition.dart';
import 'package:flutter_sportly_2/presentation/providers/competition_provider_instance.dart';

final competitionProvider =
    StateNotifierProvider<CompetitionProviderState, List<CompetitionElement>>((
      ref,
    ) {
      final fetchCompetitions = ref
          .watch(competitionProviderInstance)
          .getAllCompetitions;
      return CompetitionProviderState(fetchCompetitions: fetchCompetitions);
    });

typedef CompetitionCallback = Future<List<CompetitionElement>> Function();

class CompetitionProviderState extends StateNotifier<List<CompetitionElement>> {
  final CompetitionCallback fetchCompetitions;

  CompetitionProviderState({required this.fetchCompetitions}) : super([]);
  bool isLoading = false;

  Future<List<CompetitionElement>>loadCompetitions() async {
    isLoading = true;
    final competitions = await fetchCompetitions();
    state = [...state, ...competitions];
    isLoading = false;
    return competitions;
  }
}
