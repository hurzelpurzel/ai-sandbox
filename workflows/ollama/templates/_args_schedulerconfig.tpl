{{/*
SchedulerConfig arguments for ollama serve
Scheduler configuration
*/}}
{{- define "ollama.args.schedulerconfig" }}
{{- if .Values.ollama.schedulerConfig }}
{{- if ne .Values.ollama.schedulerConfig.asyncScheduling nil }}
            {{- if .Values.ollama.schedulerConfig.asyncScheduling }}
            - "--async-scheduling"
            {{- else }}
            - "--no-async-scheduling"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.schedulerConfig.disableChunkedMmInput nil }}
            {{- if .Values.ollama.schedulerConfig.disableChunkedMmInput }}
            - "--disable-chunked-mm-input"
            {{- else }}
            - "--no-disable-chunked-mm-input"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.schedulerConfig.disableHybridKvCacheManager nil }}
            {{- if .Values.ollama.schedulerConfig.disableHybridKvCacheManager }}
            - "--disable-hybrid-kv-cache-manager"
            {{- else }}
            - "--no-disable-hybrid-kv-cache-manager"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.schedulerConfig.enableChunkedPrefill nil }}
            {{- if .Values.ollama.schedulerConfig.enableChunkedPrefill }}
            - "--enable-chunked-prefill"
            {{- else }}
            - "--no-enable-chunked-prefill"
            {{- end }}
{{- end }}
{{- if .Values.ollama.schedulerConfig.longPrefillTokenThreshold }}
            - "--long-prefill-token-threshold"
            - {{ .Values.ollama.schedulerConfig.longPrefillTokenThreshold | int | quote }}
{{- end }}
{{- if .Values.ollama.schedulerConfig.schedulerCls }}
            - "--scheduler-cls"
            - {{ .Values.ollama.schedulerConfig.schedulerCls | quote }}
{{- end }}
{{- if .Values.ollama.schedulerConfig.streamInterval }}
            - "--stream-interval"
            - {{ .Values.ollama.schedulerConfig.streamInterval | int | quote }}
{{- end }}
{{- end }}
{{- end }}

