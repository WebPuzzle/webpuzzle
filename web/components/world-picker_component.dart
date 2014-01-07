part of webpuzzle;

@NgComponent(
    selector: 'world-picker',
    templateUrl: 'components/world-picker.html',
    publishAs: 'worldPickerCtrl',
    applyAuthorStyles: true
)
class WorldPickerComponent {
  
  WorldService worldService;
  String currentWorld;
  List<String> worlds;
  
  WorldPickerComponent(WorldService this.worldService) {
    currentWorld = worldService.world;
    worlds = WorldService.NICE_WORLDS_LIST;
    worlds.remove(currentWorld);
    print("WORLDS $worlds");
  }
  
}