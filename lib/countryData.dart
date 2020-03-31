class CountryData {
  final String name;
  final int total_case, new_case, death, new_death, recovered, active, serious;

  CountryData({
    this.name,
    this.total_case,
    this.new_case,
    this.death,
    this.new_death,
    this.recovered,
    this.active,
    this.serious
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      name: json['name'],
      total_case: json['total_case'],
      new_case: json['new_case'],
      death: json['death'],
      new_death: json['new_death'],
      recovered: json['recovered'],
      active: json['active'],
      serious: json['serious'],
    );
  }
}