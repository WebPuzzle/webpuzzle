part of webpuzzle;

@NgInjectableService()
class GithubService {
  
  String githubApi = 'https://api.github.com';
  
  RegExp _regExp = new RegExp(r'https://github\.com/(.*)/(.*)');
  Http _http;
  
  GithubService(Http this._http);
  
  Future<HttpResponse> checkRepo(String user, String repo) {
    return _http(method: 'GET', url:'$githubApi/repos/$user/$repo');
  }
  
  Future<HttpResponse> getReadmeRaw(String repositoryUrl){
    String user = _getUserFromRepoUrl(repositoryUrl);
    String repoName = _getRepoNameFromRepoUrl(repositoryUrl);
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
  
  String _getUserFromRepoUrl(String repositoryUrl){
    print(repositoryUrl);
    if (!_regExp.hasMatch(repositoryUrl))
      return null;
    Iterable<Match> matches = _regExp.allMatches(repositoryUrl);
    return matches.first.group(1);
  }
  
  String _getRepoNameFromRepoUrl(String repositoryUrl){
    if (!_regExp.hasMatch(repositoryUrl))
      return null;
    Iterable<Match> matches = _regExp.allMatches(repositoryUrl);
    return matches.first.group(2);
  }
}