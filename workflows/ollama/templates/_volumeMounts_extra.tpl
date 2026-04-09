{{/*
Extra volume mounts from .Values.extraVolumeMounts
*/}}
{{- define "ollama.volumeMounts.extra" }}
{{- with .Values.extraVolumeMounts }}
{{- range . }}
- name: {{ .name }}
  mountPath: {{ .mountPath }}
  {{- if .readOnly }}
  readOnly: {{ .readOnly }}
  {{- end }}
  {{- if .subPath }}
  subPath: {{ .subPath }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

