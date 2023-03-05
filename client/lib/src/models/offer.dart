class Offer {
  final int id;
  final String toolName;
  final String toolDescription;
  final String price;

  Offer({
    required this.id,
    required this.toolName,
    required this.toolDescription,
    required this.price,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      toolName: json['tool_name'],
      toolDescription: json['tool_description'],
      price: json['price'],
    );
  }
}