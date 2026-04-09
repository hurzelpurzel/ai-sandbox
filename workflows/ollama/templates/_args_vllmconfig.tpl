{{/*
VllmConfig arguments for ollama serve
Top-level OLLAMA configuration
*/}}
{{- define "ollama.args.ollamaconfig" }}
{{- if .Values.ollama.ollamaConfig }}
{{- if .Values.ollama.ollamaConfig.additionalConfig }}
            - "--additional-config"
            - {{ .Values.ollama.ollamaConfig.additionalConfig | quote }}
{{- end }}
{{- if .Values.ollama.ollamaConfig.ecTransferConfig }}
            - "--ec-transfer-config"
            - {{ .Values.ollama.ollamaConfig.ecTransferConfig | quote }}
{{- end }}
{{- if .Values.ollama.ollamaConfig.kvEventsConfig }}
            - "--kv-events-config"
            - {{ .Values.ollama.ollamaConfig.kvEventsConfig | quote }}
{{- end }}
{{- if .Values.ollama.ollamaConfig.kvTransferConfig }}
            - "--kv-transfer-config"
            - {{ .Values.ollama.ollamaConfig.kvTransferConfig | quote }}
{{- end }}
{{- if .Values.ollama.ollamaConfig.speculativeConfig }}
            - "--speculative-config"
            - {{ .Values.ollama.ollamaConfig.speculativeConfig | quote }}
{{- end }}
{{- if .Values.ollama.ollamaConfig.structuredOutputsConfig }}
            - "--structured-outputs-config"
            - {{ .Values.ollama.ollamaConfig.structuredOutputsConfig | quote }}
{{- end }}
{{- end }}
{{- end }}

