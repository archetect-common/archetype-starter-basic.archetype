# {{ description }}

This is an [Archetect](https://archetect.github.io/) archetype.

## Rendering

To generate content from this Archetype, copy and execute the following command:

```sh
  archetect render {% if git-repo %}{{ git-repo }}{% else %}<git repo>{% endif %}
```
