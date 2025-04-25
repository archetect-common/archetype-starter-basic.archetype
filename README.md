# Archetect Archetype Starter: Basic

![Latest Release](https://img.shields.io/github/v/release/archetect-common/archetype-starter-basic.archetype?style=flat-square&label=Latest%20Release&color=blue)

This is an [Archetect](https://archetect.github.io/) archetype.

## Rendering

To generate an Archetype from this Archetype, copy and execute the following command:

```sh
archetect render https://github.com/archetect-common/archetype-starter-basic.archetype.git
```

This is an [Archetect](https://archetect.github.io/) archetype for scaffolding
out a very basic archetype with very few features. This archetype is useful for
exploring the features of Archetect, or if your archetype is very simple. There
are other Archetype archetypes that provide more complete scaffolding.

## Archetype Layout

Archetect has flexibility in how an archetype is laid out. However, the defaults,
as used in this archetype, should cover the vast majority of cases.

### Archetype Configuration

The `./archetype.yaml` manifest contains configuration for this archetype,
including:

- The minimum `Archetect` version required to render this archetype (required).
- Any component Archetypes this archetype may compose (optional).
- Customized locations for the main script, content root directory, templating
  macros and layouts directory, and scripting modules directory (optional).

### Archetype Script

The `./archetype.rhai` script contains the logic for building up a context model,
usually through interactive prompting, and rendering content.

### Contents Directory

The `./contents` directory contains the files and directories, by convention,
that will be rendered into the newly generated archetype.

This directory can be rendered by a `Directory` type in Rhai.
You may also break the contents up into sub-directories within this directory
for more complex archetypes, or archetypes that require conditional rendering.

```rhai
let context = #{};

context.first_name = "John";
context.last_name = "Doe";

// Render everything in ./contents
render(Directory("contents"), context);

// Only render ./contents/manifests
render(Directory("contents/manifests"), context);
```

``
