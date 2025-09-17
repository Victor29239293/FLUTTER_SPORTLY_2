import '../../domain/domain.dart';
import '../infrastructure.dart';

class CompetitionMapper {
  static CompetitionElement toEntity(CompetitionResult competition) =>
      CompetitionElement(
        id: competition.id,
        area: toEntityArea(competition.area),
        name: competition.name,
        code: competition.code,
        type: toEntityType(competition.type),
        emblem: competition.emblem,
        plan: toEntityPlan(competition.plan),
        currentSeason: toEntityCurrentSeason(competition.currentSeason),
        numberOfAvailableSeasons: competition.numberOfAvailableSeasons,
        lastUpdated: competition.lastUpdated,
      );

  static Area toEntityArea(AreaResult area) =>
      Area(id: area.id, name: area.name, code: area.code, flag: area.flag);

  static CurrentSeason toEntityCurrentSeason(
    CurrentSeasonResult currentSeason,
  ) => CurrentSeason(
    id: currentSeason.id,
    startDate: currentSeason.startDate,
    endDate: currentSeason.endDate,
    currentMatchday: currentSeason.currentMatchday,
    winner: currentSeason.winner != null
        ? toEntityWinner(currentSeason.winner!)
        : null,
  );

  static Winner toEntityWinner(WinnerResult winner) => Winner(
    id: winner.id,
    name: winner.name,
    shortName: winner.shortName,
    tla: winner.tla,
    crest: winner.crest,
    address: winner.address,
    website: winner.website,
    founded: winner.founded,
    clubColors: winner.clubColors,
    venue: winner.venue,
    lastUpdated: winner.lastUpdated,
  );

  static Type toEntityType(TypeResult type) {
    switch (type) {
      case TypeResult.LEAGUE:
        return Type.LEAGUE;
      case TypeResult.CUP:
        return Type.CUP;
    }
  }

  static Plan toEntityPlan(PlanResult plan) {
    switch (plan) {
      case PlanResult.TIER_ONE:
        return Plan.TIER_ONE;
      case PlanResult.TIER_FOUR:
        return Plan.TIER_FOUR;
    }
  }


}
