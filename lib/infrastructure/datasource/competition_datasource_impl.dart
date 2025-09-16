import 'package:dio/dio.dart';

import '../../domain/domain.dart';
import '../infrastructure.dart';

class CompetitionDatasourceImpl implements CompetitionDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.football-data.org/v4',
      headers: {'X-Auth-Token': 'THE_DATA_SCORE_KEY'},
    ),
  );

  @override
  Future<List<CompetitionElement>> getAllCompetitions() async {
    try {
      List<CompetitionElement> competitions = [];
      final response = await dio.get('/competitions');
      final competitionsJson = response.data;

      competitions = competitionsJson.map((res) => CompetitionMapper.toEntity(CompetitionResult.fromJson(res) as CompetitionElement)).toList();
      return competitions;
    } catch (e) {
      throw Exception('Error al obtener competiciones: $e');
    }
  }
}
