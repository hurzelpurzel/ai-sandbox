{{/*
Quantization arguments
*/}}
{{- define "ollama.args.quantization" }}
{{- $quantization := .quantization }}
{{- $context := .context }}
{{- if eq $quantization.type "int4" }}
- "--quantization"
- "int4"
# Note: kvCacheDtype is a global setting, not per-model. Set it in ollama.kvCacheDtype.
{{- else if eq $quantization.type "fp8" }}
- "--quantization"
- "fp8"
# Note: kvCacheDtype is a global setting, not per-model. Set it in ollama.kvCacheDtype.
{{- else if eq $quantization.type "fp8_base" }}
- "--quantization"
- "fp8"
# Note: kvCacheDtype is a global setting, not per-model. Set it in ollama.kvCacheDtype.
{{- else if eq $quantization.type "gptq" }}
- "--quantization"
- "gptq"
- "--trust-remote-code"
{{- else if eq $quantization.type "awq" }}
- "--quantization"
- "awq"
- "--trust-remote-code"
{{- else if eq $quantization.type "gguf" }}
  # gguf quantization does not emit any CLI flags for ollama serve;
  # users should configure GGUF models via model path / load-format instead.
{{- else if eq $quantization.type "kv_cache" }}
# Note: kvCacheDtype is a global setting, not per-model. Set it in ollama.kvCacheDtype.
# The kv_cache quantization type itself doesn't require any CLI flags.
{{- end }}
{{- end }}

