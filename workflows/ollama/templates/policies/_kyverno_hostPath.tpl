{{/*
Kyverno Policy: Deny HostPath Volumes
*/}}
{{- define "ollama.kyverno.hostPath" }}
# Kyverno Policy: Deny HostPath Volumes
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: deny-hostpath-ollama
  labels:
    {{- include "ollama.labels" . | nindent 4 }}
spec:
  validationFailureAction: enforce
  background: true
  rules:
    - name: deny-hostpath
      match:
        resources:
          kinds:
            - Pod
          selector:
            matchLabels:
              app.kubernetes.io/name: {{ include "ollama.name" . }}
      validate:
        message: "HostPath volumes are not allowed"
        pattern:
          spec:
            =(volumes):
              - X(hostPath): "null"
{{- end }}

