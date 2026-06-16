class TicketModel {
  final String id;
  final String roomId;
  final double price;
  final int totalTickets;
  final int soldTickets;

  TicketModel({
    required this.id,
    required this.roomId,
    required this.price,
    this.totalTickets = 100,
    this.soldTickets = 0,
  });
}
