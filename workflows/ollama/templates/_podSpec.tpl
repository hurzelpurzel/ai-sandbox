{{/*
Pod spec configuration (runtimeClassName, hostNetwork, hostIPC, hostPID, imagePullSecrets, serviceAccount, securityContext, initContainers, terminationGracePeriodSeconds)
*/}}
{{- define "ollama.podSpec" }}
{{- if .Values.runtimeClassName }}
runtimeClassName: {{ .Values.runtimeClassName | quote }}
{{- end }}
{{- if .Values.podSecurityStandards.disallowHostNetwork }}
hostNetwork: false
{{- else if ne .Values.hostNetwork nil }}
hostNetwork: {{ .Values.hostNetwork }}
{{- end }}
{{- if ne .Values.hostIPC nil }}
hostIPC: {{ .Values.hostIPC }}
{{- end }}
{{- if ne .Values.hostPID nil }}
hostPID: {{ .Values.hostPID }}
{{- end }}
{{- with .Values.imagePullSecrets }}
imagePullSecrets:
  {{- toYaml . | nindent 2 }}
{{- end }}
serviceAccountName: {{ include "ollama.serviceAccountName" . }}
automountServiceAccountToken: {{ .Values.serviceAccount.automountServiceAccountToken | default false }}
securityContext:
  {{- toYaml .Values.podSecurityContext | nindent 2 }}
{{- if .Values.terminationGracePeriodSeconds }}
terminationGracePeriodSeconds: {{ .Values.terminationGracePeriodSeconds }}
{{- end }}
{{- if or .Values.initContainers (and .Values.ollama.sshKey.enabled .Values.ollama.sshKey.secretName) }}
initContainers:
{{- include "ollama.initContainer.passwd" . }}
{{- if .Values.initContainers }}
  {{- toYaml .Values.initContainers | nindent 2 }}
{{- end }}
{{- include "ollama.initContainer.ssh" . }}
{{- else }}
initContainers:
{{- include "ollama.initContainer.passwd" . }}
{{- end }}
{{- end }}

