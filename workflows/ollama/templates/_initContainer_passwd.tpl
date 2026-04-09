{{/*
Passwd setup init container
Prepares /etc/passwd entry for UID 1001 (ollama user) to prevent PyTorch getuser() KeyError
The passwd file is created in an emptyDir volume and mounted to /etc/passwd.d/ in the main container
*/}}
{{- define "ollama.initContainer.passwd" }}
  - name: setup-passwd
    image: busybox:latest
    securityContext:
      runAsUser: 0  # Run as root to create passwd file
      runAsNonRoot: false
      readOnlyRootFilesystem: false  # Allow writes for setup
      allowPrivilegeEscalation: false
      capabilities:
        drop:
          - ALL
    command:
      - sh
      - -c
      - |
        echo "Setting up /etc/passwd entry for UID 1001..."
        
        PASSWD_DIR="/etc/passwd.d"
        PASSWD_FILE="$PASSWD_DIR/passwd"
        
        # Create passwd.d directory
        mkdir -p "$PASSWD_DIR"
        
        # Create passwd file with ollama user entry (UID 1001, GID 1001)
        # This prevents PyTorch's getuser() from failing in subprocesses
        cat > "$PASSWD_FILE" <<EOF
        root:x:0:0:root:/root:/bin/sh
        ollama:x:1001:1001:ollama user:/home/ollama:/bin/sh
        EOF
        
        chmod 0644 "$PASSWD_FILE"
        echo "Passwd file created: $PASSWD_FILE"
    volumeMounts:
      - name: passwd-volume
        mountPath: /etc/passwd.d
        readOnly: false
    resources:
      requests:
        cpu: 10m
        memory: 16Mi
        ephemeral-storage: 10Mi
      limits:
        cpu: 100m
        memory: 64Mi
        ephemeral-storage: 50Mi
{{- end }}

