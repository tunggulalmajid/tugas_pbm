class SubmitRequest {
  final String name;
  final double price;
  final String description;
  final String githubUrl;

  SubmitRequest({
    required this.name,
    required this.price,
    required this.description,
    required this.githubUrl,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "description": description,
    "github_url": githubUrl,
  };
}
