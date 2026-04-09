{{/*
Calculate maxModelLen - in multi-model mode, use the maximum across all models
Otherwise, use the global maxModelLen
*/}}
{{- define "ollama.args.maxModelLen" }}
{{- if and .Values.ollama.multiModel .Values.ollama.models }}
{{- $maxLen := 0 }}
{{- $hasPerModelLen := false }}
{{- range .Values.ollama.models }}
{{- if .maxModelLen }}
{{- $hasPerModelLen = true }}
{{- if gt (int .maxModelLen) (int $maxLen) }}
{{- $maxLen = .maxModelLen }}
{{- end }}
{{- end }}
{{- end }}
{{- if $hasPerModelLen }}
{{- $maxLen }}
{{- else }}
{{- .Values.ollama.maxModelLen }}
{{- end }}
{{- else }}
{{- .Values.ollama.maxModelLen }}
{{- end }}
{{- end }}

