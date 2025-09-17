
import '../../domain/domain.dart';

class CompetitionRespositoryImpl implements CompetitionRepositories {

  final CompetitionDatasource datasource;

  CompetitionRespositoryImpl(this.datasource);

  @override
  Future<List<CompetitionElement>> getAllCompetitions() async {
    return await datasource.getAllCompetitions();
  }
  @override
  Future<CompetitionElement> getCompetitionByCode(String code) async {
    return await datasource.getCompetitionByCode(code);
  }
}
