
class CompetitionResult {
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
        area: Area.fromJson(json["area"]),
        name: json["name"],
        code: json["code"],
        type: typeValues.map[json["type"]]!,
        emblem: json["emblem"],
        plan: planValues.map[json["plan"]]!,
        currentSeason: CurrentSeason.fromJson(json["currentSeason"]),
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

    factory Area.fromJson(Map<String, dynamic> json) => Area(
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

    factory CurrentSeason.fromJson(Map<String, dynamic> json) => CurrentSeason(
        id: json["id"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        currentMatchday: json["currentMatchday"],
        winner: json["winner"] == null ? null : Winner.fromJson(json["winner"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "currentMatchday": currentMatchday,
        "winner": winner?.toJson(),
    };
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

    factory Winner.fromJson(Map<String, dynamic> json) => Winner(
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

enum Plan {
    TIER_FOUR,
    TIER_ONE
}

final planValues = EnumValues({
    "TIER_FOUR": Plan.TIER_FOUR,
    "TIER_ONE": Plan.TIER_ONE
});

enum Type {
    CUP,
    LEAGUE
}

final typeValues = EnumValues({
    "CUP": Type.CUP,
    "LEAGUE": Type.LEAGUE
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
