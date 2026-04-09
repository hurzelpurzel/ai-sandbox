{{/*
Pod scheduling configuration (nodeSelector, tolerations, topologySpreadConstraints, priorityClassName)
*/}}
{{- define "ollama.scheduling" }}
{{- with .Values.nodeSelector }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- if .Values.priorityClassName }}
priorityClassName: {{ .Values.priorityClassName }}
{{- end }}
{{- if .Values.topologySpreadConstraints.enabled }}
topologySpreadConstraints:
  - maxSkew: {{ .Values.topologySpreadConstraints.maxSkew }}
    topologyKey: {{ .Values.topologySpreadConstraints.topologyKey }}
    whenUnsatisfiable: {{ .Values.topologySpreadConstraints.whenUnsatisfiable }}
    labelSelector:
      matchLabels:
        {{- include "ollama.selectorLabels" . | nindent 8 }}
{{- end }}
{{- with .Values.tolerations }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}

