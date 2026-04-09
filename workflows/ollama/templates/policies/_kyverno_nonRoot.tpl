{{/*
Kyverno Policy: Enforce Non-Root
*/}}
{{- define "ollama.kyverno.nonRoot" }}
# Kyverno Policy: Enforce Non-Root
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: enforce-non-root-ollama
  labels:
    {{- include "ollama.labels" . | nindent 4 }}
spec:
  validationFailureAction: enforce
  background: true
  rules:
    - name: enforce-non-root
      match:
        resources:
          kinds:
            - Pod
          selector:
            matchLabels:
              app.kubernetes.io/name: {{ include "ollama.name" . }}
      validate:
        message: "Containers must run as non-root"
        pattern:
          spec:
            securityContext:
              runAsNonRoot: true
            containers:
              - (securityContext):
                  runAsNonRoot: true
{{- end }}

