{{/*
S3/MinIO Object Storage Configuration
*/}}
{{- define "ollama.env.s3" }}
{{- if .Values.ollama.s3.enabled }}
# S3/MinIO Object Storage Configuration
# OLLAMA supports loading models from S3-compatible storage using s3:// URLs
# PREFERRED: Use credentials from Kubernetes secret (recommended for production)
# ALTERNATIVE: Use direct credentials (not recommended for production)
{{- if .Values.ollama.s3.credentials.secretName }}
- name: S3_ACCESS_KEY_ID
  valueFrom:
    secretKeyRef:
      name: {{ .Values.ollama.s3.credentials.secretName | quote }}
      key: {{ .Values.ollama.s3.credentials.accessKeyKey | quote }}
- name: S3_SECRET_ACCESS_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.ollama.s3.credentials.secretName | quote }}
      key: {{ .Values.ollama.s3.credentials.secretKeyKey | quote }}
{{- else if .Values.ollama.s3.accessKeyId }}
- name: S3_ACCESS_KEY_ID
  value: {{ .Values.ollama.s3.accessKeyId | quote }}
- name: S3_SECRET_ACCESS_KEY
  value: {{ .Values.ollama.s3.secretAccessKey | quote }}
{{- end }}
{{- if .Values.ollama.s3.endpoint }}
# S3 endpoint URL (required for MinIO, optional for AWS S3)
- name: S3_ENDPOINT_URL
  value: {{ .Values.ollama.s3.endpoint | quote }}
{{- end }}
{{- if .Values.ollama.s3.region }}
# S3 region (optional, can be any string for MinIO)
- name: AWS_DEFAULT_REGION
  value: {{ .Values.ollama.s3.region | quote }}
{{- end }}
{{- end }}
{{- end }}

