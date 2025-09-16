import 'package:dio/dio.dart';

import '../../domain/domain.dart';
import '../infrastructure.dart' hide Competition;

class CompetitionDatasourceImpl implements CompetitionDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.football-data.org/v4',
      headers: {'X-Auth-Token': '06e7722233fd42e399e3c33f84ca08a1'},
    ),
  );

  @override
  Future<List<CompetitionElement>> getAllCompetitions() async {
    try {
      final response = await dio.get('/competitions');
      final competitionsJson = response.data['competitions'] as List<dynamic>;
      final competitions = competitionsJson
          .map(
            (res) =>
                CompetitionMapper.toEntity(CompetitionResult.fromJson(res)),
          )
          .toList();
      return competitions;
    } catch (e) {
      throw Exception('Error al obtener competiciones: $e');
    }
  }
}
