import docker
import logging
from rich.prompt import Prompt
from rich.console import Console
from rich.panel import Panel
from rich.text import Text

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)
console = Console()

response = Prompt.ask(
    "[bold yellow]Are you sure you want to go NUCLEAR?",
    choices=["yes", "no"],
    show_default=True,
    show_choices=True,
    default="no"
).strip().lower()

if response not in {"y", "yes"}:
    console.print("[bold red]Operation canceled.[/]")
    exit(1)

client = docker.from_env()

with console.status("[bold cyan]Starting Docker cleanup...[/]") as status:
    removed_containers = 0
    removed_images = 0
    removed_volumes = 0
    removed_networks = 0

    containers = client.containers.list(all=True)
    if containers:
        for container in containers:
            status.update(f"[bold cyan]Stopping: {container.name}[/]")
            container.stop()
            status.update(f"[bold cyan]Removing: {container.name}[/]")
            container.remove()
            removed_containers += 1

    images = client.images.list()
    if images:
        for image in images:
            try:
                status.update(f"[bold cyan]Removing image: {image.id}[/]")
                client.images.remove(image.id, force=True)
                removed_images += 1
            except docker.errors.APIError:
                continue  # Ignore images that cannot be removed

    volumes = client.volumes.list()
    if volumes:
        for volume in volumes:
            status.update(f"[bold cyan]Removing: {volume.name}[/]")
            volume.remove(force=True)
            removed_volumes += 1

    networks = client.networks.list()
    default_networks = {"bridge", "host", "none"}
    custom_networks = [
        net for net in networks
        if net.name not in default_networks
    ]

    if custom_networks:
        for network in custom_networks:
            status.update(f"[bold cyan]Removing: {network.name}[/]")
            network.remove()
            removed_networks += 1

    status.update("[bold cyan]Removing builder cache...[/]")
    client.api.prune_builds()

    status.update("[bold cyan]Removing dangling images...[/]")
    client.images.prune()

    status.update("[bold cyan]Removing unused volumes...[/]")
    client.volumes.prune()

    status.update("[bold cyan]Removing unused networks...[/]")
    client.networks.prune()

atom_bomb = Text(
  """
        _.-^^---....,,--
    _--                  --_
  <                        >)
  |_.                       |
    |._                   _./
      ```--. . , ; .--````
            | |   |
          .-=||  | |=-.
          `-=#$%&%$#=-'
            | ;  :|
    _____.,-#%&$@%#&#~,._____
  """,
  style="bold red"
)

final_message = Panel.fit(
    f"[bold green]💥 DOCKER CLEANUP COMPLETE! 💥[/]\n"
    f"[cyan]The digital wasteland has been purged![/]\n\n"
    f"🔥 [yellow]Containers removed:[/] {removed_containers}\n"
    f"💀 [yellow]Images removed:[/] {removed_images}\n"
    f"🗑️ [yellow]Volumes removed:[/] {removed_volumes}\n"
    f"🌐 [yellow]Networks removed:[/] {removed_networks}\n\n"
    f"[bold red]Nothing but dust remains...[/]",
    title=" ☢️ ATOMIC BLAST ☢️ ",
    border_style="bright_red",
)

console.print(atom_bomb)
console.print(final_message)
