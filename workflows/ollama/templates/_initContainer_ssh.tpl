{{/*
SSH key setup init container
Sets up SSH keys with proper permissions for private HuggingFace model access
Copies SSH key from Kubernetes secret to model-storage at /models/.ssh (PVC or emptyDir)
The .ssh directory is then mounted to /home/ollama/.ssh in the main container
NOTE: Works with both PVC (persistent) and emptyDir (ephemeral)
*/}}
{{- define "ollama.initContainer.ssh" }}
{{- if and .Values.ollama.sshKey.enabled .Values.ollama.sshKey.secretName }}
  - name: setup-ssh-keys
    image: busybox:latest
    securityContext:
      runAsUser: 0  # Run as root to fix permissions
      runAsNonRoot: false
      readOnlyRootFilesystem: false  # Allow writes for setup
      allowPrivilegeEscalation: false
      capabilities:
        drop:
          - ALL
        add:
          - CHOWN
          - FOWNER
    command:
      - sh
      - -c
      - |
        echo "Setting up SSH keys for HuggingFace private model access..."
        
        # SSH directory on model-storage (PVC if persistence enabled, emptyDir if disabled)
        SSH_DIR="/models/.ssh"
        SSH_KEY_SOURCE="/tmp/ssh-key/{{ .Values.ollama.sshKey.key | default "id_rsa" }}"
        SSH_KEY_FILE="$SSH_DIR/{{ .Values.ollama.sshKey.key | default "id_rsa" }}"
        KEY_MODE="{{ .Values.ollama.sshKey.keyMode | default "0600" }}"
        
        # Create .ssh directory on PVC
        mkdir -p "$SSH_DIR"
        chmod 0700 "$SSH_DIR"
        
        # Copy SSH key from secret volume to PVC .ssh directory with proper permissions
        if [ -f "$SSH_KEY_SOURCE" ]; then
          cp "$SSH_KEY_SOURCE" "$SSH_KEY_FILE"
          chmod "$KEY_MODE" "$SSH_KEY_FILE"
          chown 1001:1001 "$SSH_KEY_FILE"  # Owned by ollama user (UID 1001)
          echo "SSH key copied and permissions set: $SSH_KEY_FILE ($KEY_MODE)"
        else
          echo "WARNING: SSH key file not found in secret: $SSH_KEY_SOURCE"
          exit 1
        fi
        
        # Create known_hosts file (users can add HuggingFace host keys manually if needed)
        # Note: Ollama will handle SSH host key verification automatically
        touch "$SSH_DIR/known_hosts"
        chmod 0644 "$SSH_DIR/known_hosts"
        chown 1001:1001 "$SSH_DIR/known_hosts"
        
        # Ensure .ssh directory is owned by ollama user (UID 1001)
        chown -R 1001:1001 "$SSH_DIR"
        
        echo "SSH setup complete on PVC: $SSH_DIR"
    volumeMounts:
      - name: ssh-key-secret
        mountPath: /tmp/ssh-key
        readOnly: true
      - name: model-storage
        mountPath: /models
        readOnly: false
    resources:
      requests:
        cpu: 10m
        memory: 16Mi
        ephemeral-storage: 100Mi
      limits:
        cpu: 100m
        memory: 64Mi
        ephemeral-storage: 500Mi
{{- end }}
{{- end }}

