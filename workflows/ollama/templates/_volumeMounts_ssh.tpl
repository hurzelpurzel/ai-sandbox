{{/*
SSH key volume mount for private HuggingFace model access
Mounts SSH directory from model-storage (PVC or emptyDir) to /home/ollama/.ssh (Ollama's expected location)
The SSH key is copied from secret to model-storage by init container, then mounted as subPath
NOTE: Must be writable (works with both PVC and emptyDir)
*/}}
{{- define "ollama.volumeMounts.ssh" }}
{{- if and .Values.ollama.sshKey.enabled .Values.ollama.sshKey.secretName }}
- name: model-storage
  mountPath: {{ .Values.ollama.sshKey.mountPath | default "/home/ollama/.ssh" }}
  subPath: .ssh
  readOnly: false
{{- end }}
{{- end }}

