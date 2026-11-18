# Search

**Status: draft (2026-11-18).** Back to the [interfaces](index.md). Mandatory chapter: every program that offers search follows it.

Legend: **[B]** = documented (source given), **[V]** = our proposal, not yet confirmed by the user, **[not documented]** = source not checked. The chapter promises only what is marked [B]; everything else is labelled as such.

## Starting point

- The wording of the "seven levels of search" is not in the repository, in the history or in the notes [B]. The seven kinds below follow the user's recollection (2026-11-18). Kinds 5 and 6 were forgotten; the user has confirmed them (2026-11-18).
- Principles (user): **each program decides which kinds of search it offers.** The server may ask all programs, external programs too, but only within the permissions granted in advance (next section).

## Basic principle: the person first

This principle applies everywhere, not only to search (user, 2026-11-18). Search returns **only what the contract or release allows in advance**. There is **no consent per search**.

1. **The person first.** It always starts from the person, not from functions.
2. **Permission in advance, by contract.** Everything has a permission, fixed **before** anything is searched.
3. **SCIM and OAuth per module.** Every module has SCIM and OAuth; at the network there is only that (ADR 0024).
4. **Federation with permissions.** In the network there are only admitted connections; the federation decides what goes out and what does not.
5. **Object, not field.** An object is shared, not field by field. Example: a profile is a view of the object Person with some fields left out.
6. **Share and give.** Share: others may see. Give: the data is handed over.
7. **Data minimisation outwards.** The further it goes out, the less data, on purpose.

**What the ADRs say today (only partly) [B]:** ADR 0070 line 143 (every call carries the identity of the human, the owner checks: check per call, not "in advance"); ADR 0024 lines 9 and 15-17 (programs "can" do OAuth2/SSO/SCIM; federation with release rules); ADR 0035 (federation); ADR 0020 lines 12-16 (addressing at the object; lending and giving); ADR 0058 line 10 (profile as a view of someone, leaving out fields not stated as a rule); ADR 0029 lines 25-29 (sensitive data leaves the device only with explicit release per recipient); plus the manifesto. For AI bots, rights are at most read and never more than the holder (ADR 0091). ADR 0054 binds a release to the state that was seen and signed. The wording was checked [B] only as a location (read only, origin/main 2026-11-18).

**Open:**

- **No ADR states the basic rule.** An ADR will be discussed with the user; a draft follows only after his word. This chapter does not invent it.
- Not stated in any ADR: the person as the starting point of every function (manifesto only); permission **in advance** (ADR 0070 checks per call); SCIM and OAuth as an obligation of every module (0024 says "can"); "share" and "give" as separate levels; a profile as a view with fields left out; "the further out, the less data".
- **Needs clarification:** ADR 0024 line 17 and ADR 0035 lines 6-7 say "the more trust, the more release"; the principle says "the further out, the less data". Both may hold side by side (trust between instances versus distance outwards); this is **not clarified**.

## The seven kinds of search

| # | Kind | Example |
|---|------|---------|
| 1 | Exact search (immediate, complete) | find an invoice |
| 2 | Slow, open search (stays open, hits arrive whenever they report) | a point on the map after three weeks |
| 3 | Slow search with time limit | stop after 1 hour |
| 4 | Slow search with user cancel | the person ends it |
| 5 | Stop by count / first hit | "the first 50", "any hit is enough" |
| 6 | Fuzzy / similarity search | typo tolerance, "sounds like" |
| 7 | Inexact search as on the web | sections, "1-20 of about 20,000" |

## Kind to standard

