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
      final fetchCompetitionByCode = ref
          .watch(competitionProviderInstance)
          .getCompetitionByCode;
      return CompetitionProviderState(
        fetchCompetitions: fetchCompetitions,
        fetchCompetitionByCode: fetchCompetitionByCode,
      );
    });

typedef CompetitionCallback = Future<List<CompetitionElement>> Function();

typedef CompetitionByCodeCallback =
    Future<CompetitionElement> Function(String code);

class CompetitionProviderState extends StateNotifier<List<CompetitionElement>> {
  final CompetitionCallback fetchCompetitions;
  final CompetitionByCodeCallback fetchCompetitionByCode;

  CompetitionProviderState({
    required this.fetchCompetitions,
    required this.fetchCompetitionByCode,
  }) : super([]);
  bool isLoading = false;

  Future<List<CompetitionElement>> loadCompetitions() async {
    isLoading = true;
    final competitions = await fetchCompetitions();
    state = [...state, ...competitions];
    isLoading = false;
    return competitions;
  }

  Future<CompetitionElement> loadCompetitionByCode(String code) async {
    if (code.isEmpty) {
      throw Exception('El código de competición no puede estar vacío');
    }

    isLoading = true;
    try {
      final competition = await fetchCompetitionByCode(code);
      // Solo agregamos la competición si no existe ya en el estado
      final existingIndex = state.indexWhere((comp) => comp.code == code);
      if (existingIndex == -1) {
        state = [...state, competition];
      } else {
        // Actualizamos la competición existente
        final newState = List<CompetitionElement>.from(state);
        newState[existingIndex] = competition;
        state = newState;
      }
      isLoading = false;
      return competition;
    } catch (e) {
      isLoading = false;
      rethrow; // Re-lanza el error para que pueda ser manejado en la UI
    }
  }
}
