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
  defaults_with: "Github",
  type: Select([
    "Github",
    "None",
  ]),  
});

if context.contains("source-control") {
  if context["source-control"] == "Github" {
    context += prompt("Github Organization:", "organization-name", #{
      placeholder: "orgname/username",
    });
    context += set("git-repo", render("git@github.com:{{ organization-name }}/{{ archetype-name }}.archetype.git", context));
    render(Directory("contents/github"), context);
   
    display();
    display(render("cd {{ archetype-name }}.archetype", context));
    display("git init -b main");
    display(render("gh repo create {{ organization-name }}/{{ archetype-name }}.archetype --public --source=. --remote=origin", context));
    display("git add .");
    display("git commit -m 'initial commit'");
    display("git push -u origin HEAD");
  }
}

render(Directory("contents/base"), context);

render(Archetype("gitignore"), Path(`${context["archetype-name"]}.archetype`), #{
    ignore: ["IDEA", "VSCode", "Eclipse"]
});


