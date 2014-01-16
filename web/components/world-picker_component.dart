part of webpuzzle;

@NgComponent(
    selector: 'world-picker',
    templateUrl: 'components/world-picker.html',
    publishAs: 'worldPickerCtrl',
    applyAuthorStyles: true
)
class WorldPickerComponent implements NgDetachAware {
  
  WorldService worldService;
  String currentWorld;
  List<String> worlds;
  
  Router _router;
  
  WorldPickerComponent(WorldService this.worldService, Router this._router) {
    createMenu();
    worldService.onChangeWorld(createMenu);
    
  }
  
  void createMenu() {
    currentWorld = worldService.getNiceWorld();
    worlds = new List.from(WorldService.NICE_WORLDS_LIST);
    worlds.remove(currentWorld);   
    print("WORLDS $worlds");
  }
  
  detach() {
    worldService.removeOnChangeWorldCallback(createMenu);
  }
   
}