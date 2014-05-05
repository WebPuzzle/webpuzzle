part of webpuzzle;

@Decorator (
  selector: '.dropdown-toggle'    
 )
class WpDropdownMenu {
  
  Element element;
  Element dropdownMenu;
  
  WpDropdownMenu(Element this.element) {
    
    element.style.cursor = 'pointer';
    dropdownMenu = element.querySelector('.dropdown-menu');
    
    print("dropdown-menu = ${dropdownMenu}");
    
    document.onClick.listen((e) {
     dropdownMenu.style.display = 'none';
    });
    
    element.onClick.listen((e) {
      if (dropdownMenu.style.display == 'block') 
        dropdownMenu.style.display = 'none';
      else
        dropdownMenu.style.display = 'block';
      e.stopPropagation();
    });
  }
  
}