{{/*
Readiness probe configuration for Ollama
Ollama uses /api/tags endpoint for health checks
*/}}
{{- define "ollama.probe.readiness" }}
readinessProbe:
  httpGet:
    path: {{ .Values.healthChecks.readiness.path | default "/api/tags" }}
    port: http
  initialDelaySeconds: {{ .Values.healthChecks.readiness.initialDelaySeconds | default 5 }}
  periodSeconds: {{ .Values.healthChecks.readiness.periodSeconds | default 15 }}
  timeoutSeconds: {{ .Values.healthChecks.readiness.timeoutSeconds | default 2 }}
  failureThreshold: {{ .Values.healthChecks.readiness.failureThreshold | default 6 }}
{{- end }}

