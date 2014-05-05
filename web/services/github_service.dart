part of webpuzzle;

@Injectable()
class GithubService {

  String githubApi = 'https://api.github.com';

  RegExp _regExp = new RegExp(r'https://github\.com/(.*)/(.*)');
  Http _http;
  UserService _userService;

  GithubService(Http this._http, UserService this._userService);

  /**
   * Checks if a github repo actually exists
   * Success callback is only called if it is
   */
  Future<HttpResponse> checkRepo(String user, String repo) {
    return _http(method: 'GET', url:'$githubApi/repos/$user/$repo');
  }

  /**
   * Gets GitHub repositories data for the current user github token
   */
  Future<HttpResponse> getUserRepos() {
    return _http(method: 'GET', url:'https://api.github.com/user/repos?access_token=${_userService.getToken()}').then((HttpResponse response) {
      return response.data;
    });
  }

  /**
   * Returns the raw readme data for a given repository url
   * This data is encoded in base64
   */
  Future<HttpResponse> getReadmeRaw(String repositoryUrl){
    String url = getReadmeUrl(repositoryUrl);
    if (url == null)
      return new Future(() => null);
    return _http(method: 'GET', url:url)
        .then(getReadmeRawSuccess, onError: (dynamic d){
        //onError won't get called in angular 0.9.3, bug should be solved in 0.9.4
        //https://github.com/angular/angular.dart/issues/224
        print("No readme for given repository");
      });
  }

  getReadmeRawSuccess(HttpResponse response){
    return response.data['content'];
  }

  /**
   * Returns the github url to get readme information
   */
  String getReadmeUrl(String repositoryUrl){
    String user = getUserFromRepoUrl(repositoryUrl);
    String repoName = getRepoNameFromRepoUrl(repositoryUrl);
    if (user == null || repoName==null)
      return null;
    return '$githubApi/repos/$user/$repoName/readme';
  }

  /**
   * Parses a given repository URL
   * to get the username associated
   */
  String getUserFromRepoUrl(String repositoryUrl){
    print(repositoryUrl);
    if (!_regExp.hasMatch(repositoryUrl))
      return null;
    Iterable<Match> matches = _regExp.allMatches(repositoryUrl);
    return matches.first.group(1);
  }

  /**
   * Parses a given repository URL
   * to get the repository name out of it
   */
  String getRepoNameFromRepoUrl(String repositoryUrl){
    if (!_regExp.hasMatch(repositoryUrl))
      return null;
    Iterable<Match> matches = _regExp.allMatches(repositoryUrl);
    return matches.first.group(2);
  }
}