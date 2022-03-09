const githubBaseUrl = "https://api.github.com/search/users?q=";

const githubPerPageLimit = 30;

const githubResultExample = """
{
  "total_count": 1,
  "incomplete_results": false,
  "items": [
    {
      "login": "eliasciceros",
      "id": 69965844,
      "node_id": "MDQ6VXNlcjY5OTY1ODQ0",
      "avatar_url": "https://avatars.githubusercontent.com/u/69965844?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/eliasciceros",
      "html_url": "https://github.com/eliasciceros",
      "followers_url": "https://api.github.com/users/eliasciceros/followers",
      "following_url": "https://api.github.com/users/eliasciceros/following{/other_user}",
      "gists_url": "https://api.github.com/users/eliasciceros/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/eliasciceros/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/eliasciceros/subscriptions",
      "organizations_url": "https://api.github.com/users/eliasciceros/orgs",
      "repos_url": "https://api.github.com/users/eliasciceros/repos",
      "events_url": "https://api.github.com/users/eliasciceros/events{/privacy}",
      "received_events_url": "https://api.github.com/users/eliasciceros/received_events",
      "type": "User",
      "site_admin": false,
      "score": 1.0
    }
  ]
}
""";