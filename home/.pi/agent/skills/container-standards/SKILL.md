---
name: container-standards
description: >
  Apply Jahir's container standards whenever discussing containers,
  orchestration, or related tooling. Trigger on: any mention of Docker,
  Podman, containers, container images, Containerfile, Dockerfile,
  docker-compose, Podman Compose, container networking, volumes, registries,
  or container-based CI/CD. Also trigger when a task involves running
  services locally via containers, even if the user doesn't mention a
  specific tool by name.
---

# Container Standards

## Podman First

Always default to Podman. Do not suggest Docker unless Jahir explicitly asks
for it or there is a concrete technical reason Docker is required (e.g., a
tool that only supports the Docker socket).

When giving container commands:
- Use `podman` not `docker`
- Use `Containerfile` not `Dockerfile` (Podman supports both, but
  `Containerfile` is the Podman-native convention)
- Use `podman-compose` or `podman play kube` not `docker-compose` where
  applicable

## Flag Docker-Specific Advice

If referencing documentation, tutorials, or examples that use Docker syntax:
- Note that it's Docker-sourced
- Translate to Podman equivalent before presenting
- Call out any behavioral differences (e.g., rootless by default in Podman,
  socket location differences, SELinux volume label flags `:z` / `:Z`)

## Podman-Specific Best Practices

- Prefer **rootless Podman** unless there's a specific reason to run as root.
- Use `--userns=keep-id` when bind-mounting host directories that need to
  match the host user's UID.
- Use `:z` or `:Z` volume mount flags on SELinux/RHEL systems to avoid
  permission issues.
- Prefer named volumes over bind mounts for persistent data when portability
  matters.
- Use `podman generate systemd` or Quadlet (`.container` files) for running
  containers as systemd services — not Docker Compose-style always-on
  containers.

## Networking

- Be explicit about network modes (`--network=host`, `--network=<name>`,
  `--network=slirp4netns` for rootless).
- When creating multi-container setups, prefer named Podman networks over
  default bridge behavior.
- Note that rootless Podman uses `slirp4netns` by default, which has
  different routing behavior than Docker's bridge — flag this when it's
  relevant.

## Research Before Advising

Podman evolves quickly (especially Quadlet, Podman Desktop, and compose
support). Look up current docs before advising on features that may have
changed between versions. Note the Podman version when version-specific
behavior is relevant.
