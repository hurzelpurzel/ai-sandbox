{{/*
Startup probe configuration for Ollama
Ollama uses /api/tags endpoint for health checks
*/}}
{{- define "ollama.probe.startup" }}
startupProbe:
  httpGet:
    path: {{ .Values.healthChecks.startup.path | default "/api/tags" }}
    port: http
  initialDelaySeconds: {{ .Values.healthChecks.startup.initialDelaySeconds | default 30 }}
  periodSeconds: {{ .Values.healthChecks.startup.periodSeconds | default 30 }}
  timeoutSeconds: {{ .Values.healthChecks.startup.timeoutSeconds | default 5 }}
  failureThreshold: {{ .Values.healthChecks.startup.failureThreshold | default 120 }}
  # Startup probe prevents liveness probe from killing the container during startup
  # Once startup probe succeeds, liveness probe takes over
  # failureThreshold: 120 * periodSeconds: 30 = up to 60 minutes (3600s) for startup
  # This gives large models plenty of time to download and load
{{- end }}

