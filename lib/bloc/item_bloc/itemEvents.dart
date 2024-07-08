abstract class ItemEvent {}

class FetchItems extends ItemEvent{
}
class UpdateItem extends ItemEvent{
  final int id;
  final String title;
  final String body;

  UpdateItem({required this.id , required this.title , required this.body});
}
class DeleteItem extends ItemEvent{}