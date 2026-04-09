# Ollama container entrypoint: chart-derived models

Contract between this **Ollama Helm chart** (versioned layout: `versions/<chart-version>/`) and the **Ollama image entrypoint** for **`ollama.models.derivedModels`**.

There is **no Helm hook Job** for derived models or for the catalog `pull:` list (catalog pulls use **`OLLAMA_AUTO_PULL_MODELS`** in the entrypoint only). The chart only supplies a manifest and environment variables; the **entrypoint** must apply them over **localhost** after the API is ready.

The chart continues to set **`OLLAMA_SYNC_RETAIN_MODELS_JSON`**: JSON array of model names that must not be removed by your pull/prune sync (`pull` ∪ **effective** derived names ∪ **`from`** for **included** derived rows only). **Effective** derived names are values `derivedModels[].name` after Helm appends **`-<Release.Namespace>`** (see §2.1). **Included** derived rows are those whose **`from`** appears in **`values.ollama.models.pull`** (exact string match; see §2.2); other rows are omitted from the manifest and do not add their derived name or `from` to retain JSON.

---

## 1. Environment variables

| Variable | When set | Meaning |
|----------|-----------|---------|
| `OLLAMA_DERIVED_MODELS_SYNC` | Always on the Ollama container | Literal **`entrypoint`**. Entrypoint must run the derived-models convergence path (see below). |
| `OLLAMA_DERIVED_MODELS_FILE` | When Helm’s **rendered** `derived-models.json` is **non-empty** (after §2.2 filter) | Absolute path to a **read-only** JSON file (UTF-8). Chart default: **`/etc/ollama/chart-derived-models/derived-models.json`**. |

If **`OLLAMA_DERIVED_MODELS_FILE` is unset** (empty manifest — no derived rows passed through the filter), the manifest has **zero entries** — skip derived convergence; do not fail.

---

## 2. Manifest file: `derived-models.json`

- **Format:** JSON **array** of objects.
- **Encoding:** UTF-8.
- **Each element:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | yes | Model name for `POST /api/create`. |
| `from` | string | yes | Base model; must exist before create; matches Modelfile `FROM` inside `modelfile`. |
| `modelfile` | string | yes | **Full Modelfile body** pre-rendered by Helm. Do not re-derive parameters in the entrypoint. |

### 2.1 Namespace suffix (Helm)

Helm renders each row’s `name` from **`values.ollama.models.derivedModels[].name`** plus **`-<Release.Namespace>`** so the same values can be installed in multiple namespaces without Ollama model name collisions.

- If the values `name` contains **`:`**, treat it as **`model:tag`** and append the suffix to **tag** only, e.g. `gpt-oss:20b-validator` in namespace `ollama6` → manifest `name` **`gpt-oss:20b-validator-ollama6`**.
- If there is **no** `:`, append **`-<Release.Namespace>`** to the whole string, e.g. `mymodel` → **`mymodel-ollama6`**.

The entrypoint must use the manifest `name` field exactly as written.

### 2.2 Pull catalog filter (Helm)

Helm **does not** call the Ollama API. It only includes a `derivedModels[]` row in `derived-models.json` when **`from`** is listed in **`values.ollama.models.pull`** (**exact** string match to one `pull` entry). List every base model you derive from in `pull` so the entrypoint receives that row; otherwise the row is dropped and **`OLLAMA_DERIVED_MODELS_FILE`** / the ConfigMap mount may be omitted entirely.

---

## 3. When to run

After:

1. Ollama listens on the configured host/port (e.g. `OLLAMA_HOST`).
2. **`GET /api/tags`** returns HTTP **200**.

Run **after** your usual auto-pull / prune that honors `OLLAMA_AUTO_PULL_MODELS` and `OLLAMA_SYNC_RETAIN_MODELS_JSON`.

**API base:** `http://127.0.0.1:<port>` (or `OLLAMA_HOST`).

---

## 4. Algorithm (per container start)

For each array element (in order):

1. **Pull** `from` if missing: `POST /api/pull` with `{"name":"<from>"}` (idempotent).
2. **Create/refresh:** `POST /api/create` with `{"name":"<name>","modelfile":"<modelfile>"}`.

On failure: exit **non-zero** (or your documented policy).

---

## 5. Removal (optional)

Names removed from Helm values drop out of `OLLAMA_SYNC_RETAIN_MODELS_JSON`. Optionally **`ollama rm`** derived names no longer in the manifest.

---

## 6. Limits

ConfigMap data ~**1 MiB** total. Large `modelfile` strings must fit.
