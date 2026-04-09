{{/*
Ingress metadata and annotations
*/}}
{{- define "ollama.ingress.metadata" }}
{{- $fullName := include "ollama.fullname" . -}}
{{- if and .Values.ingress.className (not (hasKey .Values.ingress.annotations "kubernetes.io/ingress.class")) }}
  {{- $_ := set .Values.ingress.annotations "kubernetes.io/ingress.class" .Values.ingress.className}}
{{- end }}
metadata:
  name: {{ $fullName }}
  labels:
    {{- include "ollama.labels" . | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

