{{/*
Kyverno Policy: Deny Privileged Escalations
*/}}
{{- define "ollama.kyverno.privilegedEscalation" }}
# Kyverno Policy: Deny Privileged Escalations
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: deny-privileged-escalation-ollama
  labels:
    {{- include "ollama.labels" . | nindent 4 }}
spec:
  validationFailureAction: enforce
  background: true
  rules:
    - name: deny-privileged-escalation
      match:
        resources:
          kinds:
            - Pod
          selector:
            matchLabels:
              app.kubernetes.io/name: {{ include "ollama.name" . }}
      validate:
        message: "Privilege escalation is not allowed"
        pattern:
          spec:
            containers:
              - (securityContext):
                  allowPrivilegeEscalation: "false"
{{- end }}

