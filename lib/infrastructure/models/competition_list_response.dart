
class Competition {
    final int count;
    final Filters filters;
    final List<CompetitionResult> competitions;

    Competition({
        required this.count,
        required this.filters,
        required this.competitions,
    });

    factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        count: json["count"],
        filters: Filters.fromJson(json["filters"]),
        competitions: List<CompetitionResult>.from(json["competitions"].map((x) => CompetitionResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "filters": filters.toJson(),
        "competitions": List<dynamic>.from(competitions.map((x) => x.toJson())),
    };
}

class CompetitionResult {
    final int id;
    final AreaResult area;
    final String name;
    final String code;
    final TypeResult type;
    final String emblem;
    final PlanResult plan;
    final CurrentSeasonResult currentSeason;
    final int numberOfAvailableSeasons;
    final DateTime lastUpdated;

    CompetitionResult({
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

    factory CompetitionResult.fromJson(Map<String, dynamic> json) => CompetitionResult(
        id: json["id"],
        area: AreaResult.fromJson(json["area"]),
        name: json["name"],
        code: json["code"],
        type: typeValues.map[json["type"]]!,
        emblem: json["emblem"],
        plan: planValues.map[json["plan"]]!,
        currentSeason: CurrentSeasonResult.fromJson(json["currentSeason"]),
        numberOfAvailableSeasons: json["numberOfAvailableSeasons"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "area": area.toJson(),
        "name": name,
        "code": code,
        "type": typeValues.reverse[type],
        "emblem": emblem,
        "plan": planValues.reverse[plan],
        "currentSeason": currentSeason.toJson(),
        "numberOfAvailableSeasons": numberOfAvailableSeasons,
        "lastUpdated": lastUpdated.toIso8601String(),
    };
}

class AreaResult {
    final int id;
    final String name;
    final String code;
    final String? flag;

    AreaResult({
        required this.id,
        required this.name,
        required this.code,
        required this.flag,
    });

    factory AreaResult.fromJson(Map<String, dynamic> json) => AreaResult(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "flag": flag,
    };
}

class CurrentSeasonResult {
    final int id;
    final DateTime startDate;
    final DateTime endDate;
    final int currentMatchday;
    final WinnerResult? winner;

    CurrentSeasonResult({
        required this.id,
        required this.startDate,
        required this.endDate,
        required this.currentMatchday,
        required this.winner,
    });

    factory CurrentSeasonResult.fromJson(Map<String, dynamic> json) => CurrentSeasonResult(
        id: json["id"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        currentMatchday: json["currentMatchday"],
        winner: json["winner"] == null ? null : WinnerResult.fromJson(json["winner"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "currentMatchday": currentMatchday,
        "winner": winner?.toJson(),
    };
}

class WinnerResult {
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

    WinnerResult({
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

    factory WinnerResult.fromJson(Map<String, dynamic> json) => WinnerResult(
        id: json["id"],
        name: json["name"],
        shortName: json["shortName"],
        tla: json["tla"],
        crest: json["crest"],
        address: json["address"],
        website: json["website"],
        founded: json["founded"],
        clubColors: json["clubColors"],
        venue: json["venue"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shortName": shortName,
        "tla": tla,
        "crest": crest,
        "address": address,
        "website": website,
        "founded": founded,
        "clubColors": clubColors,
        "venue": venue,
        "lastUpdated": lastUpdated.toIso8601String(),
    };
}

enum PlanResult {
    TIER_FOUR,
    TIER_ONE
}

final planValues = EnumValues({
    "TIER_FOUR": PlanResult.TIER_FOUR,
    "TIER_ONE": PlanResult.TIER_ONE
});

enum TypeResult {
    CUP,
    LEAGUE
}

final typeValues = EnumValues({
    "CUP": TypeResult.CUP,
    "LEAGUE": TypeResult.LEAGUE
});

class Filters {
    final String client;

    Filters({
        required this.client,
    });

    factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        client: json["client"],
    );

    Map<String, dynamic> toJson() => {
        "client": client,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
