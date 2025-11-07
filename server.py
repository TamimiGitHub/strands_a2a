from strands import Agent
from strands.multiagent.a2a import A2AServer
from strands_tools.calculator import calculator
import importlib.metadata
import argparse

# Parse command line arguments
parser = argparse.ArgumentParser(description='Start A2A Server with Calculator Agent')
parser.add_argument('-p', '--port', type=int, default=9000, help='Port number (default: 9000)')
args = parser.parse_args()

# Create a Strands agent with calculator tool
# Using Amazon Bedrock default model provider and Claude 3.7 Sonnet as default FM
strands_agent = Agent(
    name="Calculator Agent",
    description="A calculator agent that can perform basic arithmetic operations.",
    tools=[calculator],
    callback_handler=None,
)


# Get version information
try:
    strands_version = importlib.metadata.version("strands-agents")
    a2a_version = importlib.metadata.version("a2a-sdk")
    print(f"Strands version: {strands_version}")
    print(f"A2A SDK version: {a2a_version}")
except Exception as e:
    print(f"Could not determine version information: {e}")

# Create A2A server
a2a_server = A2AServer(agent=strands_agent, host="0.0.0.0", port=args.port)

# Start the server
print(f"Starting A2A Server on http://0.0.0.0:{args.port}")
print(f"Navigate to http://0.0.0.0:{args.port}/.well-known/agent-card.json to get agent card")
a2a_server.serve()
