# Vikunja - APIs and protocols

> [Vikunja](../index.md) · [features](features.md) · [gaps](gaps.md)

Source: https://vikunja.io/docs/api-documentation/ , retrieved 2026-11-16 (official). Version 2 of the API is named in a search excerpt only (`[offen]` for its details).

## Protocol and entry points

- REST API. The API documentation is served by each instance at `/api/v1/docs`; the specification is at `/api/v1/docs.json` (quoted: "The specification is hosted at `/api/v1/docs.json`").
- The page does not state a base path for requests as such; the `/api/v1` path follows from the docs URL.

## Authentication

- **API tokens** are the recommended method: "The recommended way to authenticate is with API tokens."
- **JWT** on self-hosted instances: "authenticate with username and password via the `/api/v1/login` endpoint to obtain a JWT token."
- **Vikunja Cloud** does not support username and password login (quoted).
- HTTP Basic: not mentioned on the page.
- Token scopes and creation path (Settings > API Tokens): from a search excerpt, not opened `[offen]`.

## Rate limits

- `[offen]`: the page makes no statement about rate limits. The instance-side limit ("The server received too many requests") exists in the UI strings (see [states.md](states.md)).

## Pagination and data format

- `[offen]`: not read on the page.

## Other interfaces named in the help index

- CalDAV, webhooks, MCP, import and export, OAuth 2.0 server (`/docs/oauth-server/`, listed in a search excerpt only). Details `[offen]`.
