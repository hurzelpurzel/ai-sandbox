{{/*
Core volumes (passwd-volume, workspace)
*/}}
{{- define "ollama.volumes.core" }}
# emptyDir volume for /etc/passwd - created by initContainer to provide UID 1001 entry
# This prevents PyTorch's getuser() from failing in subprocesses
- name: passwd-volume
  emptyDir: {}
# emptyDir volume for /workspace - ephemeral storage for cache directories
# This provides better isolation and proper permissions (handled by initContainer)
# Only add if not already defined in extraVolumes
{{- $workspaceVolumeExists := false }}
{{- if .Values.extraVolumes }}
{{- range .Values.extraVolumes }}
{{- if eq .name "workspace" }}
{{- $workspaceVolumeExists = true }}
{{- end }}
{{- end }}
{{- end }}
{{- if not $workspaceVolumeExists }}
- name: workspace
  emptyDir: {}
{{- end }}
{{- end }}

