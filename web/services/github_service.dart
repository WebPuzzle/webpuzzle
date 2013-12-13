part of webpuzzle;

@NgInjectableService()
class GithubService {
  
  String githubApi = 'https://api.github.com';
  Http _http;
  
  GithubService(Http this._http);
  
  Future<HttpResponse> checkRepo(String user, String repo) {
    return _http(method: 'GET', url:'$githubApi/repos/$user/$repo');
  }
  
}