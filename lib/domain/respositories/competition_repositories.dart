

import 'package:flutter_sportly_2/domain/entities/competition.dart';

abstract class CompetitionRepositories {
  Future<List<CompetitionElement>> getAllCompetitions();
}