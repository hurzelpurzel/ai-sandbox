{{/*
Liveness probe configuration for Ollama
Ollama uses /api/tags endpoint for health checks
*/}}
{{- define "ollama.probe.liveness" }}
livenessProbe:
  httpGet:
    path: {{ .Values.healthChecks.liveness.path | default "/api/tags" }}
    port: http
  initialDelaySeconds: {{ .Values.healthChecks.liveness.initialDelaySeconds | default 600 }}
  periodSeconds: {{ .Values.healthChecks.liveness.periodSeconds | default 30 }}
  timeoutSeconds: {{ .Values.healthChecks.liveness.timeoutSeconds | default 5 }}
  failureThreshold: {{ .Values.healthChecks.liveness.failureThreshold | default 10 }}
{{- end }}

