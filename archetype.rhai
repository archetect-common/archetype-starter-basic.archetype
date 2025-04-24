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

context += prompt("Archetype Name:", "archetype-name", #{
    defaults_with: kebab_case(context["description"]),
    cases: [
        CasedValue(KebabCase),
    ],
});



context += prompt("Author:", "author_full", #{
    placeholder: "Your Name <your.name@domain.com>",
    help: "Author Name and Email",
});

context += prompt("Git Repo:", "git-repo", #{
    placeholder: `http://github.com/your-name/${context["archetype-name"]}.archetype.git`,
    optional: true,
});

render(Directory("contents"), context);

render(Archetype("gitignore"), Path(`${context["archetype-name"]}.archetype`), #{
    ignore: ["IDEA", "VSCode", "Eclipse"]
});


