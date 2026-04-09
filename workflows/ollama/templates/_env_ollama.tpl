{{/*
Ollama-specific environment variables
All configuration for ollama serve is done via environment variables
See: ollama serve --help for all available options
*/}}
{{- define "ollama.env.ollama" }}
{{- if .Values.ollama }}
{{- if .Values.ollama.debug }}
            - name: OLLAMA_DEBUG
              value: {{ .Values.ollama.debug | quote }}
{{- end }}
{{- /* ne(toString) so contextLength "0" emits OLLAMA_CONTEXT_LENGTH; bare `if .Values.ollama.contextLength` is false for numeric 0. */}}
{{- if ne (toString .Values.ollama.contextLength) "" }}
            - name: OLLAMA_CONTEXT_LENGTH
              value: {{ .Values.ollama.contextLength | quote }}
{{- end }}
{{- if .Values.ollama.host }}
            - name: OLLAMA_HOST
              value: {{ .Values.ollama.host | quote }}
{{- end }}
{{- if .Values.ollama.keepAlive }}
            - name: OLLAMA_KEEP_ALIVE
              value: {{ .Values.ollama.keepAlive | quote }}
{{- end }}
{{- if .Values.ollama.maxLoadedModels }}
            - name: OLLAMA_MAX_LOADED_MODELS
              value: {{ .Values.ollama.maxLoadedModels | int | quote }}
{{- end }}
{{- if .Values.ollama.maxQueue }}
            - name: OLLAMA_MAX_QUEUE
              value: {{ .Values.ollama.maxQueue | int | quote }}
{{- end }}
{{- if .Values.ollama.modelsPath }}
            - name: OLLAMA_MODELS
              value: {{ .Values.ollama.modelsPath | quote }}
{{- end }}
{{- if .Values.ollama.numParallel }}
            - name: OLLAMA_NUM_PARALLEL
              value: {{ .Values.ollama.numParallel | int | quote }}
{{- end }}
{{- if ne .Values.ollama.noPrune nil }}
            {{- if .Values.ollama.noPrune }}
            - name: OLLAMA_NOPRUNE
              value: "1"
            {{- end }}
{{- end }}
{{- if .Values.ollama.origins }}
            - name: OLLAMA_ORIGINS
              value: {{ .Values.ollama.origins | quote }}
{{- end }}
{{- if ne .Values.ollama.schedSpread nil }}
            {{- if .Values.ollama.schedSpread }}
            - name: OLLAMA_SCHED_SPREAD
              value: "1"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.flashAttention nil }}
            {{- if .Values.ollama.flashAttention }}
            - name: OLLAMA_FLASH_ATTENTION
              value: "1"
            {{- end }}
{{- end }}
{{- if .Values.ollama.kvCacheType }}
            - name: OLLAMA_KV_CACHE_TYPE
              value: {{ .Values.ollama.kvCacheType | quote }}
{{- end }}
{{- if .Values.ollama.llmLibrary }}
            - name: OLLAMA_LLM_LIBRARY
              value: {{ .Values.ollama.llmLibrary | quote }}
{{- end }}
{{- if .Values.ollama.gpuOverhead }}
            - name: OLLAMA_GPU_OVERHEAD
              value: {{ .Values.ollama.gpuOverhead | int | quote }}
{{- end }}
{{- if .Values.ollama.loadTimeout }}
            - name: OLLAMA_LOAD_TIMEOUT
              value: {{ .Values.ollama.loadTimeout | quote }}
{{- end }}
{{- if .Values.ollama.insecure }}
            - name: OLLAMA_INSECURE
              value: "1"
{{- end }}
{{- if .Values.ollama.gpu.enabled }}
            - name: OLLAMA_GPU
              value: "1"
{{- end }}
{{- if .Values.ollama.logLevel }}
            - name: OLLAMA_LOG_LEVEL
              value: {{ .Values.ollama.logLevel | quote }}
{{- end }}
{{- if .Values.ollama.startupDiagnostics.enabled }}
            - name: OLLAMA_STARTUP_DIAGNOSTICS
              value: "1"
            {{- end }}
{{- if .Values.ollama.showServerLogs }}
            - name: OLLAMA_SHOW_SERVER_LOGS
              value: "1"
            {{- else }}
            - name: OLLAMA_SHOW_SERVER_LOGS
              value: "0"
            {{- end }}
{{- $autoPullEnabled := true }}
{{- if and .Values.ollama.models .Values.ollama.models.autoPull (ne .Values.ollama.models.autoPull.enabled nil) }}
{{- $autoPullEnabled = .Values.ollama.models.autoPull.enabled }}
{{- end }}
{{- if and .Values.ollama.models.pull (gt (len .Values.ollama.models.pull) 0) $autoPullEnabled }}
            # Environment variable for entrypoint script to auto-pull models
            # Format: comma-separated list of model names
            # The entrypoint script will:
            #   1. Pull models listed here (if not already in cache)
            #   2. Automatically remove models from cache that are NOT in this list
            - name: OLLAMA_AUTO_PULL_MODELS
              value: {{ join "," .Values.ollama.models.pull | quote }}
{{- end }}
{{- end }}
{{- end }}

