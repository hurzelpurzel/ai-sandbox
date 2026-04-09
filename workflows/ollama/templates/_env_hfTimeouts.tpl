{{/*
HuggingFace download timeout environment variables
Increase HuggingFace download timeout to handle slow connections and 504 errors
Default is 10 seconds, we set to 300 seconds (5 minutes) for large model downloads
Increase HuggingFace ETag timeout for metadata checks (helps with 504 Gateway Timeout errors)
Increase HuggingFace download retries to handle transient network errors (default is 3, we set to 10)
*/}}
{{- define "ollama.env.hfTimeouts" }}
{{- $hfDownloadTimeoutSet := false }}
{{- $hfEtagTimeoutSet := false }}
{{- $hfDownloadRetriesSet := false }}
{{- range .Values.ollama.env }}
{{- if eq .name "HF_HUB_DOWNLOAD_TIMEOUT" }}
{{- $hfDownloadTimeoutSet = true }}
{{- end }}
{{- if eq .name "HF_HUB_ETAG_TIMEOUT" }}
{{- $hfEtagTimeoutSet = true }}
{{- end }}
{{- if eq .name "HF_HUB_DOWNLOAD_RETRIES" }}
{{- $hfDownloadRetriesSet = true }}
{{- end }}
{{- end }}
{{- if not $hfDownloadTimeoutSet }}
            - name: HF_HUB_DOWNLOAD_TIMEOUT
              value: "300"
{{- end }}
{{- if not $hfEtagTimeoutSet }}
            - name: HF_HUB_ETAG_TIMEOUT
              value: "60"
{{- end }}
{{- if not $hfDownloadRetriesSet }}
            - name: HF_HUB_DOWNLOAD_RETRIES
              value: "10"
{{- end }}
{{- end }}

