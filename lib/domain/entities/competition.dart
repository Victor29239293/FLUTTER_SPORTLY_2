class Competition {
  final int count;
  final Filters filters;
  final List<CompetitionElement> competitions;

  Competition({
    required this.count,
    required this.filters,
    required this.competitions,
  });
}

class CompetitionElement {
  final int id;
  final Area area;
  final String name;
  final String code;
  final Type type;
  final String emblem;
  final Plan plan;
  final CurrentSeason currentSeason;
  final int numberOfAvailableSeasons;
  final DateTime lastUpdated;

  CompetitionElement({
    required this.id,
    required this.area,
    required this.name,
    required this.code,
    required this.type,
    required this.emblem,
    required this.plan,
    required this.currentSeason,
    required this.numberOfAvailableSeasons,
    required this.lastUpdated,
  });
}

class Area {
  final int id;
  final String name;
  final String code;
  final String? flag;

  Area({
    required this.id,
    required this.name,
    required this.code,
    required this.flag,
  });
}

class CurrentSeason {
  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final int currentMatchday;
  final Winner? winner;

  CurrentSeason({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.currentMatchday,
    required this.winner,
  });
}



class Winner {
  final int id;
  final String name;
  final String shortName;
  final String tla;
  final String crest;
  final String address;
  final String website;
  final int founded;
  final String clubColors;
  final String venue;
  final DateTime lastUpdated;

  Winner({
    required this.id,
    required this.name,
    required this.shortName,
    required this.tla,
    required this.crest,
    required this.address,
    required this.website,
    required this.founded,
    required this.clubColors,
    required this.venue,
    required this.lastUpdated,
  });
}

enum Plan { TIER_FOUR, TIER_ONE }

enum Type { CUP, LEAGUE }

class Filters {
  final String client;

  Filters({required this.client});
}
