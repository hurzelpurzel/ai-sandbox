{{/*
Extra volumes from .Values.extraVolumes
*/}}
{{- define "ollama.volumes.extra" }}
{{- with .Values.extraVolumes }}
{{- range . }}
- name: {{ .name }}
  {{- if .persistentVolumeClaim }}
  persistentVolumeClaim:
    {{- toYaml .persistentVolumeClaim | nindent 4 }}
  {{- else if .emptyDir }}
  emptyDir:
    {{- toYaml .emptyDir | nindent 4 }}
  {{- else if .hostPath }}
  hostPath:
    {{- toYaml .hostPath | nindent 4 }}
  {{- else if .configMap }}
  configMap:
    {{- toYaml .configMap | nindent 4 }}
  {{- else if .secret }}
  secret:
    {{- toYaml .secret | nindent 4 }}
  {{- else }}
  {{- toYaml (omit . "name") | nindent 2 }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

