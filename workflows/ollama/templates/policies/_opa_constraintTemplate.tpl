{{/*
OPA Gatekeeper Constraint Template: Deny Privileged Escalation
*/}}
{{- define "ollama.opa.constraintTemplate" }}
# OPA Gatekeeper Constraint Template: Deny Privileged Escalation
apiVersion: templates.gatekeeper.sh/v1beta1
kind: ConstraintTemplate
metadata:
  name: k8sdenyprivilegedescalationollama
  labels:
    {{- include "ollama.labels" . | nindent 4 }}
spec:
  crd:
    spec:
      names:
        kind: K8sDenyPrivilegeEscalationVLLM
      validation:
        openAPIV3Schema:
          type: object
          properties:
            message:
              type: string
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8sdenyprivilegedescalationollama
        violation[{"msg": msg}] {
          container := input.review.object.spec.containers[_]
          container.securityContext.allowPrivilegeEscalation == true
          msg := sprintf("Privilege escalation is not allowed for container: %v", [container.name])
        }
{{- end }}

