{{/*
Frontend arguments for ollama serve
Arguments for the OpenAI-compatible frontend server
*/}}
{{- define "ollama.args.frontend" }}
{{- if .Values.ollama.frontend }}
{{- if .Values.ollama.frontend.allowedOrigins }}
            - "--allowed-origins"
            {{- range .Values.ollama.frontend.allowedOrigins }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if .Values.ollama.frontend.allowedMethods }}
            - "--allowed-methods"
            {{- range .Values.ollama.frontend.allowedMethods }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if .Values.ollama.frontend.allowedHeaders }}
            - "--allowed-headers"
            {{- range .Values.ollama.frontend.allowedHeaders }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.allowCredentials nil }}
            {{- if .Values.ollama.frontend.allowCredentials }}
            - "--allow-credentials"
            {{- else }}
            - "--no-allow-credentials"
            {{- end }}
{{- end }}
{{- if .Values.ollama.frontend.chatTemplate }}
            - "--chat-template"
            - {{ .Values.ollama.frontend.chatTemplate | quote }}
{{- end }}
{{- if .Values.ollama.frontend.chatTemplateContentFormat }}
            - "--chat-template-content-format"
            - {{ .Values.ollama.frontend.chatTemplateContentFormat | quote }}
{{- end }}
{{- if ne .Values.ollama.frontend.disableFastApiDocs nil }}
            {{- if .Values.ollama.frontend.disableFastApiDocs }}
            - "--disable-fastapi-docs"
            {{- else }}
            - "--no-disable-fastapi-docs"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.disableUvicornAccessLog nil }}
            {{- if .Values.ollama.frontend.disableUvicornAccessLog }}
            - "--disable-uvicorn-access-log"
            {{- else }}
            - "--no-disable-uvicorn-access-log"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.enableAutoToolChoice nil }}
            {{- if .Values.ollama.frontend.enableAutoToolChoice }}
            - "--enable-auto-tool-choice"
            {{- else }}
            - "--no-enable-auto-tool-choice"
            {{- end }}
{{- end }}
{{- if .Values.ollama.frontend.toolCallParser }}
            - "--tool-call-parser"
            - {{ .Values.ollama.frontend.toolCallParser | quote }}
{{- end }}
{{- if .Values.ollama.frontend.toolServer }}
            - "--tool-server"
            - {{ .Values.ollama.frontend.toolServer | quote }}
{{- end }}
{{- if .Values.ollama.frontend.uvicornLogLevel }}
            - "--uvicorn-log-level"
            - {{ .Values.ollama.frontend.uvicornLogLevel | quote }}
{{- end }}
{{- if .Values.ollama.frontend.rootPath }}
            - "--root-path"
            - {{ .Values.ollama.frontend.rootPath | quote }}
{{- end }}
{{- if .Values.ollama.frontend.uds }}
            - "--uds"
            - {{ .Values.ollama.frontend.uds | quote }}
{{- end }}
{{- if .Values.ollama.frontend.sslCertfile }}
            - "--ssl-certfile"
            - {{ .Values.ollama.frontend.sslCertfile | quote }}
{{- end }}
{{- if .Values.ollama.frontend.sslKeyfile }}
            - "--ssl-keyfile"
            - {{ .Values.ollama.frontend.sslKeyfile | quote }}
{{- end }}
{{- if .Values.ollama.frontend.sslCaCerts }}
            - "--ssl-ca-certs"
            - {{ .Values.ollama.frontend.sslCaCerts | quote }}
{{- end }}
{{- if ne .Values.ollama.frontend.sslCertReqs nil }}
            - "--ssl-cert-reqs"
            - {{ .Values.ollama.frontend.sslCertReqs | int | quote }}
{{- end }}
{{- if ne .Values.ollama.frontend.enableSslRefresh nil }}
            {{- if .Values.ollama.frontend.enableSslRefresh }}
            - "--enable-ssl-refresh"
            {{- else }}
            - "--no-enable-ssl-refresh"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.enableForceIncludeUsage nil }}
            {{- if .Values.ollama.frontend.enableForceIncludeUsage }}
            - "--enable-force-include-usage"
            {{- else }}
            - "--no-enable-force-include-usage"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.enableLogOutputs nil }}
            {{- if .Values.ollama.frontend.enableLogOutputs }}
            - "--enable-log-outputs"
            {{- else }}
            - "--no-enable-log-outputs"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.enablePromptTokensDetails nil }}
            {{- if .Values.ollama.frontend.enablePromptTokensDetails }}
            - "--enable-prompt-tokens-details"
            {{- else }}
            - "--no-enable-prompt-tokens-details"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.excludeToolsWhenToolChoiceNone nil }}
            {{- if .Values.ollama.frontend.excludeToolsWhenToolChoiceNone }}
            - "--exclude-tools-when-tool-choice-none"
            {{- else }}
            - "--no-exclude-tools-when-tool-choice-none"
            {{- end }}
{{- end }}
{{- if .Values.ollama.frontend.h11MaxHeaderCount }}
            - "--h11-max-header-count"
            - {{ .Values.ollama.frontend.h11MaxHeaderCount | int | quote }}
{{- end }}
{{- if .Values.ollama.frontend.h11MaxIncompleteEventSize }}
            - "--h11-max-incomplete-event-size"
            - {{ .Values.ollama.frontend.h11MaxIncompleteEventSize | int | quote }}
{{- end }}
{{- if .Values.ollama.frontend.logConfigFile }}
            - "--log-config-file"
            - {{ .Values.ollama.frontend.logConfigFile | quote }}
{{- end }}
{{- if .Values.ollama.frontend.maxLogLen }}
            - "--max-log-len"
            - {{ .Values.ollama.frontend.maxLogLen | quote }}
{{- end }}
{{- if and .Values.ollama.frontend.middleware (gt (len .Values.ollama.frontend.middleware) 0) }}
            {{- range .Values.ollama.frontend.middleware }}
            - "--middleware"
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if .Values.ollama.frontend.responseRole }}
            - "--response-role"
            - {{ .Values.ollama.frontend.responseRole | quote }}
{{- end }}
{{- if ne .Values.ollama.frontend.returnTokensAsTokenIds nil }}
            {{- if .Values.ollama.frontend.returnTokensAsTokenIds }}
            - "--return-tokens-as-token-ids"
            {{- else }}
            - "--no-return-tokens-as-token-ids"
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.tokensOnly nil }}
            {{- if .Values.ollama.frontend.tokensOnly }}
            - "--tokens-only"
            {{- else }}
            - "--no-tokens-only"
            {{- end }}
{{- end }}
{{- if .Values.ollama.frontend.toolParserPlugin }}
            - "--tool-parser-plugin"
            - {{ .Values.ollama.frontend.toolParserPlugin | quote }}
{{- end }}
{{- if ne .Values.ollama.frontend.trustRequestChatTemplate nil }}
            {{- if .Values.ollama.frontend.trustRequestChatTemplate }}
            - "--trust-request-chat-template"
            {{- else }}
            - "--no-trust-request-chat-template"
            {{- end }}
{{- end }}
{{- if and .Values.ollama.frontend.loraModules (gt (len .Values.ollama.frontend.loraModules) 0) }}
            - "--lora-modules"
            {{- range .Values.ollama.frontend.loraModules }}
            - {{ . | quote }}
            {{- end }}
{{- end }}
{{- if ne .Values.ollama.frontend.disableFrontendMultiprocessing nil }}
            {{- if .Values.ollama.frontend.disableFrontendMultiprocessing }}
            - "--disable-frontend-multiprocessing"
            {{- else }}
            - "--no-disable-frontend-multiprocessing"
            {{- end }}
{{- end }}
{{- end }}
{{- end }}

