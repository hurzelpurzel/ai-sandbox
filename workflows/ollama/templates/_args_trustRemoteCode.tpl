{{/*
Determine if trust-remote-code is needed
Checks: global setting, per-model setting, or GPTQ/AWQ quantization
*/}}
{{- define "ollama.args.trustRemoteCode" }}
{{- $needsTrustRemoteCode := .Values.ollama.trustRemoteCode }}
{{- if and .Values.ollama.multiModel .Values.ollama.models }}
{{- range .Values.ollama.models }}
{{- if .trustRemoteCode }}
{{- $needsTrustRemoteCode = true }}
{{- end }}
{{- if and .quantization (or (eq .quantization.type "gptq") (eq .quantization.type "awq")) }}
{{- $needsTrustRemoteCode = true }}
{{- end }}
{{- end }}
{{- end }}
{{- if $needsTrustRemoteCode }}true{{- end }}
{{- end }}

