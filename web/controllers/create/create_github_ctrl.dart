part of webpuzzle;

@NgController(
    selector: "[github-ctrl]",
    publishAs: "githubCtrl"
)
class CreateGithubCtrl {
  
  List userRepos;
  String githubLink;
  GithubService _githubService;
  WorldService _worldService;

  CreateGithubCtrl (Scope scope, GithubService this._githubService, Router router, WorldService this._worldService){
    _githubService.getUserRepos().then((repos) => userRepos = repos );
    print("repo $userRepos");
    
    scope['moveToAddInfos'] = (githubLink) {
      String user = _githubService.getUserFromRepoUrl(githubLink);
      String repo = _githubService.getRepoNameFromRepoUrl(githubLink);
      _githubService.checkRepo(user, repo)
        .then((HttpResponse httpResponse) {
          router.go('app.create.additionalInfo', {"world": _worldService.getNiceWorld(), "user": user, "repo": repo });
        });
    };
    
    scope['worldService'] = _worldService;
    
  }
  
  
  
}

