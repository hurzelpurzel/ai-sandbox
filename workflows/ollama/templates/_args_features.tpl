{{/*
Feature-specific arguments for ollama serve
All arguments are compatible with ollama serve command
For additional arguments not explicitly supported, use ollama.additionalArgs
*/}}
{{- define "ollama.args.features" }}
            {{- include "ollama.args.scheduler" . }}
            {{- include "ollama.args.parallelism" . }}
            {{- if and (not .Values.ollama.schedulerConfig) (ne .Values.ollama.asyncScheduling nil) }}
            {{- if .Values.ollama.asyncScheduling }}
            - "--async-scheduling"
            {{- else }}
            - "--no-async-scheduling"
            {{- end }}
            {{- end }}
            {{- if .Values.ollama.cpuOffload }}
            {{- if .Values.ollama.cpuOffload.enabled }}
            {{- if .Values.ollama.cpuOffload.gb }}
            - "--cpu-offload-gb"
            - {{ .Values.ollama.cpuOffload.gb | quote }}
            {{- else }}
            # Note: --cpu-offload-gb requires a value (GB). If enabled but no value specified, no flag is passed.
            {{- end }}
            {{- end }}
            {{- end }}
            {{- if .Values.ollama.kvCacheMemoryBytes }}
            - "--kv-cache-memory-bytes"
            {{- if kindIs "string" .Values.ollama.kvCacheMemoryBytes }}
            - {{ .Values.ollama.kvCacheMemoryBytes | quote }}
            {{- else }}
            - {{ .Values.ollama.kvCacheMemoryBytes | int | quote }}
            {{- end }}
            {{- end }}
            {{- if .Values.ollama.swapSpace }}
            - "--swap-space"
            - {{ .Values.ollama.swapSpace | int | quote }}
            {{- end }}
            {{- include "ollama.args.lora" . }}
            {{- if .Values.ollama.kvCacheDtype }}
            - "--kv-cache-dtype"
            - {{ .Values.ollama.kvCacheDtype | quote }}
            {{- end }}
            {{- if .Values.ollama.maxNumPartialPrefills }}
            - "--max-num-partial-prefills"
            - {{ .Values.ollama.maxNumPartialPrefills | int | quote }}
            {{- end }}
            {{- if .Values.ollama.maxLongPartialPrefills }}
            - "--max-long-partial-prefills"
            - {{ .Values.ollama.maxLongPartialPrefills | int | quote }}
            {{- end }}
            {{- if ne .Values.ollama.enablePrefixCaching nil }}
            {{- if .Values.ollama.enablePrefixCaching }}
            - "--enable-prefix-caching"
            {{- else }}
            - "--no-enable-prefix-caching"
            {{- end }}
            {{- end }}
            {{- if .Values.ollama.apiKeys }}
            - "--api-key"
            {{- range .Values.ollama.apiKeys }}
            - {{ . | quote }}
            {{- end }}
            {{- end }}
            {{- if .Values.ollama.server }}
            {{- if ne .Values.ollama.server.enableRequestIdHeaders nil }}
            {{- if .Values.ollama.server.enableRequestIdHeaders }}
            - "--enable-request-id-headers"
            {{- else }}
            - "--no-enable-request-id-headers"
            {{- end }}
            {{- end }}
            {{- if and (not (and .Values.ollama.options (ne .Values.ollama.options.enableLogRequests nil))) (ne .Values.ollama.server.enableLogRequests nil) }}
            {{- if .Values.ollama.server.enableLogRequests }}
            - "--enable-log-requests"
            {{- else }}
            - "--no-enable-log-requests"
            {{- end }}
            {{- end }}
            {{- if ne .Values.ollama.server.logErrorStack nil }}
            {{- if .Values.ollama.server.logErrorStack }}
            - "--log-error-stack"
            {{- else }}
            - "--no-log-error-stack"
            {{- end }}
            {{- end }}
            {{- if ne .Values.ollama.server.enableServerLoadTracking nil }}
            {{- if .Values.ollama.server.enableServerLoadTracking }}
            - "--enable-server-load-tracking"
            {{- else }}
            - "--no-enable-server-load-tracking"
            {{- end }}
            {{- end }}
            {{- if ne .Values.ollama.server.enableTokenizerInfoEndpoint nil }}
            {{- if .Values.ollama.server.enableTokenizerInfoEndpoint }}
            - "--enable-tokenizer-info-endpoint"
            {{- else }}
            - "--no-enable-tokenizer-info-endpoint"
            {{- end }}
            {{- end }}
            {{- end }}
            {{- if not .Values.ollama.multiModel }}
            {{- if .Values.ollama.quantization }}
            {{- if .Values.ollama.quantization.enabled }}
            {{- include "ollama.args.quantization" (dict "quantization" .Values.ollama.quantization "context" .) | nindent 12 }}
            {{- end }}
            {{- end }}
            {{- end }}
            {{- range .Values.ollama.additionalArgs }}
            - {{ . | quote }}
            {{- end }}
{{- end }}

