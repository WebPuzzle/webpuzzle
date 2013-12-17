part of webpuzzle;

@NgDirective (
  selector: '[wp-dropdown-menu]'    
 )
class WpDropdownMenu {
  
  Element element;
  Element dropdownMenu;
  
  WpDropdownMenu(Element this.element) {
    
    dropdownMenu = element.querySelector('.dropdown-menu');
    
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