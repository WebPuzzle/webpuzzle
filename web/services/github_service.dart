part of webpuzzle;

@NgInjectableService()
class GithubService {
  
  String githubApi = 'https://api.github.com';
  
  RegExp _regExp = new RegExp(r'https://github\.com/(.*)/(.*)');
  Http _http;
  UserService _userService;
  
  GithubService(Http this._http, UserService this._userService);
  
  Future<HttpResponse> checkRepo(String user, String repo) {
    return _http(method: 'GET', url:'$githubApi/repos/$user/$repo');
  }
  
  Future<HttpResponse> getUserRepos() {
    return _http(method: 'GET', url:'https://api.github.com/user/repos?access_token=${_userService.getToken()}').then((HttpResponse response) {
      return response.data;
    });
  }
  
  Future<HttpResponse> getReadmeRaw(String repositoryUrl){
    String user = getUserFromRepoUrl(repositoryUrl);
    String repoName = getRepoNameFromRepoUrl(repositoryUrl);
    if (user == null || repoName==null)
      return new Future(() => null);
    return _http(method: 'GET', url:'$githubApi/repos/$user/$repoName/readme').then((HttpResponse response){
        return response.data['content'];
      }, onError: (dynamic d){
        //onError won't get called in angular 0.9.3, bug should be solved in 0.9.4
        //https://github.com/angular/angular.dart/issues/224
        print("No readme for given repository");
      });
  }
  
  String getUserFromRepoUrl(String repositoryUrl){
    print(repositoryUrl);
    if (!_regExp.hasMatch(repositoryUrl))
      return null;
    Iterable<Match> matches = _regExp.allMatches(repositoryUrl);
    return matches.first.group(1);
  }
  
  String getRepoNameFromRepoUrl(String repositoryUrl){
    if (!_regExp.hasMatch(repositoryUrl))
      return null;
    Iterable<Match> matches = _regExp.allMatches(repositoryUrl);
    return matches.first.group(2);
  }
}