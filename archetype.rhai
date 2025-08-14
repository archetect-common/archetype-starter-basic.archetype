let context = #{};

context.archetect_version = archetect::version();

// This generally comes from ANSWERS, but prompting for it ensures it is in the context 
context += prompt("Project Author:", "author_full", #{
    placeholder: "Your Name <your.name@example.com>",
});

context += prompt("Archetype Description:", "description", #{
    placeholder: "Python Fast API Service"
});

let description = context.description;
remove(description, " archetype");
remove(description, " Archetype");
context.description = description;

context += prompt("Author:", "author_full", #{
    placeholder: "Your Name <your.name@domain.com>",
    help: "Author Name and Email",
});

context += prompt("Archetype Name:", "archetype-name", #{
    defaults_with: kebab_case(context["description"]),
    cases: [
        CasedIdentityCasedValue(PROGRAMMING_CASES),
        FixedKeyCasedValue("archetype-title", TitleCase),
    ],
});

context += prompt("Source Control:", "source-control", #{
  type: Select([
    "Github (Instructions)",
    "Github (Publish)",
    "None",
  ]),  
});

if context.contains("source-control") {
  if context["source-control"].starts_with("Github") {
    context += prompt("Github Organization:", "organization-name", #{
      placeholder: "orgname or username",
    });
    context += set("git-repo", render("git@github.com:{{ organization-name }}/{{ archetype-name }}.archetype.git#v1", context));
    render(Directory("contents/github"), context);
  }
}

render(Directory("contents/base"), context);

render(Archetype("gitignore"), Path(`${context["archetype-name"]}.archetype`), #{
    ignore: ["IDEA", "VSCode", "Eclipse"]
});

context["repo-name"] = render("{{ archetype-name }}.archetype", context);

git_init(context["repo-name"], "main");
git_add_all(context["repo-name"]);
git_commit(context["repo-name"], "initial commit");

if context["source-control"] == "Github (Instructions)" {
    display();
    display(render("cd {{ repo-name }}", context));
    display(render("gh repo create {{ organization-name }}/{{ repo-name }} --public --source=. --remote=origin", context));
    display("git push -u origin HEAD");
} else if context["source-control"] == "Github (Publish)" {
    git_remote_add(context["repo-name"], "origin", render("https://github.com/{{ organization-name }}/{{ repo-name }}.git", context));
    gh_repo_create(render("{{ organization-name }}/{{ repo-name }}", context), Private);
    git_push(context["repo-name"], "origin", "main");
}


