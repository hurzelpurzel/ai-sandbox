{{/*
CacheConfig arguments for ollama serve
Configuration for the KV cache
*/}}
{{- define "ollama.args.cacheconfig" }}
{{- if .Values.ollama.cacheConfig }}
{{- if .Values.ollama.cacheConfig.blockSize }}
            - "--block-size"
            - {{ .Values.ollama.cacheConfig.blockSize | int | quote }}
{{- end }}
{{- if ne .Values.ollama.cacheConfig.calculateKvScales nil }}
            {{- if .Values.ollama.cacheConfig.calculateKvScales }}
            - "--calculate-kv-scales"
            {{- else }}
            - "--no-calculate-kv-scales"
            {{- end }}
{{- end }}
{{- if .Values.ollama.cacheConfig.kvOffloadingBackend }}
            - "--kv-offloading-backend"
            - {{ .Values.ollama.cacheConfig.kvOffloadingBackend | quote }}
{{- end }}
{{- if .Values.ollama.cacheConfig.kvOffloadingSize }}
            - "--kv-offloading-size"
            - {{ .Values.ollama.cacheConfig.kvOffloadingSize | int | quote }}
{{- end }}
{{- if ne .Values.ollama.cacheConfig.kvSharingFastPrefill nil }}
            {{- if .Values.ollama.cacheConfig.kvSharingFastPrefill }}
            - "--kv-sharing-fast-prefill"
            {{- else }}
            - "--no-kv-sharing-fast-prefill"
            {{- end }}
{{- end }}
{{- if .Values.ollama.cacheConfig.mambaBlockSize }}
            - "--mamba-block-size"
            - {{ .Values.ollama.cacheConfig.mambaBlockSize | int | quote }}
{{- end }}
{{- if and .Values.ollama.cacheConfig.mambaCacheDtype (ne .Values.ollama.cacheConfig.mambaCacheDtype "") }}
            - "--mamba-cache-dtype"
            - {{ .Values.ollama.cacheConfig.mambaCacheDtype | quote }}
{{- end }}
{{- if and .Values.ollama.cacheConfig.mambaSsmCacheDtype (ne .Values.ollama.cacheConfig.mambaSsmCacheDtype "") }}
            - "--mamba-ssm-cache-dtype"
            - {{ .Values.ollama.cacheConfig.mambaSsmCacheDtype | quote }}
{{- end }}
{{- if .Values.ollama.cacheConfig.numGpuBlocksOverride }}
            - "--num-gpu-blocks-override"
            - {{ .Values.ollama.cacheConfig.numGpuBlocksOverride | int | quote }}
{{- end }}
{{- if and .Values.ollama.cacheConfig.prefixCachingHashAlgo (ne .Values.ollama.cacheConfig.prefixCachingHashAlgo "") }}
            - "--prefix-caching-hash-algo"
            - {{ .Values.ollama.cacheConfig.prefixCachingHashAlgo | quote }}
{{- end }}
{{- end }}
{{- end }}

