{{/*
Core volume mounts (workspace, passwd-volume)
*/}}
{{- define "ollama.volumeMounts.core" }}
# Mount workspace volume (ephemeral) for cache directories (fallback when persistence disabled)
# When persistence.enabled=true, cache directories are on PVC at /models/.cache (persistent)
# When persistence.enabled=false, cache directories use workspace (emptyDir, ephemeral)
# CRITICAL: Must be writable (readOnly: false) for cache directories
# Only add if not already defined in extraVolumeMounts
{{- $workspaceMountExists := false }}
{{- if .Values.extraVolumeMounts }}
{{- range .Values.extraVolumeMounts }}
{{- if eq .name "workspace" }}
{{- $workspaceMountExists = true }}
{{- end }}
{{- end }}
{{- end }}
{{- if not $workspaceMountExists }}
- name: workspace
  mountPath: /workspace
  readOnly: false
{{- end }}
# Mount passwd-volume to /etc/passwd.d/ directory (not directly to /etc/passwd)
# The passwd file is prepared by the initContainer in this directory
# This follows security best practices by not mounting directly to system files
- name: passwd-volume
  mountPath: /etc/passwd.d
  readOnly: true
{{- end }}

