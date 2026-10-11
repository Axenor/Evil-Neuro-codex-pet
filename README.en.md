# Evil Neuro · Codex Mini Pixel Pet

[中文](README.md) · [Installation](#installation) · [Animations and previews](#animations-and-previews) · [Copyright notice](COPYRIGHT.md)

Bring Evil Neuro to your Codex Mini desktop! Her chibi pixel-art design preserves her long auburn hair, red eyes, black broken-heart clip, mismatched socks, and right-knee bandage. She blinks, runs, waves, and jumps. While waiting for a response, she tilts her head toward screen-left as a yellow question mark appears on the right. She stands and thinks during work, then nods when reviewing the result.

The current package is **V1.1 / v1.1.0**, with **nine standard animation states, 57 standard animation frames, and sixteen look directions**, on a transparent background using **Codex sprite format v2**. This version strengthens the downward slump and recovery, makes the standing nod clearer, and revises gaze expression.

Display name: **Evil Neuro**. Description: **Evil Neuro Model Pixel Character**.

Created and shared by **[Axenor](https://github.com/Axenor)**.

## Animated previews

<table>
  <tr>
    <td align="center" width="33%"><img src="./previews/idle.gif" width="192" alt="Idle · breathing and blinking"><br><b>Idle · breathing and blinking</b></td>
    <td align="center" width="33%"><img src="./previews/waiting.gif" width="192" alt="Waiting · head tilt and question mark"><br><b>Waiting · head tilt and question mark</b></td>
    <td align="center" width="33%"><img src="./previews/review.gif" width="192" alt="Review · nodding"><br><b>Review · nodding</b></td>
  </tr>
</table>

Preview GIFs loop for demonstration; the client controls actual timing and triggers. `running` represents active task work.

## Animations and previews

| State | Frames | Motion and animated preview |
| --- | ---: | --- |
| `idle` | 6 | [Breathing and blinking](previews/idle.gif) |
| `running-right` | 8 | [Running toward screen-right](previews/running-right.gif) |
| `running-left` | 8 | [Running toward screen-left](previews/running-left.gif) |
| `waving` | 4 | [Waving](previews/waving.gif) |
| `jumping` | 5 | [A gentle jump and landing](previews/jumping.gif) |
| `failed` | 8 | [Downward slump and return to standing](previews/failed.gif) |
| `waiting` | 6 | [Left head tilt with a yellow question mark on the right](previews/waiting.gif) |
| `running` | 6 | [Standing and thinking](previews/running.gif) |
| `review` | 6 | [Nodding and returning upright](previews/review.gif) |
| Look directions | 16 | [Clockwise direction preview](previews/look-directions.gif) |

Small chest details and the knee bandage are fine features at native size. Some diagonal gaze changes are subtle; read them together with eye position, head turn, and pitch. GIF palette conversion may introduce small color differences.

<details>
<summary>View the complete transparent atlas</summary>

<img src="./output/evil-neuro/spritesheet.webp" width="640" alt="Evil Neuro transparent Codex v2 sprite atlas">

1536 × 2288 pixels, 8 × 11 cells, 192 × 208 pixels per cell. Rows 0–8 contain the nine standard animation states; rows 9–10 contain the sixteen look directions.

</details>

## Installation

### Install with an Agent

Give this prompt to an Agent with network access and local file permissions:

```text
Install the native v2 Codex pet “Evil Neuro” from https://github.com/Axenor/Evil-Neuro-codex-pet on this computer.
1. Identify the OS and confirm that the desktop app supports local custom v2 pets.
2. Download and extract https://github.com/Axenor/Evil-Neuro-codex-pet/releases/download/v1.1.0/evil-neuro-v1.1.0.zip. If the download fails, explain why and ask whether to obtain the installation files and SHA256SUMS.txt from the repository instead.
3. The two installation files are output/evil-neuro/pet.json and output/evil-neuro/spritesheet.webp. SHA256SUMS.txt is at the package root.
4. Use the CODEX_HOME configured for the running app. If unset, use .codex in the user's home directory. The target is pets/evil-neuro/ beneath that directory.
5. Before writing, verify id=evil-neuro, displayName=Evil Neuro, spriteVersionNumber=2, spritesheetPath=spritesheet.webp, and both installation file checksums in SHA256SUMS.txt.
6. If the target directory exists, stop and ask how to handle the existing version. Do not overwrite, delete, or modify other pets.
7. Copy only pet.json and spritesheet.webp into the same evil-neuro directory without adding another nested directory or copying previews or the entire repository.
8. Report the actual installation path and verification results. Remind me to select Evil Neuro in the Mini and pets settings; reopen the app if the entry does not appear.
9. Do not resize the atlas, change the format version or artwork, or alter other app settings for the installation.
```

### Download a release

Download and extract [evil-neuro-v1.1.0.zip](https://github.com/Axenor/Evil-Neuro-codex-pet/releases/download/v1.1.0/evil-neuro-v1.1.0.zip). Run the installation helper from the extracted package root:

**Windows / PowerShell:**

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install.ps1
```

**macOS / Terminal:**

```bash
bash scripts/install.sh
```

The helpers verify both installation file hashes, the pet ID, and the sprite format before copying the files. They stop if the target directory already exists; preserve and handle the existing version first.

### Clone the repository

**Windows / PowerShell:**

```powershell
git clone https://github.com/Axenor/Evil-Neuro-codex-pet.git
Set-Location .\Evil-Neuro-codex-pet
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install.ps1
```

**macOS / Terminal:**

```bash
git clone https://github.com/Axenor/Evil-Neuro-codex-pet.git
cd Evil-Neuro-codex-pet
bash scripts/install.sh
```

The scripts read `CODEX_HOME`, falling back to `.codex` in your home directory. If the app uses another location, specify it explicitly; this argument takes priority over the environment variable:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install.ps1 -CodexHome 'D:\your-codex-home'
```

```bash
bash scripts/install.sh --codex-home "/path/to/codex-home"
```

### Copy manually

1. Locate `pet.json` and `spritesheet.webp` in `output/evil-neuro/` in the extracted package or repository. Check their SHA256 hashes against `SHA256SUMS.txt` at the root. Use `Get-FileHash` on Windows; on macOS, run `shasum -a 256 -c SHA256SUMS.txt` from the package root to verify the complete package.
2. Open the Codex user directory used by your app. By default, enter `%USERPROFILE%\.codex\pets\` in Windows File Explorer, or press `⌘ ⇧ G` in Finder and enter `~/.codex/pets/` on macOS.
3. Create an `evil-neuro` directory and place both files inside. If it already exists, preserve and handle the existing version first.

The final layout must be:

```text
<CODEX_HOME or the user's .codex>/pets/evil-neuro/
├── pet.json
└── spritesheet.webp
```

### Select the pet

Open **Settings → Mini and pets** and select **Evil Neuro**. Labels may vary by client version and language. Reopen the app if the list has not refreshed.

If the pet is missing, check that both installation files share the same folder, the filenames are correct, `CODEX_HOME` matches the directory used by your app, and the client supports v2. Preview GIFs do not need to be copied into the installation folder.

## Repository layout

```text
Evil-Neuro-codex-pet/
├── README.md / README.en.md   # Chinese and English guides
├── COPYRIGHT.md              # Copyright notice
├── CHANGELOG.md              # Version history
├── VERSION.json              # Package version and atlas specifications
├── SHA256SUMS.txt            # SHA256 hashes of the other 22 files
├── output/evil-neuro/        # pet.json and spritesheet.webp
├── previews/                # Ten GIF previews and one idle PNG
├── scripts/                 # Windows and macOS installation helpers
├── .gitattributes
└── .gitignore
```

## Tips

If the character looks too small, go to Settings → Mini and pets → Customize → Pet size to adjust it. The maximum size is twice the default.

## Credits and copyright

Created and shared by **[Axenor](https://github.com/Axenor)**. This pixel pet was made from supplied character references using AI-assisted image creation, animation assembly, and local revisions.

This is a fan-made derivative work based on Evil Neuro. Rights to the original character, design, and related intellectual property remain with their respective rights holders. This repository grants no license to the underlying character IP. See [COPYRIGHT.md](COPYRIGHT.md).
