{{/*
Authentication API keys environment variables
*/}}
{{- define "ollama.env.auth" }}
{{- if .Values.auth.enabled }}
{{- range .Values.auth.keys }}
- name: {{ .name }}
  {{- if .valueFromSecret }}
  {{- $parts := splitList ":" .valueFromSecret }}
  {{- if and $parts (ge (len $parts) 2) }}
  {{- $secretName := "" }}
  {{- $secretKey := "" }}
  {{- range $i, $part := $parts }}
  {{- if eq $i 0 }}{{- $secretName = $part }}{{- end }}
  {{- if eq $i 1 }}{{- $secretKey = $part }}{{- end }}
  {{- end }}
  valueFrom:
    secretKeyRef:
      name: {{ $secretName | quote }}
      key: {{ $secretKey | quote }}
  {{- else }}
  {{- printf "Invalid valueFromSecret format: %s. Expected format: secret-name:key-name" .valueFromSecret | fail }}
  {{- end }}
  {{- else if .value }}
  value: {{ .value | quote }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}


