part of webpuzzle;

@NgDirective (
  selector: '[wp-tabs]'    
 )
class WpTab {
  
  Element element;
  List<Element> tabs;
  List<Element> contents;
  
  WpTab(Element this.element) {
    tabs = element.querySelectorAll("ul li");
    contents = element.querySelectorAll(".tab-pane");
    List<Element> links = element.querySelectorAll("ul li a");
    tabs.forEach((tab)=> tab.onClick.listen((e) => onTabClick(tab)));
  }
  
  void onTabClick(Element clickedTab){
    tabs.forEach((tab) {
      if (tab == clickedTab)
        tab.classes.add("active");
      else {
        if (tab.classes.contains("active"))
          tab.classes.removeWhere((className) => className == "active");
      }
    });

    String id = clickedTab.querySelector("a").attributes['data-id'];

    contents.forEach((content){
      String currentId = content.attributes['id'];
      if (currentId == id){
        content.classes.add("active");
        content.classes.add("in");
      } else {
        content.classes.removeWhere((className) => className == "active");
        content.classes.removeWhere((className) => className == "in");
      }
    });
  }
  
  
}