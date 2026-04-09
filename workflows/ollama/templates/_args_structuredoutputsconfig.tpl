{{/*
StructuredOutputsConfig arguments for ollama serve
Structured outputs configuration
*/}}
{{- define "ollama.args.structuredoutputsconfig" }}
{{- if .Values.ollama.structuredOutputsConfig }}
{{- if .Values.ollama.structuredOutputsConfig.reasoningParser }}
            - "--reasoning-parser"
            - {{ .Values.ollama.structuredOutputsConfig.reasoningParser | quote }}
{{- end }}
{{- if .Values.ollama.structuredOutputsConfig.reasoningParserPlugin }}
            - "--reasoning-parser-plugin"
            - {{ .Values.ollama.structuredOutputsConfig.reasoningParserPlugin | quote }}
{{- end }}
{{- end }}
{{- end }}

