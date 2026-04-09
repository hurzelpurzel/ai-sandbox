{{/*
Container security context with secure defaults
Provides security-by-default even if values.yaml doesn't specify securityContext
*/}}
{{- define "ollama.securityContext" }}
{{- $defaults := dict
  "capabilities" (dict "drop" (list "ALL") "add" (list))
  "readOnlyRootFilesystem" true
  "runAsNonRoot" true
  "runAsUser" 1001
  "runAsGroup" 1001
  "allowPrivilegeEscalation" false
  "seccompProfile" (dict "type" "RuntimeDefault")
}}
{{- $securityContext := merge $defaults (.Values.securityContext | default dict) }}
{{- toYaml $securityContext }}
{{- end }}

