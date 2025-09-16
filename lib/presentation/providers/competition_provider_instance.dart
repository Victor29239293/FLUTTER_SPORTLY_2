import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sportly_2/infrastructure/infrastructure.dart';


final competitionProviderInstance = Provider((ref){
  return CompetitionRespositoryImpl(CompetitionDatasourceImpl());
});