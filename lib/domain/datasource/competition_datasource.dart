

import 'package:flutter_sportly_2/domain/entities/competition.dart';

abstract class CompetitionDatasource {
  Future<List<CompetitionElement>> getAllCompetitions();
  Future<CompetitionElement> getCompetitionByCode(String code);
}