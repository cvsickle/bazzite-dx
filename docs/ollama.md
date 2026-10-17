# Ollama

Ollama is installed, but its user service is **disabled by default**.

The service runs `ollama serve` as your user and listens on port `11434` on all network interfaces.

## Enable autostart

Enable and start the service:

```bash
systemctl --user enable --now ollama.service
```

Verify it is running:

```bash
systemctl --user status ollama.service
curl http://localhost:11434/api/version
```

### Start on boot (without logging in)

A user service starts when you log in. To have it start on every boot, even without logging in, enable lingering for your user:

```bash
sudo loginctl enable-linger $USER
```

## Firewall

Port `11434` is only reachable from other machines if the firewall allows it. Bazzite uses `firewalld`.

Allow port `11434/tcp` in the default zone:

```bash
sudo firewall-cmd --permanent --add-port=11434/tcp
sudo firewall-cmd --reload
```

To allow it only on a specific zone, add `--zone=<zone>` to both commands.

Check the open ports:

```bash
sudo firewall-cmd --list-ports
```

> **Security:** Ollama has no built-in authentication. Anyone who can reach port `11434` can use your models. Only open the port on networks you trust, or limit access to a specific source with a rich rule.

## Disable autostart

Stop the service and disable autostart:

```bash
systemctl --user disable --now ollama.service
```

Also remove the firewall rule if you no longer need remote access:

```bash
sudo firewall-cmd --permanent --remove-port=11434/tcp
sudo firewall-cmd --reload
```

To turn off start-on-boot without login, disable lingering:

```bash
sudo loginctl disable-linger $USER
```

## Logs

```bash
journalctl --user -e -u ollama.service
```

## Usage

Pull and run a model:

```bash
ollama pull llama3.2
ollama run llama3.2
```

Models are stored in `~/.ollama`.
