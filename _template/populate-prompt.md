Populate the topic docs for the Exercism {{language}} track.

- Docs to edit: {{config}}/{{track}}/docs/track_topics/
- Track repository (read it, do not change it): {{repo}}

First read {{config}}/_common/AGENTS.md and {{config}}/_common/LLM_GUIDELINES.md.
Use the topic docs of the other tracks in {{config}}/ as examples of depth and style, but take no facts from them.

Then study the track repository: README and contributor docs, style guide, config.json, everything in bin/, CI workflows, test generators, and several exercises of different kinds.

Replace every TODO with facts about this track:

- Remove or correct any skeleton text that is not true for this track, including directories and commands that do not exist.
- Verify each statement against the repository.
  Read a script before describing what it does, needs, or modifies.
- Give exact, runnable commands and their prerequisites.
- Run validation commands where it is safe: nothing that changes the track repository, installs anything, or fetches from the network without my approval.
- Link to existing docs instead of copying them.
  Write relative links as they resolve from docs/track_topics/ inside the track repository.
- Write one sentence per line.
- Add a topic doc only if something important fits none of the existing ones, and list it in README.md.

If you cannot determine a fact, or the repository contradicts itself, do not guess: ask me, or leave it out and report it.

Finish by confirming that no TODO remains and that every relative link resolves in the track repository.
Report which commands you ran, which you could not, and any problems you found in the track.
