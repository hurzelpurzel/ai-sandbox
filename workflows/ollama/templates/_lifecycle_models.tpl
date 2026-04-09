{{/*
Lifecycle hook for pulling models at container startup (DEPRECATED - use entrypoint / OLLAMA_AUTO_PULL_MODELS instead)
Handles both Ollama catalog models (e.g., "llama2") and HuggingFace URLs (e.g., "hf.co/google/gemma-7b-it")
NOTE: This template is not used by default - deployment.yaml does not include lifecycle hooks.
*/}}
{{- define "ollama.lifecycle.models" }}
{{- if and .Values.ollama.models.pull (gt (len .Values.ollama.models.pull) 0) }}
          lifecycle:
            postStart:
              exec:
                command:
                  - /bin/sh
                  - -c
                  - |
                    echo "=========================================="
                    echo "Ollama Model Management (postStart hook)"
                    echo "=========================================="
                    echo "Starting at: $(date)"
                    echo "OLLAMA_HOST=${OLLAMA_HOST}"
                    
                    # Extract port from OLLAMA_HOST (format: 0.0.0.0:11434 or http://0.0.0.0:11434)
                    OLLAMA_PORT="${OLLAMA_HOST##*:}"
                    OLLAMA_PORT="${OLLAMA_PORT#http://}"
                    OLLAMA_PORT="${OLLAMA_PORT#https://}"
                    OLLAMA_PORT="${OLLAMA_PORT%%/*}"
                    echo "Extracted port: ${OLLAMA_PORT}"
                    
                    # Wait for Ollama server to be ready (it starts in the background)
                    echo "Waiting for Ollama server to be ready on port ${OLLAMA_PORT}..."
                    MAX_WAIT=300  # 5 minutes max wait
                    WAIT_COUNT=0
                    SERVER_READY=false
                    while [ $WAIT_COUNT -lt $MAX_WAIT ]; do
                      if curl -sf --max-time 2 "http://localhost:${OLLAMA_PORT}/api/tags" > /dev/null 2>&1; then
                        echo "✓ Ollama server is ready"
                        SERVER_READY=true
                        break
                      fi
                      if [ $((WAIT_COUNT % 10)) -eq 0 ]; then
                        echo "Waiting for Ollama server... (${WAIT_COUNT}s/${MAX_WAIT}s)"
                      fi
                      sleep 1
                      WAIT_COUNT=$((WAIT_COUNT + 1))
                    done
                    
                    if [ "$SERVER_READY" != "true" ]; then
                      echo "⚠️  WARNING: Ollama server did not become ready within ${MAX_WAIT} seconds"
                      echo "Model pull/run operations may fail"
                      exit 1
                    fi
                    
                    # Pull models using Ollama API
                    {{- if and .Values.ollama.models.pull (gt (len .Values.ollama.models.pull) 0) }}
                    echo ""
                    echo "Pulling models via Ollama API..."
                    {{- range .Values.ollama.models.pull }}
                    MODEL="{{ . }}"
                    echo "  → Pulling model: ${MODEL}"
                    # Use Ollama API POST /api/pull to download the model
                    # The API returns a streaming JSON response with status updates
                    PULL_RESPONSE=$(curl -sf --max-time 3600 -X POST \
                      -H "Content-Type: application/json" \
                      -d "{\"name\":\"${MODEL}\"}" \
                      "http://localhost:${OLLAMA_PORT}/api/pull" 2>&1)
                    PULL_EXIT=$?
                    
                    if [ $PULL_EXIT -eq 0 ]; then
                      # Check if the response indicates success (look for "status":"success" or "status":"downloading")
                      if echo "${PULL_RESPONSE}" | grep -q '"status":"success"'; then
                        echo "    ✓ Successfully pulled: ${MODEL}"
                      elif echo "${PULL_RESPONSE}" | grep -q '"status":"downloading"'; then
                        echo "    ✓ Pull initiated: ${MODEL} (download in progress)"
                      else
                        echo "    ⚠ Pull response: ${PULL_RESPONSE}"
                      fi
                    else
                      echo "    ✗ Failed to pull: ${MODEL}"
                      echo "    Error: ${PULL_RESPONSE}"
                      # Don't exit on failure - continue with other models
                    fi
                    {{- end }}
                    {{- end }}
                    
                    echo ""
                    echo "=========================================="
                    echo "Model management complete"
                    echo "=========================================="
{{- end }}
{{- end }}

