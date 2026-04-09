# Ollama Helm Chart



> **✅ Production-grade build**  
> This chart is hardened for production use and does not include AI developer toolchains.  
> Only pre-compiled / pre-optimized GGUF format models are supported.  

> **⭐ Follow this chart for updates and security patches!**  
> This chart is actively maintained. We highly recommend following it on Artifact Hub or GitHub to stay informed about new releases, security updates, and important changes. Regular updates are crucial for keeping your AI workloads safe and secure.

> **🐛 Need Help? Report Issues**  
> If you encounter issues, have feature requests, please report them via our GitHub Issues page:  
> **[https://github.com/arktec-quant/public-charts/issues](https://github.com/arktec-quant/public-charts/issues)**  
> When reporting issues, please include your Helm chart version, Kubernetes cluster information, relevant logs, and your values.yaml configuration (sanitized of secrets).

---

A production-grade, security-hardened Helm chart by Arktec Quant for Ollama with multi-model serving, quantisation support, and GitOps-first configuration. Built with hardened SecOps defaults. Main container aligns with Kubernetes Pod Security Standards (Restricted); init containers run as root for setup tasks.

**A secure and GitOps-optimized Ollama chart. Supports any community and commercial use cases that Ollama develops. One of the fine-tuned and verified inference backends for Arktec Quant Agentic Fabric's Cortex and Agent runtimes.**

## Overview

Ollama is a hardened, production-ready Helm chart for deploying Ollama on Kubernetes with advanced capabilities, including:

- Multi-model serving (load and serve multiple models)
- Quantisation support (GGUF format)
- HuggingFace Hub integration (token support for private models and rate limit avoidance)
- GPU control and auto-detection
- Configurable logging levels and startup diagnostics
- Model preloading and management (automatic pull before run)
- Main container aligned with Kubernetes Pod Security Standards (Restricted)
- GitOps-first configuration (ArgoCD, Flux)
- Non-root, read-only filesystem, PVC-backed design
- Extensible network policies + minimal attack surface
- Custom-built Ollama image (`ghcr.io/arktec-quant/ollama:v0.18.2-cuda-12.8`, CUDA 12.8) built from scratch with security hardening and optimizations

**Upstream Ollama 0.18.x highlights (default image `v0.18.2-cuda-12.8`, CUDA 12.8; app/Ollama release `v0.18.2`):**
- `ollama launch` for using Ollama models with tools like Claude Code / Codex / OpenCode / Droid (**unapplicable**)
- CLI quality-of-life fixes (multi-line strings in `ollama run`, newline insertion via Ctrl+J / Shift+Enter)
- `ollama launch clawdbot` command added in `v0.18.2` (**unapplicable**)
- **New: `ollama.contextLength` / `OLLAMA_CONTEXT_LENGTH`** to override the default context window size (e.g. `4096`, `32768`, `131072`, or string `"0"` for Ollama no-limit; chart sets env value `0`)

Upstream release notes: [ollama/ollama `v0.18.2`](https://github.com/ollama/ollama/releases/tag/v0.18.2)

The chart is designed for enterprise-grade usage, multi-agent workloads, and modern GPU clusters.

## Why another Ollama Helm chart?

This is an original Helm chart independently developed by Arktec Quant for deploying Ollama on Kubernetes. While Ollama provides a simple Docker image, this chart is a complete, production-ready solution with comprehensive security hardening, GitOps optimization, and advanced features.

### Key Enhancements

**Security-hardening:**
- Non-root execution
- Read-only root filesystem
- No elevated capabilities
- Strict `allowPrivilegeEscalation: false`
- Pod Security Standards (Restricted) alignment
- Optional egress lockdown + DNS-only rules
- PVC-backed temp/cache/model storage
- NetworkPolicy isolation

**Operational upgrades:**
- Multi-model support
- Environment variable configuration (Ollama uses env vars, not CLI args)
- GitOps schema validation (values.schema.json)
- Consistent directory layout for hardened filesystems
- Health check probes optimized for Ollama

**Cluster-friendly:**
- Works on K3s, K8s, AKS, EKS, GKE
- GPU autoscaling compatible
- RWO/RWX storage compatible
- Supports node selectors + tolerations

## Design Philosophy

This chart follows six core principles to provide secure, production-ready Ollama deployments:

### 1. **Safe Defaults for All Users**

The chart enforces secure defaults to protect users from common configuration mistakes. These defaults include:
- `readOnlyRootFilesystem: true`
- Correct PVC-backed `/models` directory
- `TMPDIR` set to `/models/tmp`
- `seccomp: RuntimeDefault`
- Dropped capabilities
- Disabled service account token

These secure defaults protect users from common pitfalls related to GPU scheduling, temp-dir restrictions, model caching, and read-only filesystem implications. This approach aligns with best practices used by quality community charts such as **Bitnami**, **Thanos**, **Argo Workflows**, and **Prometheus Operator**.

### 2. **Flexibility for Power Users**

The chart provides a secure baseline while allowing full customization when needed. Users can:
- Disable network policies
- Change security contexts
- Supply custom GPU configurations
- Change model cache paths
- Enable/disable persistence
- Replace image digest or registry
- Configure all Ollama environment variables

All security defaults can be overridden, providing flexibility for advanced use cases while maintaining secure-by-default behavior.

### 3. **Proactive Problem Solving**

The chart addresses common Ollama deployment issues automatically:
- Model storage directory requirements
- Temporary directory requirements
- GPU reset handling with proper probes
- Root filesystem write failures in hardened clusters
- Image registry tag changes affecting reproducibility

These solutions are built into the chart to prevent common deployment failures and reduce troubleshooting time.

### 4. **Universal Portability**

The chart is designed to work across different Kubernetes environments:
- Any CNCF-conformant Kubernetes distribution
- Managed Kubernetes services (AKS, EKS, GKE)
- Local development environments
- Bare-metal and cloud deployments
- Any cluster with compatible storage provisioner

The PVC-based approach for temporary directories ensures portability across all these environments, regardless of Ollama's storage requirements.

### 5. **Contemporary Kubernetes Security Alignment**

The chart implements modern Kubernetes security best practices:
- **PSS: restricted** - Pod Security Standards restricted profile
- **Disallow root** - Non-root execution enforced
- **No service account auto-token** - Token auto-mount disabled
- **RuntimeDefault seccomp** - Container runtime security profiles
- **No CAPs** - All capabilities dropped
- **Read-only root FS** - Immutable filesystem
- **PVC as writable workspace** - Persistent volumes for writable data

These security settings align with SIG-Security recommendations and Kubernetes security best practices.

### 6. **Secure Defaults for Production**

The chart ships with secure defaults that:
- Discourage insecure patterns
- Reduce risk of supply chain tampering
- Avoid best-practice violations
- Enable organizations to adopt Ollama safely

These defaults help organizations deploy Ollama in production environments with appropriate security guardrails.

## Attribution and Credits

**Ollama Project Attribution:**
This Helm chart is developed and maintained by Arktec Quant and uses the [Ollama project](https://github.com/ollama/ollama). The Ollama inference engine and its codebase are developed and maintained by the [Ollama team](https://github.com/ollama/ollama). We extend our gratitude to the Ollama project contributors for their excellent work on the core inference engine.

**Ollama Chart & Image:**
This Helm chart (ollama) is an original, independently developed chart by Arktec Quant. It is not a fork, copy, or derivative of any official Ollama Helm chart. The chart uses a custom-built Ollama image (`ghcr.io/arktec-quant/ollama:v0.18.2-cuda-12.8`) that is **built from scratch**, not derived from the official `ollama/ollama` Docker image.

**Image Build Details:**
- **Base Image**: Custom-built from scratch (not using official `ollama/ollama` as base)
- **Security Hardening**: Non-root execution, read-only filesystem, minimal attack surface
- **Configuration**: All configuration via environment variables (Ollama's design)
- **Version**: 0.18.2 (image `v0.18.2-cuda-12.8`, CUDA 12.8)

The chart itself was built from scratch with a focus on security hardening, GitOps optimization, and production-ready configurations for deploying Ollama on Kubernetes.

**License:**
- **Ollama project**: Licensed under MIT by the Ollama project
- **ollama Helm chart and custom image**: Licensed under Apache 2.0 by Arktec Quant (see LICENSE file)

See the [NOTICE](NOTICE) file for detailed attribution requirements.

## Security Features

This chart implements comprehensive security defaults designed to mitigate supply chain risks and provide maximum security guardrails. All security defaults are **automatically applied via template defaults**, ensuring secure-by-default deployments even without a `values.yaml` file.

### Security Defaults (Applied Automatically)

The chart enforces multiple layers of security by default, reducing the attack surface and preventing common container escape and privilege escalation attacks. These defaults are implemented in the template, providing **security-by-default** even if `values.yaml` doesn't specify `securityContext`.

**Container Security Context (Template Defaults):**
```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  runAsGroup: 1000
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop: ["ALL"]
    add: []
  seccompProfile:
    type: RuntimeDefault
```

**Key Security Features:**
1. **seccompProfile: RuntimeDefault** - Container runtime security profiles for system call filtering
2. **Capabilities drop: ALL** - All Linux capabilities explicitly dropped, empty add list
3. **readOnlyRootFilesystem: true** - Prevents unauthorized file system modifications
4. **Non-root execution** - Runs as user ID 1000 (ollama user) with `runAsNonRoot: true`

**PVC Usage for Writable Paths:**
The chart uses a PVC for all writable paths:
- `/models` → model store (OLLAMA_MODELS)
- `/models/tmp` → TMPDIR

If the PVC is disabled, the deployment will fail as intended.

**Pod Security Context:**
- **fsGroup**: Set to 1000 for proper volume ownership (matches ollama user GID)
- **fsGroupChangePolicy**: `OnRootMismatch` to avoid unnecessary chown operations on large PVCs

### Pod Security Standards (PSS)

The chart enforces **Pod Security Standards (PSS) restricted profile** for the main container:
- **PSS Labels**: `pod-security.kubernetes.io/enforce: restricted` (applies to the pod)
- **Main container**: Fully compliant with Restricted profile (non-root, read-only root filesystem, no capabilities, seccomp)
- **Init containers**: Run as root for setup tasks (fixing permissions, creating directories) - this is a common pattern for init containers that perform initialization
- **Configurable levels**: Can be set to `baseline` or `restricted` via `podSecurityStandards.enforce`
- **Host network disallowed**: `hostNetwork: false` enforced
- **Host path volumes disallowed**: Prevents hostPath volume mounts

### Network Security

**NetworkPolicy (Optional, Enabled by Default):**

The chart includes an optional NetworkPolicy that provides:
- Deny-all baseline
- Allow ingress to port 11434 (Ollama default)
- Allow DNS egress (restricted to cluster DNS pods only)
- Block intra-cluster lateral movement
- **DNS Tunneling Prevention**: DNS queries are restricted to cluster-managed DNS pods only

**Policy Rules:**
- **Ingress**: Allows traffic on service port only
- **Egress**: Blocks cluster-internal communication and private IP ranges
- **Internet access**: Allows only HTTPS (443) for external connections
- **DNS resolution**: Restricted to cluster DNS pods (`kube-dns`/`coredns` in `kube-system` namespace)

### Service Account Security

- **Token auto-mount disabled**: `automountServiceAccountToken: false` by default
- **Minimal RBAC**: Optional Role/RoleBinding with only necessary permissions

> **⚠️ Critical**: A PVC must be provided when persistence is enabled. This PVC is used for all model files and temporary working directories. The PVC is mounted at `/models` and used for:
> - Model storage (`OLLAMA_MODELS` points to `/models`)
> - Writable temporary directory (`/models/tmp` via `TMPDIR` environment variable)
> 
> **Deployments without a PVC will fail because Ollama requires a writable directory for models.** The chart includes an init container that automatically sets up the `/models/tmp` directory on the PVC.

## Getting Started

### Standard Deployment

```bash
helm repo add arktecquant https://charts.arktecquant.com
helm install ollama arktecquant/ollama
```

This deploys Ollama with:
- Read-only root filesystem
- Required PVC for models + temp dirs
- Default secure NetworkPolicy
- Minimal environment variables
- Default port 11434

### CPU-Only Deployment (Testing/Development)

For CPU-only clusters or testing without GPUs:

```bash
helm install ollama arktecquant/ollama\
  --set resources.limits."nvidia.com/gpu"="" \
  --set resources.requests."nvidia.com/gpu"="" \
  --set persistence.enabled=false
```

**Note**: CPU-only deployments are significantly slower than GPU-accelerated inference and are recommended only for testing, development, or very small models.

## Prerequisites

- Kubernetes ≥ 1.26
- Helm 3.2.0+
- **GPU nodes (optional)**: NVIDIA GPU nodes required for GPU-accelerated inference
  - NVIDIA Container Runtime
  - NVIDIA device plugin installed in your cluster
- **CPU-only deployments**: Supported for testing/development (slower performance)
  - Set `resources.limits.nvidia.com/gpu: ""` and `resources.requests.nvidia.com/gpu: ""` in values
- PVC (mandatory when persistence.enabled=true, RWO or RWX depending on setup)
- StorageClass provisioner (any Kubernetes-compatible storage provisioner)

## Configuration

Ollama uses environment variables for configuration (not CLI arguments). The chart supports all Ollama environment variables:

### Core Configuration

| Chart Parameter | Environment Variable | Description | Default |
|----------------|---------------------|-------------|---------|
| `ollama.port` | `OLLAMA_HOST` | Server port (auto-set to `0.0.0.0:<port>`) | `11434` |
| `ollama.host` | `OLLAMA_HOST` | IP Address for the server | `""` (auto) |
| `ollama.cloud.disable` | `OLLAMA_NO_CLOUD` | Disable Ollama Cloud features (`1` when true) | `false` |
| `ollama.cloud.apiKey` | `OLLAMA_API_KEY` | Direct cloud API key value (prefer secret for production) | `""` |
| `ollama.cloud.apiKeySecret.name/key` | `OLLAMA_API_KEY` | Secret-based cloud API key source | `""` / `"api-key"` |
| `ollama.debug` | `OLLAMA_DEBUG` | Show debug information | `""` (disabled) |
| `ollama.keepAlive` | `OLLAMA_KEEP_ALIVE` | Duration models stay loaded | `"5m"` |
| `ollama.maxLoadedModels` | `OLLAMA_MAX_LOADED_MODELS` | Max loaded models per GPU | `null` |
| `ollama.maxQueue` | `OLLAMA_MAX_QUEUE` | Max queued requests | `null` |
| `ollama.modelsPath` | `OLLAMA_MODELS` | Path to models directory | `""` (auto) |
| `ollama.numParallel` | `OLLAMA_NUM_PARALLEL` | Max parallel requests | `null` |
| `ollama.noPrune` | `OLLAMA_NOPRUNE` | Do not prune unused model blobs on startup | `false` |
| `ollama.origins` | `OLLAMA_ORIGINS` | Allowed CORS origins | `""` |
| `ollama.schedSpread` | `OLLAMA_SCHED_SPREAD` | Schedule across all GPUs | `false` |
| `ollama.flashAttention` | `OLLAMA_FLASH_ATTENTION` | Enable flash attention | `false` |
| `ollama.kvCacheType` | `OLLAMA_KV_CACHE_TYPE` | KV cache quantization type | `""` |
| `ollama.llmLibrary` | `OLLAMA_LLM_LIBRARY` | LLM library (cuda/rocm/metal/cpu) | `""` |
| `ollama.gpuOverhead` | `OLLAMA_GPU_OVERHEAD` | Reserve VRAM per GPU (bytes) | `null` |
| `ollama.loadTimeout` | `OLLAMA_LOAD_TIMEOUT` | Model load timeout. **Note**: Set to `"0"` for shorter first time to token and pseudo-real-time responses | `"5m"` |
| `ollama.gpu.enabled` | `OLLAMA_GPU` | Force GPU mode on/off | `false` |
| `ollama.logLevel` | `OLLAMA_LOG_LEVEL` | Logging verbosity (debug/info/warn/error) | `"info"` |
| `ollama.ginMode` | `GIN_MODE` | GIN framework mode (debug/release) | `"debug"` |
| `ollama.startupDiagnostics.enabled` | `OLLAMA_STARTUP_DIAGNOSTICS` | Show diagnostic info at startup | `true` |
| `ollama.showServerLogs` | `OLLAMA_SHOW_SERVER_LOGS` | Enable display of server logs in container output | `false` |
| `ollama.insecure` | `OLLAMA_INSECURE` | Allow insecure model pulls | `false` |

### Models: pull list, derived models, retain JSON

| Chart parameter | Environment / mechanism | Description | Default |
|----------------|-------------------------|-------------|---------|
| `ollama.models.pull` | `OLLAMA_AUTO_PULL_MODELS` | Comma-separated catalog/HF models for entrypoint pull + sync | `[]` |
| `ollama.models.autoPull.enabled` | (gates `OLLAMA_AUTO_PULL_MODELS`) | When `false`, entrypoint does not receive auto-pull list | `true` |
| `ollama.models.derivedModels` | `OLLAMA_DERIVED_MODELS_*` + mounted JSON | GitOps list of `{ name, from, parameters? }`. Only rows whose **`from`** appears in **`models.pull`** (exact string) are written to `derived-models.json`; Helm appends **`-<Release.Namespace>`** to each logical `name` there (e.g. `gpt-oss:20b-validator` → `gpt-oss:20b-validator-ollama6`). **Only** the Ollama image entrypoint applies them ([spec](./ENTRYPOINT_DERIVED_MODELS_SPEC.md)) | `[]` |
| *(rendered)* | `OLLAMA_SYNC_RETAIN_MODELS_JSON` | UTF-8 JSON array of unique model names: `pull ∪` effective derived names **(included rows only)** `∪` **`from`** for those rows | `[]` |

**Model pulls and derived models** are handled **only** by the Ollama image entrypoint (no Helm hook Jobs for catalog or derived models).

**Notes:**
- **`ollama.noPrune`**: When set to `true`, Ollama will not automatically prune orphaned model blob files on startup. This prevents automatic cleanup of unused blob layers. **Note**: This does NOT prevent model removal via your entrypoint cache sync driven by `ollama.models.pull` and `OLLAMA_SYNC_RETAIN_MODELS_JSON` (see [Model Management](#model-management)). The entrypoint should treat those sources as the allowlist for chart-driven cleanup.
- **`ollama.ginMode`**: Controls GIN framework log verbosity. Set to `"release"` for production to reduce log noise. Default `"debug"` shows detailed route registration and request logs.

### Ollama Cloud Support

This chart supports Ollama Cloud model usage when the pod can reach `ollama.com` over HTTPS.

- Keep persistence enabled so `/home/ollama/.ollama` remains stable across restarts.
- Use `ollama.cloud.apiKeySecret` (recommended) or `ollama.cloud.apiKey` to inject `OLLAMA_API_KEY` when you need direct cloud API authentication.
- Set `ollama.cloud.disable=true` to force local-only mode (`OLLAMA_NO_CLOUD=1`).
- You can still override either variable manually with `ollama.env` if you need full control.

Example:

```yaml
ollama:
  cloud:
    disable: false
    apiKeySecret:
      name: "ollama-cloud-api"
      key: "api-key"
```

### HuggingFace Authentication

Ollama supports two methods for HuggingFace authentication:

#### 1. HF_TOKEN / HUGGINGFACE_HUB_TOKEN (for gated/public models + rate limits)

For avoiding rate limits on public models or some API operations:

```yaml
ollama:
  hfToken:
    # Recommended: Use Kubernetes secret
    credentials:
      secretName: "hf-token-secret"
      key: "token"
    # Alternative: Direct token (not recommended for production)
    # token: "hf_xxxxxxxxxxxxx"
```

**Note**:
- Some Hugging Face models are **gated** (license/terms acceptance required) even if they’re “public”. Those often return **401** until you accept the model terms and provide a valid token.
- `HF_TOKEN` / `HUGGINGFACE_HUB_TOKEN` helps with gated access and rate limits but **does not work for private repos that require SSH auth**. Private models require SSH keys.

#### 2. SSH Keys (for private models)

For pulling private models from HuggingFace Hub, Ollama uses SSH keys (not HF_TOKEN):

```yaml
ollama:
  sshKey:
    enabled: true
    secretName: "hf-ssh-key-secret"  # Secret containing SSH private key
    key: "id_rsa"                     # Key name in secret (default: "id_rsa")
    mountPath: "/home/ollama/.ssh"    # SSH directory (default: "/home/ollama/.ssh")
    keyMode: "0600"                   # Key file permissions (default: "0600")
```

**Important Requirements**:
- **Persistence must be enabled** (`persistence.enabled=true`) - SSH directory must be on PVC because Ollama writes to `/home/ollama/.ssh/config`
- The `.ssh` directory is stored on the PVC at `/models/.ssh` and mounted to `/home/ollama/.ssh` in the container
- This ensures the SSH directory is writable and persistent across pod restarts

**Setup**:
1. Generate SSH key pair: `ssh-keygen -t ed25519 -C "ollama@kubernetes"`
2. Add public key to your HuggingFace account: Settings → SSH Keys
3. Create Kubernetes secret:
```bash
   kubectl create secret generic hf-ssh-key-secret --from-file=id_rsa=~/.ssh/id_ed25519
   ```

**Both can be used together**: `HF_TOKEN` for rate limits + SSH keys for private models.

#### 3. HuggingFace Download Timeout Configuration

The chart automatically sets optimized timeout values for HuggingFace model downloads to handle large models and slow connections:

- `HF_HUB_DOWNLOAD_TIMEOUT=300` (5 minutes) - Download timeout for large model files
- `HF_HUB_ETAG_TIMEOUT=60` (1 minute) - Metadata check timeout
- `HF_HUB_DOWNLOAD_RETRIES=10` - Retry count for transient network errors

These are set automatically but can be overridden via `ollama.env`:

```yaml
ollama:
  env:
    - name: HF_HUB_DOWNLOAD_TIMEOUT
      value: "600"  # 10 minutes for very large models
```

**Note**: These timeout values help prevent 504 Gateway Timeout errors when downloading large models from HuggingFace Hub.

#### Using SSH with Private HuggingFace Repositories

To pull private models from HuggingFace using SSH:

1. **Generate SSH Key** (if you don't have one):
```bash
   ssh-keygen -t ed25519 -C "ollama@kubernetes" -f ~/.ssh/id_ed25519
   ```

2. **Add Public Key to HuggingFace**:
   - Go to: https://huggingface.co/settings/keys
   - Click "New SSH Key"
   - Paste your public key: `cat ~/.ssh/id_ed25519.pub`

3. **Create Kubernetes Secret**:
   ```bash
   kubectl create secret generic hf-ssh-key-secret \
     --from-file=id_rsa=~/.ssh/id_ed25519 \
     --namespace=your-namespace
   ```

4. **Configure Chart** (requires `persistence.enabled=true`):
```yaml
   persistence:
     enabled: true  # REQUIRED for SSH keys (SSH directory must be on PVC)
   
   ollama:
     sshKey:
       enabled: true
       secretName: "hf-ssh-key-secret"
       key: "id_rsa"  # Match the key name in your secret
       mountPath: "/home/ollama/.ssh"  # Ollama's expected location
   ```

5. **Pull Private Models**:
   Once configured, Ollama can pull private models using the `hf.co/` format:
   ```bash
   # From within the pod or via API
   ollama pull hf.co/username/private-model-name
   ```

   The chart automatically sets up SSH keys with proper permissions (0600) and mounts them to `/home/ollama/.ssh` (on PVC) for Ollama to use. **Note**: Persistence must be enabled for SSH keys to work.

### Model Management

The chart supports automatic model pulling and cache synchronization via the **entrypoint script**:

- The chart sets `OLLAMA_AUTO_PULL_MODELS` environment variable (comma-separated list of model names) when `ollama.models.autoPull.enabled` is true and `pull` is non-empty.
- The chart always sets **`OLLAMA_SYNC_RETAIN_MODELS_JSON`**: a **JSON array of strings** (unique model names). Compute: **`pull` ∪** effective derived names **(only for rows whose `from` is in `pull`; each with suffix `-<Release.Namespace>`; see [Derived models](#derived-models-ollamamodelsderivedmodels))** **`∪`** **`from`** for those rows, sorted for stable renders. **Parsing contract:** valid JSON array; each element is one model name (typical Ollama names; avoid unescaped control characters). Your custom entrypoint should **parse this JSON** and **merge** those names into the set of models that must **not** be deleted during chart-driven cache sync (in addition to, or instead of only using `OLLAMA_AUTO_PULL_MODELS`, depending on your image).
- When `derivedModels` is configured, the chart sets **`OLLAMA_DERIVED_MODELS_SYNC=entrypoint`** and mounts **`derived-models.json`** (see [ENTRYPOINT_DERIVED_MODELS_SPEC.md](./ENTRYPOINT_DERIVED_MODELS_SPEC.md)).
- Your entrypoint script should read these variables and:
  1. Pull models listed in `OLLAMA_AUTO_PULL_MODELS` (if not already in cache) using `ollama pull <model>`
  2. Remove models from cache only when they are **outside** the effective allowlist derived from **`OLLAMA_SYNC_RETAIN_MODELS_JSON`** (and your documented rules)
- **How cache sync works**: The entrypoint compares installed models with the allowlist; names **not** in the retain set are candidates for removal (same GitOps pattern as `pull:` alone, extended for derived models and bases)

**How Cache Synchronization Works:**

The model cache is automatically synchronized with the `pull:` list on every container startup:

1. **Pull Phase**: The entrypoint script pulls each model in the `pull:` list if it's not already in cache
2. **Sync Phase**: The entrypoint script compares all installed models (from `ollama list`) with the `pull:` list
3. **Cleanup Phase**: Any models found in cache that are NOT in the `pull:` list are automatically removed using `ollama rm <model>`

**Example workflow:**
- Initial state: Cache has `llama2`, `mistral`, `gemma-7b-it`
- `pull:` list: `[llama2, gemma-7b-it]`
- After startup: `mistral` is removed (not in list), `llama2` and `gemma-7b-it` remain
- If `gemma-7b-it` is removed from `pull:` list and container restarts: `gemma-7b-it` is removed from cache

This ensures your model cache always matches your GitOps configuration, preventing disk space waste from unused models.

#### Derived models (`ollama.models.derivedModels`)

Use **derived models** when you want a named model built from a **base** (`FROM <base>` in a Modelfile) with **Modelfile `PARAMETER` lines** (not the same as listing a finished GGUF only in `pull:`). **Rendered release values are the source of truth.** There is **no Helm hook** for derived models: the chart always sets **`OLLAMA_DERIVED_MODELS_SYNC=entrypoint`**, mounts **`derived-models.json`** and sets **`OLLAMA_DERIVED_MODELS_FILE`** only when at least one derived row is **passed through** to the manifest (see **Pull catalog** below). The **Ollama image entrypoint** must read the manifest and converge models over **localhost** (see **[ENTRYPOINT_DERIVED_MODELS_SPEC.md](./ENTRYPOINT_DERIVED_MODELS_SPEC.md)**).

- **Pull catalog:** Helm includes a derived row in `derived-models.json` only if **`from`** matches an entry in **`ollama.models.pull`** exactly (same string). Add every base you derive from to `pull` so it is both pulled/synced and eligible for derived creation.
- **Namespace suffix:** Set the logical name in values (`name`). Helm renders the manifest and retain JSON using **`-<Release.Namespace>`** appended to that name: for `model:tag` values, the suffix is appended after the tag (e.g. `gpt-oss:20b-validator` in namespace `ollama6` → `gpt-oss:20b-validator-ollama6`); names without `:` get `-<namespace>` appended to the whole string. Use the **rendered** name when calling Ollama in that namespace.
- **Base acquisition:** For rows that appear in the manifest, the entrypoint must ensure each `from` exists (pull idempotently). `OLLAMA_SYNC_RETAIN_MODELS_JSON` includes `pull` ∪ effective derived names ∪ **`from`** for those included rows.
- **Strict failures:** The entrypoint should fail the container if convergence fails (so Kubernetes restarts / surfaces the error).
- **Observability:** Log each derived row and errors in the main container logs.

**Parameter keys** (optional `parameters` object; map to Modelfile `PARAMETER`):

| Key | Type / notes |
|-----|----------------|
| `num_ctx` | integer (≥ 1) |
| `repeat_last_n` | integer |
| `repeat_penalty` | number (0–10 in schema) |
| `temperature` | number (0–2) |
| `seed` | integer |
| `stop` | string **or** non-empty string array (one `PARAMETER stop` per entry) |
| `num_predict` | integer (≥ −1) |
| `top_k` | integer (≥ 0) |
| `top_p` | number (0–1) |
| `min_p` | number (0–1) |

**Example:**

```yaml
ollama:
  models:
    derivedModels:
      - name: my-orchestrator:120b
        from: nemotron-3-super:120b
        parameters:
          num_ctx: 1000000
          temperature: 0.1
          top_p: 1
          stop: ["</s>", "<|end|>"]
```

**Retention (derived names):** For rows Helm includes in the manifest **`from` ∈ `pull`**, the **effective** model name **(values `name` plus `-<Release.Namespace>`)** must not be removed by chart-driven cache sync while that row remains in values, even if the base is missing or entrypoint convergence failed. Rows with **`from` not in `pull`** are omitted from the manifest and retain JSON. **This does not** protect against manual `ollama rm`, disk loss, or other out-of-band actions. A derived model becomes eligible for removal from the allowlist **only after** it is removed from `derivedModels` in values or its **`from`** is removed from **`pull`** (then it drops out of `OLLAMA_SYNC_RETAIN_MODELS_JSON` on the next render). **`from`** for included rows stays in the retain union so bases are less likely to be pruned accidentally.

**Supported model formats:**

1. **Ollama catalog models**: Use simple names like `"llama2"`, `"mistral"`, `"llama3.1"`
```yaml
   ollama:
     models:
       pull:
         - llama2
         - mistral
   ```

2. **HuggingFace models**: Use URLs like `"hf.co/google/gemma-7b-it"` or `"google/gemma-7b-it"`
   - Ollama supports both formats (with or without the `"hf.co/"` prefix)
   - For private HuggingFace models, configure SSH keys (see [SSH Key Support](#ssh-key-support))
```yaml
   ollama:
     models:
       pull:
         - hf.co/google/gemma-7b-it  # Full URL format
         - google/gemma-7b-it         # Short format (also supported)
   ```

**Configuration example:**

```yaml
ollama:
  models:
    # List of models to pull at container startup
    # Models are downloaded to disk (PVC if persistence enabled, emptyDir otherwise)
    pull:
      - llama2                    # Ollama catalog model
      - mistral                   # Ollama catalog model
      - hf.co/google/gemma-7b-it  # HuggingFace model
    
    # List of models to create from templates or ConfigMaps
    create:
      - name: llama3.1-ctx32768
        template: |
          FROM llama3.1
          PARAMETER num_ctx 32768
```

**Automatic Cache Synchronization:**

The entrypoint script synchronizes the model cache with the `pull:` list on every container startup. When using derived models, merge **`OLLAMA_SYNC_RETAIN_MODELS_JSON`** into the allowlist as described in [Model Management](#model-management). This is a **three-phase process**:

1. **List Phase**: The entrypoint script runs `ollama list` to get all currently installed models
2. **Pull Phase**: For each model in the `pull:` list, the entrypoint script runs `ollama pull <model>` if the model is not already in cache
3. **Cleanup Phase**: The entrypoint script compares installed models with the `pull:` list and removes any models NOT in the list using `ollama rm <model>`

**How it works in detail:**
- **Models in the `pull:` list**: 
  - If missing from cache → automatically pulled using `ollama pull <model>`
  - If already in cache → left untouched
- **Models NOT in the `pull:` list**: 
  - Automatically removed from cache using `ollama rm <model>` on container startup
  - This happens every time the container starts, ensuring cache matches configuration
- **Removing a model from the `pull:` list**: 
  - The model will be deleted from cache on the next container restart
  - This is useful for GitOps workflows where you want to remove unused models automatically

**Example workflow:**
```
Initial state:
- Cache contains: llama2, mistral, gemma-7b-it
- pull: list: [llama2, gemma-7b-it]

After container startup:
- mistral is removed (not in pull list)
- llama2 remains (in pull list, already cached)
- gemma-7b-it remains (in pull list, already cached)

If you remove gemma-7b-it from pull: list and restart:
- gemma-7b-it is removed from cache
- Only llama2 remains
```

This ensures your model cache always matches your GitOps configuration, preventing disk space waste from unused models. The cache synchronization happens automatically on every container startup, so your configuration is always the source of truth.

#### Mitigating gated Hugging Face 401s crashing the pod

If your image entrypoint auto-pull fails the container when a gated HF model returns 401 (e.g. `hf.co/google/gemma-7b-it`), you have two options:

1) **Provide HF auth + accept license** (recommended)
- Accept the model’s terms on the Hugging Face model page.
- Set `ollama.hfToken.credentials.secretName` (or `ollama.hfToken.token`) so the pod has `HF_TOKEN`/`HUGGINGFACE_HUB_TOKEN`.

2) **Decouple pulling from pod startup** (if the entrypoint would otherwise exit on pull failure)
- Set `ollama.models.autoPull.enabled: false` so the chart does not pass `OLLAMA_AUTO_PULL_MODELS`, then pull models out-of-band (for example `kubectl exec` into the pod and `ollama pull …`), or adjust your entrypoint to log and continue on pull errors.

**Important notes:**
- Models specified in `pull:` are downloaded to disk using `ollama pull <model>` by the entrypoint script
- The entrypoint script waits for the Ollama server to be ready (up to 5 minutes) before pulling models
- The more models you add, the longer the container will take to start if models are not already present
- Large models can take several minutes to download
- **Cache cleanup happens automatically** - removing a model from `pull:` will cause it to be deleted on next restart

**Troubleshooting:**
- Check pod logs for model pull/cleanup messages:
  ```bash
  kubectl logs <pod-name> -n <namespace> | grep -i "pulling\|removing\|model"
  ```
- Look for "STEP 4: Pulling models via CLI..." and "STEP 5: Cleaning up models..." in the logs
- Verify `OLLAMA_AUTO_PULL_MODELS` is set correctly:
  ```bash
  kubectl exec <pod-name> -n <namespace> -- env | grep OLLAMA_AUTO_PULL_MODELS
  ```

### Additional Command Line Arguments

For custom CLI arguments (Ollama uses minimal CLI flags, most config is via env vars):

```yaml
ollama:
  additionalArgs:
    - "--custom-flag"
    - "value"
```

**Note**: Ollama uses `ollama serve` with minimal CLI arguments. Most configuration is done via environment variables.

### Additional Environment Variables

For environment variables not explicitly supported above, use `ollama.env`:

```yaml
ollama:
  env:
    - name: CUSTOM_VAR
      value: "custom-value"
```

See `ollama serve --help` for all available environment variables.

## Examples

### Basic Installation

```bash
helm install ollama arktecquant/ollama
```

### Custom Model Configuration

```bash
helm install ollama arktecquant/ollama\
  --set ollama.models="/models" \
  --set ollama.keepAlive="10m"
```

### GPU Configuration

```bash
helm install ollama arktecquant/ollama\
  --set resources.limits.nvidia.com/gpu=2 \
  --set ollama.schedSpread=true \
  --set ollama.gpu.enabled=true
```

**Note**: By default, `ollama.gpu.enabled=false` uses GPU auto-detection. Set to `true` to force GPU mode.

**CUDA Kernel Compatibility (CUDA 12.8 image)**: This chart ships a CUDA-enabled image (`v0.18.2-cuda-12.8`) with kernels compiled only for the following GPU architectures:
- **61** — Pascal (GTX 1080, GTX 1070, Tesla P100)
- **75** — Turing (RTX 2080, RTX 2070, GTX 1660, Tesla T4)
- **80 / 86** — Ampere (RTX 3090, RTX 3080, RTX 3070, A100, A40)
- **89** — Ada (RTX 4090, RTX 4080, RTX 4070, L40, L40S)
- **90** — Hopper (H100)
- **100 / 120** — Blackwell families (B100, B200)

Older GPU architectures (e.g., Kepler, Maxwell) are not supported and will not work with this image.

**⚠️ NVIDIA Deprecation Notice (sm < 75)**: NVIDIA has announced that offline compilation support for architectures prior to compute capability 75 (Turing) will be removed in a future CUDA release. If you rely on Pascal (sm_61), pin a chart/image build that explicitly includes it.

NVIDIA warning message:
```
nvcc warning : Support for offline compilation for architectures prior to '<compute/sm/lto>_75' will be removed in a future release.
```

### HuggingFace Authentication

#### Using HF_TOKEN (for rate limits):

```bash
# Create secret with HF token
kubectl create secret generic hf-token-secret --from-literal=token=hf_xxxxxxxxxxxxx

helm install ollama arktecquant/ollama\
  --set ollama.hfToken.credentials.secretName=hf-token-secret \
  --set ollama.hfToken.credentials.key=token
```

#### Using SSH Keys (for private models):

```bash
# 1. Generate SSH key (if not exists)
ssh-keygen -t ed25519 -C "ollama@kubernetes" -f ~/.ssh/id_ed25519

# 2. Add public key to HuggingFace
#    Visit: https://huggingface.co/settings/keys
#    Click "New SSH Key" and paste: cat ~/.ssh/id_ed25519.pub

# 3. Create secret with SSH private key
kubectl create secret generic hf-ssh-key-secret \
  --from-file=id_rsa=~/.ssh/id_ed25519 \
  --namespace=your-namespace

# 4. Install with SSH key support (requires persistence.enabled=true)
helm install ollama arktecquant/ollama\
  --set persistence.enabled=true \
  --set persistence.storageClass=your-storage-class \
  --set ollama.sshKey.enabled=true \
  --set ollama.sshKey.secretName=hf-ssh-key-secret \
  --set ollama.sshKey.key=id_rsa

# 5. Pull private models using hf.co format
#    From within pod: ollama pull hf.co/username/private-model-name
#    Or via API: POST /api/pull with {"name": "hf.co/username/model"}
```

#### Using Both (HF_TOKEN + SSH keys):

```bash
# Both can be used together for maximum compatibility
helm install ollama arktecquant/ollama\
  --set ollama.hfToken.credentials.secretName=hf-token-secret \
  --set ollama.sshKey.enabled=true \
  --set ollama.sshKey.secretName=hf-ssh-key-secret
```

### Logging and Diagnostics

```bash
helm install ollama arktecquant/ollama\
  --set ollama.logLevel=debug \
  --set ollama.startupDiagnostics.enabled=true
```

### With Ingress

```bash
helm install ollama arktecquant/ollama\
  --set ingress.enabled=true \
  --set ingress.hosts[0].host=ollama.example.com
```

### Secure Deployment with PVC (Recommended)

This example shows a secure deployment with a custom storage class:

```bash
helm install ollama arktecquant/ollama\
  --set persistence.enabled=true \
  --set persistence.storageClass=fast-ssd \
  --set persistence.size=100Gi \
  --set securityContext.readOnlyRootFilesystem=true
```

The chart automatically:
- Creates an init container to set up `/models/tmp` on the PVC
- Configures environment variables (`TMPDIR`, `OLLAMA_MODELS`) to use the PVC
- Mounts the PVC at `/models` for both models and temporary files

## API Usage

Once deployed, Ollama provides a REST API:

```bash
# List models
curl http://your-service-url/api/tags

# Generate text
curl -X POST "http://your-service-url/api/generate" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "llama2",
    "prompt": "Why is the sky blue?",
    "stream": false
  }'
```

## GitOps Integration

This chart is optimized for GitOps workflows with comprehensive schema validation and structured values that enable full control via declarative configuration management tools like ArgoCD, Flux, or Jenkins X.

### GitOps Configuration Examples

#### ArgoCD Application

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: ollama
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://charts.arktecquant.com
    chart: ollama
    targetRevision: 1.0.1
    helm:
      valueFiles:
        - $values/production/ollama-values.yaml
  destination:
    server: https://kubernetes.default.svc
    namespace: ollama
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

#### Flux Kustomization

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: HelmRelease
metadata:
  name: ollama
  namespace: ollama
spec:
  interval: 5m
  chart:
    spec:
      chart: ollama
      sourceRef:
        kind: HelmRepository
        name: arktec-quant-charts
      version: "1.0.1"
  values:
    persistence:
      enabled: true
      storageClass: "local-path"
      size: 100Gi
    networkPolicy:
      enabled: true
    securityContext:
      readOnlyRootFilesystem: true
    ollama:
      keepAlive: "10m"
      maxLoadedModels: 3
```

## Troubleshooting

### PVC and Storage Issues

If the pod fails to start with read-only filesystem errors:

1. Verify the PVC is created:
   ```bash
   kubectl get pvc
   ```

2. Check the init container logs:
   ```bash
   kubectl logs <pod-name> -c fix-permissions
   ```

3. Ensure the storage class exists:
   ```bash
   kubectl get storageclass
   ```

### GPU Issues

If you encounter GPU-related issues:

1. Verify GPU nodes are available:
   ```bash
   kubectl get nodes -l accelerator=nvidia-tesla-k80
   ```

2. Check if the NVIDIA device plugin is running:
   ```bash
   kubectl get pods -n kube-system | grep nvidia
   ```

3. Verify GPU resources in the pod:
   ```bash
   kubectl describe pod <pod-name>
   ```

## Configuration

All configuration options are defined in:
- `values.yaml` - Default values and documentation
- `values.schema.json` - GitOps validation schema

This configuration approach ensures:
- Strong typing
- Fail-fast validation
- ArgoCD-friendly automation

## License

**ollama Helm Chart:**
This Helm chart is licensed under the Apache License 2.0 by Arktec Quant. See the [LICENSE](LICENSE) file for details.

**Ollama Project:**
The Ollama inference engine, its codebase, and Docker images are licensed under Apache License 2.0 by the Ollama project contributors. This license applies to Ollama itself, not to this Helm chart.

**Attribution Requirements:**
If you redistribute this Helm chart, you must include the [NOTICE](NOTICE) file and preserve all attribution notices. See the NOTICE file for detailed requirements.

