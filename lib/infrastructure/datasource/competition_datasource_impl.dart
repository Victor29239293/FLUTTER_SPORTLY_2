import 'package:dio/dio.dart';

import '../../domain/domain.dart';
import '../infrastructure.dart' hide Competition;
import '../../config/constants/environment.dart';

class CompetitionDatasourceImpl implements CompetitionDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.football-data.org/v4',
      headers: {'X-Auth-Token': Environment.theScoreKey},
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

  @override
  Future<CompetitionElement> getCompetitionByCode(String code) async {
    try {
      final response = await dio.get('/competitions/$code');

      final competitionJson = response.data;

      // Verificar que los datos no sean nulos
      if (competitionJson == null) {
        throw Exception(
          'No se encontraron datos para la competición con código $code',
        );
      }

      final competition = CompetitionMapper.toEntity(
        CompetitionResult.fromJson(competitionJson),
      );
      return competition;
    } on DioException catch (dioError) {
      if (dioError.response?.statusCode == 404) {
        throw Exception('Competición con código $code no encontrada (404)');
      } else if (dioError.response?.statusCode == 403) {
        throw Exception(
          'Acceso prohibido a la competición con código $code. Verifica tu API key.',
        );
      }
      throw Exception(
        'Error de red al obtener la competición con código $code: ${dioError.message}',
      );
    } catch (e) {
      throw Exception('Error al procesar la competición con código $code: $e');
    }
  }
}
