{{/*
OPA Gatekeeper Constraint: Deny Privileged Escalation
*/}}
{{- define "ollama.opa.constraint" }}
# OPA Gatekeeper Constraint: Deny Privileged Escalation
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sDenyPrivilegeEscalationVLLM
metadata:
  name: deny-privileged-escalation-ollama
  labels:
    {{- include "ollama.labels" . | nindent 4 }}
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Pod"]
    labelSelector:
      matchLabels:
        app.kubernetes.io/name: {{ include "ollama.name" . }}
  parameters:
    message: "Privilege escalation is not allowed"
{{- end }}