| # | Standard | Source | What is missing / extension |
|---|----------|--------|-----------------------------|
| 1 | JMAP `Foo/query` with `filter`, `sort`, `position`, `limit` [B] | RFC 8620 section 5.5 | No time limit, no cancel; the result comes complete or as an error. Locally: SQLite FTS5 for full text (BM25, prefix, trigram) [B: features], an engine function, not a protocol standard; a time limit only through an engine hook [not documented]. |
| 2 | JMAP `Foo/queryChanges` (`sinceQueryState`, `maxChanges`) and push (StateChange) [B] | RFC 8620 sections 5.6 and 7 | The standard has **no** "search still running" message; push reports state changes, not progress. |
| 2 | WebFinger [B]; W3C Linked Data Notifications [B: status]; ActivityPub [not documented] | RFC 7033; W3C Recommendation LDN | WebFinger resolves accounts, it does not search data. LDN delivers notifications, it is not a search query. |
| 3 | No standard found. HTTP `Retry-After` applies only to 503/3xx responses, not to run-time limits [B] | RFC 9110 section 10.2.3 | **Gap, closed by an extension** (decision 1 below). |
| 4 | No search standard; JMAP queries have no cancel concept [B: RFC 8620 section 5.5 has none]. IMAP: only by dropping the connection [not documented] | RFC 8620 section 5.5 | **Gap, closed by an extension** (decision 1 below). |
| 5 | JMAP `limit` (server may shorten and reports `limit`) [B]; IMAP ESEARCH `RETURN (MIN MAX COUNT)` [B] | RFC 8620 section 5.5; RFC 4731; RFC 9051 section 7.3.4 | Stops only the output, not the search at the provider (server side not specified); ESEARCH has no stop signal. |
| 6 | Unicode Collation (UCA, UTS #10 rev. 55) for sort/comparison keys [B] | UTS #10 | UCA orders, it does not measure similarity. Soundex, Metaphone, Levenshtein: no ISO/IETF/W3C standard known [not documented]. |
| 7 | OpenSearch 1.1: `totalResults`, `startIndex`, `itemsPerPage` [B: drafts 5 and 6, no official status] | GitHub dewitt/opensearch | Describes fields, not the way of counting; "about" is missing. JMAP `calculateTotal` is exact or nothing [B]. Approximate counting (Elasticsearch `track_total_hits`) [not documented: source not retrievable]. |
| - | CalDAV `calendar-query` REPORT [B]; CardDAV `addressbook-query` [B] | RFC 4791 section 7.8; RFC 6352 section 8.6 | Time-range and field filters, no full text; truncation via `DAV:number-of-matches-within-limits` (RFC 6352 section 8.6.2) [B]. |
| - | IMAP SEARCH [B] | RFC 9051 section 6.4.4 (replaces RFC 3501) | Mail criteria only, no time limit. |
| - | SPARQL 1.1 Query [B] | W3C Recommendation, 2013-03-21 | No time-limit, cancel or partial-result protocol. |

## Decisions (user, 2026-11-18)

1. **Time limit and cancel (kinds 3 and 4) are an extension of JMAP**, not a free home-grown solution. Rule: first keep to the standard, extend with evidence. The evidence "no standard" is above. The extension: a **time-limit parameter** and a **`cancel` command** on `/query` and on the open search. It goes on the list of the standards module (`fs-texts`) and is submitted later. The extension mechanism of RFC 8620 (section 11) is not yet checked [not documented].
2. **The open search (kind 2) has mandatory rules:**
   - it returns **only data allowed in advance by contract or release** (basic principle above); there is no consent per search (the earlier rule "only with the consent of those found" is dropped);
   - the **run time is always visible**;
   - it can be **ended at any time**.
3. **Kinds 5 and 6 are confirmed by the user** (5 = stop by count / first hit, 6 = fuzzy / similarity search).
4. **"Explain the kinds in the contract"** and **"server fan-out with permissions"** are proposals ([V], below). An ADR follows only after the user has read them.

## Operators

Legend as above. Source: research 2026-11-18, standard texts checked.

| Operator | Standard | Syntax | Source |
|----------|----------|--------|--------|
| AND | JMAP FilterOperator [B] | `"operator": "AND"` | RFC 8620 section 5.5 |
| AND | IMAP SEARCH [B] | several keys = AND (implicit) | RFC 9051 section 6.4.4 |
| AND | CQL [B]; SQLite FTS5 [B] | `and`; `a AND b` | Library of Congress CQL specification; sqlite.org/fts5.html section 3 |
| OR | JMAP [B]; IMAP [B]; CQL [B]; FTS5 [B] | `"operator": "OR"`; `OR <key1> <key2>`; `or`; `a OR b` | as above |
| NOT | JMAP [B] | `"operator": "NOT"` (none of the conditions matches) | RFC 8620 section 5.5 |
| NOT | IMAP [B]; CQL [B]; FTS5 [B] | `NOT <key>`; `a not b` (binary, and-not); `a NOT b` (binary) | RFC 9051 section 6.4.4; CQL; FTS5 |
| XOR | JMAP, IMAP, CQL, FTS5 | defined in none | **[not documented]** |

Further points, documented or not:

- If the JMAP `operator` is missing, section 5.5 gives no rule for it **[not documented]**.
- **I-Regexp (RFC 9485)** is a subset of regular expressions that only answers "matches / does not match" [B]: no captures, no lookaround, no `\w \d \s`, no back-references.
- FTS5 also has prefix (`thr*`), phrase (`"one two"`) and `NEAR(a b, N)` [B: sqlite.org section 3]; not a protocol standard.
- ECMA-262, PCRE, RE2, POSIX ERE/BRE: **not checked** and therefore not part of the proposal.

**Proposal [V]** (accepted on order 2026-11-18, not explicitly confirmed by the user):

1. **Logic: JMAP FilterOperator AND, OR, NOT**, nested through `conditions`, with **AND written explicitly** (the standard names no default).
2. **XOR is not a contract operator.** Programs and frontends may offer XOR as an input convenience and must translate it into `(A OR B) AND NOT (A AND B)`. The contract thus stays standard-pure; XOR gets no claim to a standard.
3. **Regex: I-Regexp only (RFC 9485).**
4. **Prefix, phrase, NEAR: as a labelled engine extension** (FTS5), not part of the protocol.
5. CQL and Lucene are not adopted (reference only).
6. Rule: **keep to the standard first, extend only with evidence.**

## Proposal: the contract explains the kinds of search [V]

Each program's contract gets a `search` field (list of kinds), for example:

```
search = [
  { kind = "exact" },
  { kind = "open-slow", push = true },
  { kind = "timed", limit_seconds = 3600 },
  { kind = "cancelable" },
  { kind = "limited", max_results = 50 },
  { kind = "fuzzy", algorithm = "uca-collation" },
  { kind = "approximate-count", count = "exact|approx" },
  { kind = "paged", page_size = 50 }
]
```

- The operators of a search query follow the section "Operators".
- Parameters per kind: time limit (seconds), page size (JMAP `limit`), counting kind (`exact` = JMAP `calculateTotal`; `approx`: [not documented]).
- If a kind is missing, the program says so explicitly (`supported = false`), never silently greyed out (rule on missing data sources).

## Proposal: the server asks all programs (fan-out) [V]

1. The server takes a search order `{query, kinds, limit, timeout}` and applies only the **permissions granted in advance** (basic principle above; ADR 0024, 0050, 0029 as cited in ADR 0067). It does not ask per search.
2. One request per program according to the contract above, only for kinds the program declares.
3. The answer per program is a `query` result (position/limit); changes arrive via `queryChanges`/push (open search).
4. Merging: order by hit score per program, then origin; a total only with `approx` or with the note "incomplete".
5. External programs: through the same standard interface (JMAP adapter or OpenSearch description), with their own permission key.
6. **Vault: only the blind index** (HMAC, ADR 0067), no plain-text index at the server; search over encrypted fields stays a task of the device.
7. Time limit and cancel: the server sets a deadline and sends `cancel` to the programs; partial results are marked `partial`.

## Where we already say something

| Place | Statement [B] |
|-------|---------------|
| `conventions/decisions/0070-thema-storage.md`, line 145 ("Huge trees") | `list` only one level with a cursor; search in the provider (flag `search`) |
| `conventions/decisions/0067-tresor-und-verschluesselung.md`, lines 23-43 | search over encrypted data is the device's task; blind index (HMAC) for exact search |
| `conventions/decisions/0086-gespeichert-wird-typisiert.md`, line 52 | search and queries run on the tables (`text`, `text_mark`); the index is never searched |

The PLAN files mentioning JMAP and search (`PLAN-angleichung-teil2/3`, `PLAN-insel-module`, `katalog-plan/ANFORDERUNGEN-baukasten`) match by text; their content has not been evaluated [B: hits only].

## Open points

1. Wording of the "seven levels" (from the user's memory, not in the repository).
2. Fuzzy algorithm: Soundex/Metaphone/Levenshtein are no standard. Own specification or none?
3. Check whether `cancel` and the time limit fit the extension mechanism of RFC 8620 section 11 [not checked].
4. Approximate counting: `track_total_hits` source to be added if needed.
5. The ADR for the contract field and the fan-out: only after the user has read this chapter.
6. The ADR for the basic principle "the person first": **open**, to be discussed with the user; a draft only after his word. Also the clarification "trust" versus "less data outwards".
7. Operators: default AND in JMAP implementations (server practice) and CQL `prox` not checked; ECMA-262, PCRE, RE2 and POSIX not checked.

Not documented in the research: Elasticsearch `track_total_hits`, status of Soundex/Metaphone, ActivityPub details, official OpenSearch page (only drafts on GitHub).
