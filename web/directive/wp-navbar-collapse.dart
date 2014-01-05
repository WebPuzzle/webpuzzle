part of webpuzzle;

@NgDirective (
  selector: '.navbar[role=navigation]'    
 )
class WpNavbarCollapse {
  
  Element element;
  Element navbarCollapse;
  
  WpNavbarCollapse(Element this.element) {
    navbarCollapse = element.querySelector('.navbar-collapse');
    
    document.onClick.listen((e) {
     navbarCollapse.style.display = 'none';
    });
    
    element.onClick.listen((e) {
      
      if (navbarCollapse.style.display == 'block')
          navbarCollapse.style.display = 'none';
      else
        navbarCollapse.style.display = 'block';
      e.stopPropagation();
    });
  }
  
}