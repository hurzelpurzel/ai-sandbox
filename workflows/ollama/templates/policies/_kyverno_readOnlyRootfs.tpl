{{/*
Kyverno Policy: Enforce Read-Only Root Filesystem
*/}}
{{- define "ollama.kyverno.readOnlyRootfs" }}
# Kyverno Policy: Enforce Read-Only Root Filesystem
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: enforce-readonly-rootfs-ollama
  labels:
    {{- include "ollama.labels" . | nindent 4 }}
spec:
  validationFailureAction: enforce
  background: true
  rules:
    - name: enforce-readonly-rootfs
      match:
        resources:
          kinds:
            - Pod
          selector:
            matchLabels:
              app.kubernetes.io/name: {{ include "ollama.name" . }}
      validate:
        message: "Containers must have read-only root filesystem"
        pattern:
          spec:
            containers:
              - (securityContext):
                  readOnlyRootFilesystem: true
{{- end }}

