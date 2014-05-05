part of webpuzzle;

@Component(
    selector: '[wp-readme]',
    publishAs: 'readmeCtrl',
    templateUrl: 'components/readme.html'
)
class ReadmeComponent{
  @NgTwoWay("repository-url")
  String repositoryUrl;
  String readmeHtml;
  GithubService _githubService;
  
  ReadmeComponent(Scope scope, GithubService this._githubService){
    scope.watch('readmeCtrl.repositoryUrl', getReadMe);
  }

  void getReadMe(oldData, data){
    if (repositoryUrl != null){
      _githubService.getReadmeRaw("https://github.com/" + repositoryUrl).then((readmeRaw) => instantiateReadme(readmeRaw));
    }
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