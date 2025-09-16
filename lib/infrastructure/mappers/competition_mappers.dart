import '../../domain/domain.dart';

class CompetitionMapper {
  static CompetitionElement toEntity(CompetitionElement competition) =>
      CompetitionElement(
        id: competition.id,
        area: toEntityArea(competition.area),
        name: competition.name,
        code: competition.code,
        type: competition.type,
        emblem: competition.emblem,
        plan: competition.plan,
        currentSeason: toEntityCurrentSeason(competition.currentSeason),
        numberOfAvailableSeasons: competition.numberOfAvailableSeasons,
        lastUpdated: competition.lastUpdated,
      );

  static Area toEntityArea(Area area) =>
      Area(id: area.id, name: area.name, code: area.code, flag: area.flag);

  static CurrentSeason toEntityCurrentSeason(CurrentSeason currentSeason) =>
      CurrentSeason(
        id: currentSeason.id,
        startDate: currentSeason.startDate,
        endDate: currentSeason.endDate,
        currentMatchday: currentSeason.currentMatchday,
        winner: currentSeason.winner != null
            ? toEntityWinner(currentSeason.winner!)
            : null,
      );

  static Winner toEntityWinner(Winner winner) =>
      Winner(
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
        lastUpdated: winner.lastUpdated



      );
}
