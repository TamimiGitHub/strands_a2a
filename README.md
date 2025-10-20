# Strands A2A Server

A simple implementation of Strands agents exposed as an A2A (Agent-to-Agent) server.

## Overview

This project sets up a basic A2A server using the Strands framework. It creates a Calculator Agent that can perform basic arithmetic operations using the [Strands calculator tool](https://github.com/strands-agents/tools/tree/main/src/strands_tools) and exposes it through an A2A server interface, allowing other agents to communicate with it.

## Prerequisites

- Python 3.10+

## Setup Instructions

### 1. Create and Activate a Python Virtual Environment

#### On macOS/Linux:
```bash
# Create a virtual environment
python -m venv .venv

# Activate the virtual environment
source .venv/bin/activate
```

#### On Windows:
```bash
# Create a virtual environment
python -m venv .venv

# Activate the virtual environment
.venv\Scripts\activate
```

### 2. Install Dependencies

With the virtual environment activated, install the required packages:

```bash
pip install -r requirements.txt
```

This will install:
- strands-agents[a2a] (version 1.3.0)
- strands-agents-tools (version 0.2.0)
- a2a-sdk[sql] (version 0.3.0)

## Running the A2A Server

To start the A2A server, run:

```bash
python server.py
```

The server will start and expose the Calculator Agent through the A2A protocol. By default, it will listen on `localhost:9000`.

### Accessing Agent Cards

To access the well-known agents cards in this server, navigate to:

```
http://host:port/.well-known/agent-card.json
```

For example, if running locally on the default port:

```
http://localhost:9000/.well-known/agent-card.json
```

This endpoint provides standardized metadata about the agent capabilities according to the A2A protocol.

## Project Structure

- `server.py`: Main script that creates and starts the A2A server with a Calculator Agent
- `requirements.txt`: List of Python dependencies required for the project

## How It Works

The server.py file:
1. Creates a Strands agent with a calculator tool
2. Initializes an A2A server with this agent
3. Starts the server to listen for incoming requests

Other agents can now connect to this server and utilize the calculator functionality through the A2A protocol.