part of webpuzzle;

@NgComponent(
    selector: '[wp-readme]',
    publishAs: 'readmeCtrl',
    templateUrl: 'components/readme.html'
)
class ReadmeComponent{
  @NgTwoWay("repository-url")
  String repositoryUrl;
  String readmeHtml;
  
  ReadmeComponent(Scope scope, GithubService githubService){
    scope.$watch('readmeCtrl.repositoryUrl', (data) {
      if (repositoryUrl != null){
        githubService.getReadmeRaw("https://github.com/" + repositoryUrl).then((readmeRaw) => instantiateReadme(readmeRaw));
      }
    });
  }
  
  void instantiateReadme(String readmeRaw){
    if (readmeRaw == null){
      print("! invalid github repository url, readmeRaw is null ! ");
      return;
    }
    var readme = decodeUtf8(CryptoUtils.base64StringToBytes(readmeRaw));
    readmeHtml = markdown.markdownToHtml("$readme");
  }
}