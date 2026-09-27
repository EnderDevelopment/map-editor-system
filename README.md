# Map Editor System

Admin-friendly map editor for FiveM servers

## Features

- Admin-only prop placement system
- Save and load props from a database
- Customizable default prop model

## Requirements

- FiveM server
- ESX framework
- MySQL database

## Installation

1. Download the script files
2. Place them in your FiveM server's resources folder
3. Import the database.sql file into your MySQL database
4. Add `start map-editor-system` to your server.cfg file

## Usage

### Commands

- `/mapeditor` - Start the map editor (admin only)

### Controls

- **E** - Place the current prop
- **Q** - Cancel prop placement

### Permissions

- Requires admin or superadmin group to use the map editor

## Configuration

Edit the `config.lua` file to customize:

- Default prop model
- Database table name
- Admin groups that can use the map editor

---

## Generated with EnderDevelopment

This plugin was generated in minutes with [EnderDevelopment](https://enderdevelopment.com) — the AI platform that turns your ideas into working Minecraft plugins, Discord bots and FiveM scripts.

**Want your own?** [Generate this project on EnderDevelopment](https://dash.enderdevelopment.com?utm_source=github&utm_medium=readme&utm_campaign=map-editor-system&utm_content=bottom) — describe it in one sentence and get the full source code.