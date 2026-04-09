{{/*
Cache directory environment variables
Cache directories are on model-storage (/models/.cache) - persistent when PVC enabled, ephemeral when emptyDir
*/}}
{{- define "ollama.env.cache" }}
{{- $torchCacheSet := false }}
{{- $ollamaCacheSet := false }}
{{- range .Values.ollama.env }}
{{- if eq .name "TORCHINDUCTOR_CACHE_DIR" }}
{{- $torchCacheSet = true }}
{{- end }}
{{- if eq .name "VLLM_CACHE_DIR" }}
{{- $ollamaCacheSet = true }}
{{- end }}
{{- end }}
{{- if not $torchCacheSet }}
            # Set TORCHINDUCTOR_CACHE_DIR to model-storage cache directory
            # Persistent when persistence.enabled=true (PVC), ephemeral when false (emptyDir)
            # This avoids getuser() call when running as non-root UID
            # Only set automatically if user hasn't explicitly set it in ollama.env
            - name: TORCHINDUCTOR_CACHE_DIR
              value: "/models/.cache/torchinductor"
{{- end }}
{{- if not $ollamaCacheSet }}
            # Set VLLM_CACHE_DIR to model-storage cache directory
            # Persistent when persistence.enabled=true (PVC), ephemeral when false (emptyDir)
            # Only set automatically if user hasn't explicitly set it in ollama.env
            - name: VLLM_CACHE_DIR
              value: "/models/.cache/ollama"
{{- end }}
{{- end }}


