part of webpuzzle_spec;

class HttpTestGithubService extends Mock implements Http {
}

class UserServiceTestGithubService extends Mock implements Http {
}

testGithubService() {
  group("[GithubService]", () {
    HttpTestGithubService http;
    UserServiceTestGithubService userService;

    String repositoryUrl = "https://github.com/userName/repoName";

    setUp(() {
      http = new HttpTestGithubService();
      userService = new UserServiceTestGithubService();
    });

    test("should check repo", (){
      GithubService githubService = new GithubService(http, userService);
      http.when(callsTo("call")).thenReturn(null);
      githubService.checkRepo("user", "repo name");
      http.getLogs(callsTo("call")).verify(happenedOnce);
    });

    test("should get user repos", (){
      GithubService githubService = new GithubService(http, userService);
      http.when(callsTo("call")).thenReturn(
          new Mock()..when(callsTo("then")).thenReturn(null));
      githubService.getUserRepos();
      http.getLogs(callsTo("call")).verify(happenedOnce);
    });

    test("should get github url for readme info", (){
      GithubService githubService = new GithubService(http, userService);
      String readmeUrl = githubService.getReadmeUrl(repositoryUrl);
      expect(readmeUrl,
        equals('${githubService.githubApi}/repos/userName/repoName/readme'));
    });

    test("should handle getReadMeRaw success", (){
      var mockResponse = new Mock()..when(callsTo("get data")).thenReturn({'content':'test'});
      GithubService githubService = new GithubService(http, userService);
      var content = githubService.getReadmeRawSuccess(mockResponse);
      expect(content, equals("test"));
    });

    test("should get user from repository url", (){
      GithubService githubService = new GithubService(http, userService);
      expect(githubService.getUserFromRepoUrl(repositoryUrl),
        equals("userName"));
    });

    test("should get the repository name from repository url", (){
        GithubService githubService = new GithubService(http, userService);
        expect(githubService.getRepoNameFromRepoUrl(repositoryUrl),
          equals("repoName"));
    });
  });
}