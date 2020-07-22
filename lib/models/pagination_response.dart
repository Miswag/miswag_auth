import 'dart:convert';

typedef ItemsCreator<S> = List<S> Function(List<dynamic> json);

class PaginationResponse<T> {
  ItemsCreator<T> creator;
  final dynamic rawData;
  final int currentPage;
  List<T> data = [];
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final String nextPageUrl;
  final String path;
  final int perPage;
  final String prevPageUrl;
  final int to;
  final int total;

  PaginationResponse(
      {this.rawData,
      this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total,
      this.creator}) {
    final List<T> items = creator(rawData as List<dynamic>);
    data = items;
  }

  PaginationResponse copyWith({
    int currentPage,
    final List<T> data,
    String firstPageUrl,
    int from,
    int lastPage,
    String lastPageUrl,
    String nextPageUrl,
    String path,
    int perPage,
    String prevPageUrl,
    int to,
    int total,
  }) =>
      PaginationResponse(
        currentPage: currentPage ?? this.currentPage,
        data: data ?? this.data,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

//  factory PaginationResponse.fromJson(String str) =>
//      PaginationResponse.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory PaginationResponse.fromMap(
      Map<String, dynamic> json, ItemsCreator<T> creator) {
    return PaginationResponse(
        currentPage:
            json["current_page"] == null ? null : json["current_page"] as int,
        rawData: json["data"],
        firstPageUrl: json["first_page_url"] == null
            ? null
            : json["first_page_url"] as String,
        from: json["from"] == null ? null : json["from"] as int,
        lastPage: json["last_page"] == null ? null : json["last_page"] as int,
        lastPageUrl: json["last_page_url"] == null
            ? null
            : json["last_page_url"] as String,
        nextPageUrl: json["next_page_url"] == null
            ? null
            : json["next_page_url"] as String,
        path: json["path"] == null ? null : json["path"] as String,
        perPage: json["per_page"] == null ? null : json["per_page"] as int,
        prevPageUrl: json["prev_page_url"] == null
            ? null
            : json["prev_page_url"] as String,
        to: json["to"] == null ? null : json["to"] as int,
        total: json["total"] == null ? null : json["total"] as int,
        creator: creator);
  }

  Map<String, dynamic> toMap() => {
        "current_page": currentPage ?? currentPage,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x)),
        "first_page_url": firstPageUrl ?? firstPageUrl,
        "from": from ?? from,
        "last_page": lastPage ?? lastPage,
        "last_page_url": lastPageUrl ?? lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path ?? path,
        "per_page": perPage ?? perPage,
        "prev_page_url": prevPageUrl,
        "to": to ?? to,
        "total": total ?? total,
      };
}
