{{/*
Pod metadata (labels and annotations)
*/}}
{{- define "ollama.podMetadata" }}
{{- with .Values.podAnnotations }}
annotations:
  {{- toYaml . | nindent 2 }}
{{- end }}
labels:
  {{- include "ollama.selectorLabels" . | nindent 2 }}
  {{- with .Values.podLabels }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  # PodSecurity Standards (PSS)
  pod-security.kubernetes.io/enforce: {{ .Values.podSecurityStandards.enforce | default "restricted" | quote }}
  pod-security.kubernetes.io/audit: {{ .Values.podSecurityStandards.audit | default "restricted" | quote }}
  pod-security.kubernetes.io/warn: {{ .Values.podSecurityStandards.warn | default "restricted" | quote }}
{{- end }}

