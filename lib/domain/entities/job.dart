class Job {
  final String id;
  final String title;
  final String company;
  final String location;
  final String jobType;
  final String description;
  final String? salary;
  final bool isFavorite;
  final String? companyLogo;
  final DateTime postedDate;

  Job({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.jobType,
    required this.description,
    this.salary,
    this.isFavorite = false,
    this.companyLogo,
    required this.postedDate,
  });

  Job copyWith({
    String? id,
    String? title,
    String? company,
    String? location,
    String? jobType,
    String? description,
    String? salary,
    bool? isFavorite,
    String? companyLogo,
    DateTime? postedDate,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      jobType: jobType ?? this.jobType,
      description: description ?? this.description,
      salary: salary ?? this.salary,
      isFavorite: isFavorite ?? this.isFavorite,
      companyLogo: companyLogo ?? this.companyLogo,
      postedDate: postedDate ?? this.postedDate,
    );
  }

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? json['job_title'] ?? 'Untitled Position',
      company: json['company'] ?? json['company_name'] ?? 'Unknown Company',
      location: json['location'] ?? json['job_location'] ?? 'Remote',
      jobType: json['jobType'] ?? json['job_type'] ?? json['employment_type'] ?? 'Full-time',
      description: json['description'] ?? json['job_description'] ?? 'No description available',
      salary: json['salary'] ?? json['salary_range'],
      companyLogo: json['companyLogo'] ?? json['company_logo'],
      postedDate: json['postedDate'] != null
          ? DateTime.parse(json['postedDate'])
          : json['posted_date'] != null
              ? DateTime.parse(json['posted_date'])
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'location': location,
      'jobType': jobType,
      'description': description,
      'salary': salary,
      'companyLogo': companyLogo,
      'postedDate': postedDate.toIso8601String(),
    };
  }
}