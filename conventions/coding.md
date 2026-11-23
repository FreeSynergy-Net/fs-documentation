# Coding rules (all FreeSynergy repos) — ADR 0043

Read before writing or changing any code. Applies to Opus, Sonnet and humans alike.

## 1. Program against interfaces
- Every capability is first a **trait** (or a Cap'n Proto interface between programs, ADR 0021).
  Callers depend on the trait, never on a concrete type. Concrete types live behind it.
- Standards first: the interface follows the data standard (ADR 0014), not the other way round.
- Public API = traits + small data types. Implementations are `pub(crate)` unless there is a reason.

## 2. Design patterns — always, and named
Rust has no classes, but the patterns map cleanly. Use the pattern, and **say which one** in the
module doc (`//! Pattern: Repository over Store (strategy for the backend)`).

| Pattern | Rust form | Typical use here |
|---------|-----------|------------------|
| Strategy | trait + `dyn Trait` / generic `T: Trait`; for a closed set an enum with one `match` | storage backends, tile sources, highlighters, key providers |
| Repository | trait with CRUD/query over a `Store` | contacts, calendar, wiki pages |
| Adapter | struct wrapping a foreign type, implementing our trait | vCard/ICS/Markdown import, Blinc behind our components, Turso behind `Store` |
| Facade | one small type that hides a subsystem | `fs-hub-client`, program cores' entry points |
| Builder | `XBuilder` with `build() -> Result<X>` | complex construction (queries, compiler commands, envelopes) |
| Command | enum of operations + `apply`/`invert` | undo/redo, activity log |
| Observer | `tokio::sync::broadcast`/`watch`, listener traits, or closures the caller hands in | subscriptions, change streams |
| State | enum states + transition fns, or typestate generics | invitations, drafts, connections, delivery state |
| Template method | trait with provided default methods | shared flows (import → validate → store) |
| Decorator | wrapper implementing the same trait | `CachedSource` over `TileSource`, logging, metrics |
| Newtype | `struct ObjectId(Uuid)` | ids, units, validated values |
| Iterator | `impl Iterator` | paging, expansion (recurrences), tokenising |
| RAII / Guard | `Drop` | transactions, subscriptions, locks |
| Registry | map of kind → behaviour | mark kinds, representation register (ADR 0023) |
| Factory | fn/trait creating trait objects from config | choose backend/source at runtime |
| Value object | small immutable type, compared by value, valid on construction | dates, addresses, rules, plans |
| Specification | pure predicate over a value, combinable | the "encrypted only" gate, validation rules |
| Null object | a type that implements the trait and does nothing, on purpose | no-op listener, empty source |
| Composite | a tree of the same trait | nested layouts, nested filters |
| Memento | an opaque snapshot to restore or read from | undo, consistent reads |
| Visitor | one function per variant, kept outside the data; for a closed enum one `match` outside the data | walking a document or schema |
| Interpreter | evaluate a small language over its tree | recurrence rules, queries |
| Unit of Work | remembers what was there at the start and writes only what changed | form drafts |
| View function | a pure function from state to elements (Model–View–Update) | the views of components and workbenches |
| Data structure | name it: `Data structure: Fenwick tree` | heights of messages, a keyed forest |
| Capability object | a type only one place can hand out; holding it is the right | the port of a guard, a local enrolment |

No pattern for its own sake: pick the one that makes the code reusable and testable, and write why.

**Name only what is really there (2026-11-07).** A module head names a pattern from this table, plus how it is used here. A name that is not
in the table is reported to the strategy session, not invented. A file of constants is not a Registry, because nothing is looked up by
kind: it says `Constants`. A test file names what it tests; it has no pattern of its own. A type split over several files says so: `Adapter, part of MatrixProvider`. The check before a tag compares the name with the code.

**A small file without behaviour may say so (project owner, 2026-11-07):** `Pattern: none`, for error lists, plain data, constants, a single pure function or a small set of them for one concept, and a thin binary. A
made-up name is worse than an honest "none". Anything with behaviour still names a pattern and sits behind an interface. "Behaviour" here means state or side effects: a function that only computes its result from its arguments has none. A fixed sequence that reads, writes or calls out names its pattern (usually Facade or Template method), except the thin binary. If nothing fits, report it.

## 2a. Text a person reads (ADR 0057)
Translation itself comes later (ADR 0053), but text must be translatable from now on.
- No sentence a person reads inline in code. It goes in the program's `words.rs` or a component's `labels.rs`.
- A whole sentence with named placeholders, never joined from pieces: word order differs between languages. New text does not use positional `{}`.
- Code never decides by comparing text. It decides by a type, an id or a problem type.
- Numbers, dates and plurals are not formatted by hand when a reader sees them, as far as the code can avoid it.
- Log lines and developer errors stay English and are not translated.

## 3. Small files, many of them
- **One concept per file.** Guideline: **≤ 200 lines**, hard limit **300** (tests included —
  split tests by feature into `tests/<feature>.rs`). Generated code is exempt.
- Folders mirror concepts: `src/store/mod.rs` (trait) + `src/store/turso/{schema,query,undo,…}.rs`.
- `mod.rs`/`lib.rs` only declare modules and re-export; no logic there.

## 4. Reuse before writing
- Look first: existing FreeSynergy crate? existing permissive crate (ADR 0015)? Only then write.
- Shared code moves into a shared crate instead of being copied between repos.
- **Versions (ADR 0045, addendum 2026-11-23):** read versions and ranges only with the crate `semver`, package versions only with `rpm-version` (RPM EVR), name + version only with `fs_types::interface::{InterfaceVersion, InterfaceReq}`; no repo writes its own version reader (gate V-9 in fs-release).

## 5. Refactoring is part of the work
- Every change leaves the code at least as clean as before. When a file passes the limit or a
  second implementation of an idea appears → refactor now, not later.
- Refactoring commits are separate from feature commits (`refactor: …`), tests stay green.

## 6. Documentation — for people and for the next agent
- `//!` module doc on every module: purpose, **pattern used**, how it fits.
- `///` on every public item (`#![deny(missing_docs)]` in libraries).
- `DESIGN.md` per repo: architecture, **pattern map** (which pattern where, why), decisions, a
  **State** section kept current at every commit.
- Examples in `examples/` for every public entry point.

## 7. Quality gates (before every commit)
`cargo fmt --check` (**ohne** `--all` — `--all` prüft auch Pfad-Abhängigkeiten anderer Repos) · `cargo clippy --all-targets -- -D warnings` (with `clippy::pedantic` as warn) ·
`cargo test` · `scripts/check_rust_rules.py` (file length, module docs, pattern line) ·
Rust hygiene (ADR 0041).

## 8. Dependencies between our repos
- Always **git dependencies with a tag**, never local paths:
  `fs-objects = { git = "https://github.com/FreeSynergy/fs-objects", tag = "v0.2.0" }`.
- A change in a shared repo → new tag → dependents bump the tag in the same step.
- Working across repos on one machine: override temporarily with
  `cargo test --config 'patch."https://github.com/FreeSynergy/fs-objects".fs-objects.path="../fs-objects/crates/fs-objects"'`
  — never commit such paths (a fresh clone must build; check with a clone into `/tmp`).

### Addendum 2026-11-23: lowest libraries from the registry `freesynergy` (ADR 0093, addendum 2026-11-23)
Status: decided (strategy decision 23.11.; user will be informed, short template before K-5) · amends the first bullet of §8 for the crates named here; everything else stays git + tag.
- **`fs-types`, `fs-conformance`, `fs-records`** come from our Git-index registry `freesynergy` (repo `FreeSynergy-Net/fs-crates`):
  `fs-types = { version = "~0.0.N", registry = "freesynergy" }` (`~0.0.N` = `>=0.0.N, <0.1.0`, ADR 0045 addendum rule 4/5, transferred by analogy from contracts to Cargo dependencies).
  Each repo names the registry in `.cargo/config.toml` under `[registries.freesynergy]`.
  Raise `N` only when you use what the new version adds.
- **Only the release CI writes the index**, from a tag run. Never by hand. Crate version = tag (ADR 0064 addendum 2026-11-23); a gate checks it.
- **Baseline 0.0.7 (strategy decision 23.11.):** 0.0.7 is the first registry version. From 0.0.7 on, only additive changes in these crates; the 15 `#[non_exhaustive]` conversions and everything else breaking go bundled into 0.0.7 (setting the attribute later is itself a break). After that no exception: a break = new range + wave. Compare always against the previous registry version, never against earlier git tags.
- Public `enum`s are `#[non_exhaustive]`. **Gate:** `cargo-semver-checks --release-type minor` before the index entry (without it, `0.0.z → 0.0.(z+1)` counts as major and every break passes: `src/check_release.rs:79-81`). Baseline: `--baseline-root` on the unpacked last `.crate` (preferred; custom registries are unsupported, issue #160), fallback `--baseline-rev` previous tag. Mandatory mutant in K-2: a new variant in an exhaustive enum turns the gate red. The range `~0.0.N` has upper bound `<0.1.0` always and cannot fence a deliberate break; only the complete wave and the lock gate protect.
- capnpc-generated enums (`BasicType`, `CommandKind`) cannot be `#[non_exhaustive]`: a `match` on them outside the generator needs a catch-all arm (ast-grep check in fs-conformance); the gate has a narrowly named allowance for "enum variant added" on exactly these types, justified in the file. A `match` on such an enum outside the crate (including generated code) has a catch-all arm that reports visibly. Never swallow an unknown value silently.
- **After a new version:** programs run `cargo update -p fs-types` (lock change only). The lock gate (ADR 0092 rule 2) turns red on two entries.
- **Working on one machine:** `[patch.freesynergy] fs-types = { path = "../fs-types/crates/fs-types" }` or the same via `--config`. Never commit it, as above.
- **Status:** until branch protection is on for `fs-crates`, the registry is "initial phase, not protected" (ADR 0093 addendum, threat model).


## 9. Trait folders (locked interfaces) — binding (b7, 2026-11-16)
- The folder `<trait>_v<n>/` lives in the **program repo, in the crate that carries the trait as its public API**
  (example: `fs-people-directory/src/person_directory_v1`).
- `draft/` in the `testdata` crate holds the trait **only while it is a draft**; when the trait is locked, it moves to its fixed place (above).
- The Cap'n Proto contract always lives in `fs-interfaces/schema`, never next to the trait folder (plus its line in `fs-interfaces/schema/capabilities.txt`).
