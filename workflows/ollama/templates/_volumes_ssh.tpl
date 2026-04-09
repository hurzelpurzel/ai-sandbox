{{/*
SSH key volumes for private HuggingFace model access
Uses secret (read-only) for the key, and PVC (writable, persistent) for .ssh directory
Init container copies key from secret to PVC with proper permissions
NOTE: SSH directory must be on PVC (persistent volume) because Ollama needs to write to /home/ollama/.ssh/config
*/}}
{{- define "ollama.volumes.ssh" }}
{{- if and .Values.ollama.sshKey.enabled .Values.ollama.sshKey.secretName }}
- name: ssh-key-secret
  secret:
    secretName: {{ .Values.ollama.sshKey.secretName | quote }}
    defaultMode: 0400
    items:
      - key: {{ .Values.ollama.sshKey.key | default "id_rsa" | quote }}
        path: {{ .Values.ollama.sshKey.key | default "id_rsa" | quote }}
{{- end }}
{{- end }}

