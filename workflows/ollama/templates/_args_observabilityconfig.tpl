{{/*
ObservabilityConfig arguments for ollama serve
Configuration for observability - metrics and tracing
*/}}
{{- define "ollama.args.observabilityconfig" }}
{{- if .Values.ollama.observabilityConfig }}
{{- if and .Values.ollama.observabilityConfig.collectDetailedTraces (gt (len .Values.ollama.observabilityConfig.collectDetailedTraces) 0) }}
            - "--collect-detailed-traces"
            {{- range .Values.ollama.observabilityConfig.collectDetailedTraces }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if .Values.ollama.observabilityConfig.otlpTracesEndpoint }}
            - "--otlp-traces-endpoint"
            - {{ .Values.ollama.observabilityConfig.otlpTracesEndpoint | quote }}
{{- end }}
{{- if .Values.ollama.observabilityConfig.showHiddenMetricsForVersion }}
            - "--show-hidden-metrics-for-version"
            - {{ .Values.ollama.observabilityConfig.showHiddenMetricsForVersion | quote }}
{{- end }}
{{- end }}
{{- end }}

