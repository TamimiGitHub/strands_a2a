import os
import json
import requests
import asyncio
import httpx
import argparse
from uuid import uuid4
from urllib.parse import quote
from a2a.client import A2ACardResolver, ClientConfig, ClientFactory

def fetch_agent_card():
    # Get environment variables
    agent_arn = os.environ.get('AGENT_ARN')
    bearer_token = os.environ.get('BEARER_TOKEN')

    if not agent_arn:
        print("Error: AGENT_ARN environment variable not set")
        return

    if not bearer_token:
        print("Error: BEARER_TOKEN environment variable not set")
        return

    # URL encode the agent ARN
    escaped_agent_arn = quote(agent_arn, safe='')
    print(f"Escaped Agent ARN: {escaped_agent_arn}")

    # Construct the URL
    url = f"https://bedrock-agentcore.us-west-2.amazonaws.com/runtimes/{escaped_agent_arn}/invocations/.well-known/agent-card.json"
    print(f"Request URL: {url}")
    

    # Generate a unique session ID
    session_id = str(uuid4())
    print(f"Generated session ID: {session_id}")

    # Set headers
    headers = {
        'Accept': '*/*',
        'Authorization': f'Bearer {bearer_token}',
        'X-Amzn-Bedrock-AgentCore-Runtime-Session-Id': session_id
    }

    try:
        # Make the request
        response = requests.get(url, headers=headers)
        response.raise_for_status()

        # Parse and pretty print JSON
        agent_card = response.json()
        print(json.dumps(agent_card, indent=2))

        return agent_card

    except requests.exceptions.RequestException as e:
        print(f"Error fetching agent card: {e}")
        return None


if __name__ == "__main__":
    # Use the original method by default
    fetch_agent_card()